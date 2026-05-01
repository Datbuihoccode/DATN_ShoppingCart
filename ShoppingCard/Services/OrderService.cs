using Microsoft.EntityFrameworkCore;
using ShoppingCard.Areas.Admin.Repository;
using ShoppingCard.Models;
using ShoppingCard.Models.Shipping;
using ShoppingCard.Repository;

namespace ShoppingCard.Services
{
    public class OrderService : IOrderService
    {
        private readonly DataContext _dataContext;
        private readonly IEmailSender _emailSender;
        private readonly ILogger<OrderService> _logger;
        private readonly IShippingService _shippingService;

        public OrderService(
            DataContext dataContext,
            IEmailSender emailSender,
            ILogger<OrderService> logger,
            IShippingService shippingService)
        {
            _dataContext = dataContext;
            _emailSender = emailSender;
            _logger = logger;
            _shippingService = shippingService;
        }

        public async Task<OrderModel> CreateOrderAsync(
            string userId,
            string userEmail,
            PaymentMethod method,
            string couponCode = null,
            CheckoutShippingInput shippingInput = null)
        {
            var dbCarts = await _dataContext.Carts
                .Include(c => c.Product)
                .Where(c => c.UserId == userId)
                .ToListAsync();

            if (dbCarts.Count == 0)
            {
                throw new Exception("Giỏ hàng đang trống.");
            }

            decimal discount = 0;
            decimal grandTotal = dbCarts.Sum(x => x.Quantity * (x.Product?.Price ?? 0));

            if (!string.IsNullOrEmpty(couponCode))
            {
                var coupon = await _dataContext.Coupons
                    .FirstOrDefaultAsync(c => c.Name == couponCode && c.Status == 1 && c.Quantity > 0 && c.DateExpired >= DateTime.Today);

                if (coupon != null && grandTotal >= coupon.MinAmount)
                {
                    if (coupon.Type == 1) // Percentage
                    {
                        discount = (grandTotal * coupon.DiscountValue) / 100;
                        if (coupon.MaxDiscountAmount > 0 && discount > coupon.MaxDiscountAmount)
                        {
                            discount = coupon.MaxDiscountAmount;
                        }
                    }
                    else // Fixed
                    {
                        discount = coupon.DiscountValue;
                    }

                    discount = Math.Min(discount, grandTotal);
                    coupon.Quantity -= 1;
                    _dataContext.Update(coupon);
                }
                else
                {
                    couponCode = null;
                }
            }

            decimal shippingFee = 0;
            var hasNewAddress =
                shippingInput != null &&
                shippingInput.ShippingProvinceId > 0 &&
                shippingInput.ShippingWardIdV2 > 0 &&
                !string.IsNullOrWhiteSpace(shippingInput.ShippingAddress);

            var hasLegacyAddress =
                shippingInput != null &&
                shippingInput.ShippingDistrictId > 0 &&
                !string.IsNullOrWhiteSpace(shippingInput.ShippingWardCode);

            var hasFullShippingAddress = hasNewAddress || hasLegacyAddress;

            if (hasFullShippingAddress)
            {
                // Recalculate shipping fee on server to avoid trusting client hidden fields.
                var quote = await _shippingService.GetShippingQuoteAsync(userId, new ShippingQuoteRequest
                {
                    ToDistrictId = hasLegacyAddress ? shippingInput.ShippingDistrictId : 0,
                    ToWardCode = hasLegacyAddress ? shippingInput.ShippingWardCode : null,
                    ToProvinceId = hasNewAddress ? shippingInput.ShippingProvinceId : 0,
                    ToWardIdV2 = hasNewAddress ? shippingInput.ShippingWardIdV2 : 0,
                    ToAddressV2 = hasNewAddress ? shippingInput.ShippingAddress : null
                });

                if (!quote.IsSuccess)
                {
                    throw new Exception(quote.Message);
                }

                shippingFee = quote.Fee;
            }

            var orderCode = Guid.NewGuid().ToString();
            var order = new OrderModel
            {
                OrderCode = orderCode,
                UserName = userEmail,
                CreateDate = DateTime.Now,
                CouponCode = couponCode,
                DiscountAmount = discount,
                Status = OrderStatus.New,
                PaymentStatus = method == PaymentMethod.COD ? PaymentStatus.Unpaid : PaymentStatus.Pending,
                PaymentMethod = method.ToString(),
                ShippingPhone = shippingInput?.ShippingPhone,
                ShippingAddress = hasFullShippingAddress ? shippingInput?.ShippingAddress : null,
                // Lưu province_id vào ShippingDistrictId (tái dụng field cũ)
                ShippingDistrictId = hasFullShippingAddress ? (hasNewAddress ? shippingInput?.ShippingProvinceId : shippingInput?.ShippingDistrictId) : null,
                // Lưu ward_id_v2 vào ShippingWardCode để dùng cho API tính phí sau này
                ShippingWardCode = hasFullShippingAddress ? (hasNewAddress ? shippingInput?.ShippingWardIdV2.ToString() : shippingInput?.ShippingWardCode) : null,
                // Lưu tên tỉnh/phường mới — cần cho API tạo đơn GHN (to_ward_name, to_province_name)
                ShippingProvinceName = hasNewAddress ? shippingInput?.ShippingProvinceName : null,
                ShippingWardName = hasNewAddress ? shippingInput?.ShippingWardName : null,
                ShippingFee = shippingFee,
                ShippingProvider = "GHN"
            };

            _dataContext.Orders.Add(order);

            foreach (var cart in dbCarts)
            {
                var orderDetails = new OrderDetailsModel
                {
                    UserName = userEmail,
                    OrderCode = orderCode,
                    ProductId = cart.ProductId,
                    Price = cart.Product?.Price ?? 0,
                    Quantity = cart.Quantity
                };
                _dataContext.Add(orderDetails);
            }

            // Add history for New status
            _dataContext.OrderHistories.Add(new OrderHistoryModel
            {
                OrderCode = orderCode,
                Status = OrderStatus.New,
                CreatedDate = DateTime.Now,
                Note = "Đơn hàng được tạo."
            });

            // --- Xóa giỏ hàng ngay lập tức cho TẤT CẢ phương thức thanh toán ---
            _dataContext.Carts.RemoveRange(dbCarts);
            
            await _dataContext.SaveChangesAsync();

            // Nếu là COD thì gửi mail luôn
            if (method == PaymentMethod.COD)
            {
                _ = SendEmailSafe(userEmail, orderCode);
            }

            return order;
        }

        public async Task<bool> CompleteOrderAsync(string orderCode)
        {
            var order = await _dataContext.Orders
                .FirstOrDefaultAsync(o => o.OrderCode == orderCode);

            if (order == null || order.PaymentStatus == PaymentStatus.Paid)
            {
                return false;
            }

            order.PaymentStatus = PaymentStatus.Paid;
            // Use UpdateStatusAsync to handle transition, inventory, and history
            var result = await UpdateStatusAsync(orderCode, OrderStatus.Confirmed, "Thanh toán online thành công.");
            
            if (result)
            {
                _ = SendEmailSafe(order.UserName, orderCode);
            }
            return result;
        }

        public async Task<bool> UpdateStatusAsync(string orderCode, OrderStatus newStatus, string note = null)
        {
            var order = await _dataContext.Orders
                .Include(o => o.OrderDetails)
                .FirstOrDefaultAsync(o => o.OrderCode == orderCode);

            if (order == null) return false;

            var oldStatus = order.Status;

            // Rule 6: Không cho update lùi trạng thái
            // Trừ các trạng thái đặc biệt như Cancelled, Returned, ReturnRequested có thể nhảy từ nhiều trạng thái khác
            if (newStatus != OrderStatus.Cancelled && newStatus != OrderStatus.Returned && newStatus != OrderStatus.ReturnRequested)
            {
                if ((int)newStatus <= (int)oldStatus) return false;
            }

            // Rule 6: Không update nếu status giống nhau
            if (newStatus == oldStatus) return false;

            // Logic transition: 
            // New -> Pending -> Confirmed -> Processing -> Shipping -> Delivered -> Completed
            
            // Check if it was already confirmed (to know if we need to restock on cancel)
            bool wasConfirmedOrLater = oldStatus >= OrderStatus.Confirmed && oldStatus <= OrderStatus.Completed;
            bool wasCompleted = oldStatus == OrderStatus.Completed;

            // Update status
            order.Status = newStatus;

            // Logic 2: Trừ kho tại Confirmed
            if (newStatus == OrderStatus.Confirmed)
            {
                foreach (var detail in order.OrderDetails)
                {
                    var product = await _dataContext.Products.FindAsync(detail.ProductId);
                    if (product != null)
                    {
                        product.Quantity -= detail.Quantity;
                        product.Sold += detail.Quantity;
                        _dataContext.Update(product);
                    }
                }
            }

            // Logic 2: Cộng doanh thu tại Completed
            if (newStatus == OrderStatus.Completed)
            {
                var statistical = await _dataContext.Statisticals
                    .FirstOrDefaultAsync(s => s.DateCreated.Date == DateTime.Today);

                decimal totalOrderRevenue = order.OrderDetails.Sum(d => d.Price * d.Quantity) - order.DiscountAmount + order.ShippingFee;

                if (statistical == null)
                {
                    _dataContext.Statisticals.Add(new StatisticalModel
                    {
                        DateCreated = DateTime.Now,
                        Quantity = 1,
                        Revenue = totalOrderRevenue,
                        Sold = order.OrderDetails.Sum(d => d.Quantity)
                    });
                }
                else
                {
                    statistical.Quantity += 1;
                    statistical.Revenue += totalOrderRevenue;
                    statistical.Sold += order.OrderDetails.Sum(d => d.Quantity);
                    _dataContext.Update(statistical);
                }
            }

            // Logic 2: Hoàn kho & Trừ doanh thu khi Cancelled/Returned
            if (newStatus == OrderStatus.Cancelled || newStatus == OrderStatus.Returned)
            {
                // Hoàn kho nếu đã từng trừ kho (từ Confirmed trở đi)
                if (wasConfirmedOrLater || oldStatus == OrderStatus.ReturnRequested || oldStatus == OrderStatus.Approved)
                {
                    foreach (var detail in order.OrderDetails)
                    {
                        var product = await _dataContext.Products.FindAsync(detail.ProductId);
                        if (product != null)
                        {
                            product.Quantity += detail.Quantity;
                            product.Sold -= detail.Quantity;
                            _dataContext.Update(product);
                        }
                    }
                }

                // Trừ doanh thu nếu đơn này đã từng được cộng doanh thu (tức là đã từng qua bước Completed)
                // Trong luồng trả hàng: Completed -> ReturnRequested -> Approved -> Returned
                // Vậy nếu oldStatus là Approved hoặc ReturnRequested hoặc Completed thì đều cần trừ doanh thu
                if (wasCompleted || oldStatus == OrderStatus.ReturnRequested || oldStatus == OrderStatus.Approved)
                {
                    var statistical = await _dataContext.Statisticals
                        .FirstOrDefaultAsync(s => s.DateCreated.Date == order.CreateDate.Date);

                    if (statistical != null)
                    {
                        decimal totalOrderRevenue = order.OrderDetails.Sum(d => d.Price * d.Quantity) - order.DiscountAmount + order.ShippingFee;
                        statistical.Quantity -= 1;
                        statistical.Revenue -= totalOrderRevenue;
                        statistical.Sold -= order.OrderDetails.Sum(d => d.Quantity);
                        _dataContext.Update(statistical);
                    }
                }
            }

            // Logic 8: Order History
            _dataContext.OrderHistories.Add(new OrderHistoryModel
            {
                OrderCode = orderCode,
                Status = newStatus,
                CreatedDate = DateTime.Now,
                Note = note ?? $"Chuyển trạng thái từ {oldStatus} sang {newStatus}"
            });

            await _dataContext.SaveChangesAsync();

            // Auto creation of shipment if moving to Processing or later
            if (newStatus == OrderStatus.Processing || newStatus == OrderStatus.Shipping || newStatus == OrderStatus.Delivered)
            {
                await CreateShipmentIfReadyAsync(orderCode);
            }

            return true;
        }

        public async Task CreateShipmentIfReadyAsync(string orderCode)
        {
            var order = await _dataContext.Orders.FirstOrDefaultAsync(o => o.OrderCode == orderCode);
            if (order == null) return;
            if (order.Status == OrderStatus.Cancelled) return;
            if (!string.IsNullOrWhiteSpace(order.ShippingTrackingCode)) return;
            
            // Chỉ tạo đơn GHN nếu là COD hoặc đã thanh toán (Paid)
            if (order.PaymentMethod != PaymentMethod.COD.ToString() && order.PaymentStatus != PaymentStatus.Paid) return;

            var shipment = await _shippingService.CreateShipmentAsync(orderCode);
            if (!shipment.IsSuccess) return;

            order.ShippingProvider = "GHN";
            order.ShippingTrackingCode = shipment.TrackingCode;
            order.ShippingStatus = string.IsNullOrWhiteSpace(shipment.RawStatus) ? "created" : shipment.RawStatus;
            
            // Khi đã có mã vận đơn, chuyển sang Processing
            await UpdateStatusAsync(orderCode, OrderStatus.Processing, "Đã tạo đơn giao hàng GHN.");
        }

        public async Task RestockOrderItemsAsync(string orderCode)
        {
            // Tái sử dụng logic trong UpdateStatusAsync(Cancelled)
            await UpdateStatusAsync(orderCode, OrderStatus.Cancelled, "Hủy đơn hàng và hoàn kho.");
        }

        public async Task ProcessAutoCompletedOrdersAsync()
        {
            // Lấy các đơn hàng đã giao (Delivered) quá 7 ngày mà chưa chuyển sang Completed
            var deadline = DateTime.Now.AddDays(-7);
            var orders = await _dataContext.Orders
                .Where(o => o.Status == OrderStatus.Delivered && o.CreateDate < deadline)
                .ToListAsync();

            foreach (var order in orders)
            {
                // Kiểm tra lịch sử để chính xác hơn (đã giao được 7 ngày chưa)
                var deliveredHistory = await _dataContext.OrderHistories
                    .Where(oh => oh.OrderCode == order.OrderCode && oh.Status == OrderStatus.Delivered)
                    .OrderByDescending(oh => oh.CreatedDate)
                    .FirstOrDefaultAsync();

                if (deliveredHistory != null && deliveredHistory.CreatedDate < deadline)
                {
                    await UpdateStatusAsync(order.OrderCode, OrderStatus.Completed, "Hệ thống tự động hoàn thành sau 7 ngày giao hàng.");
                }
                else if (deliveredHistory == null && order.CreateDate < deadline)
                {
                    // Fallback nếu không có history (cho các đơn cũ)
                    await UpdateStatusAsync(order.OrderCode, OrderStatus.Completed, "Hệ thống tự động hoàn thành (fallback).");
                }
            }
        }

        private async Task SendEmailSafe(string receiver, string orderCode)
        {
            try
            {
                var subject = "Đặt hàng thành công - #" + orderCode;
                var message = "Đơn hàng của bạn đã được tiếp nhận và đang chờ xử lý.";
                await _emailSender.SendEmailAsync(receiver, subject, message);
            }
            catch (Exception ex)
            {
                _logger.LogWarning(ex, "Failed to send order confirmation email to {Receiver}", receiver);
            }
        }
    }
}
