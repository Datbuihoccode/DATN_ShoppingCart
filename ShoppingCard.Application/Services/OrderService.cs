using Microsoft.Extensions.Logging;
using ShoppingCard.Application.Interfaces;
using ShoppingCard.Domain.Entities;
using ShoppingCard.Domain.Enums;
using ShoppingCard.Domain.Interfaces;
using Microsoft.AspNetCore.Identity;
using ShoppingCard.Application.DTOs.Shipping;

namespace ShoppingCard.Application.Services
{
    public class OrderService : IOrderService
    {
        private readonly IOrderRepository _orderRepository;
        private readonly IProductRepository _productRepository;
        private readonly ICartRepository _cartRepository;
        private readonly ICouponRepository _couponRepository;
        private readonly IStatisticalRepository _statisticalRepository;
        private readonly IEmailSender _emailSender;
        private readonly ILogger<OrderService> _logger;
        private readonly IShippingService _shippingService;
        private readonly UserManager<AppUser> _userManager;

        public OrderService(
            IOrderRepository orderRepository,
            IProductRepository productRepository,
            ICartRepository cartRepository,
            ICouponRepository couponRepository,
            IStatisticalRepository statisticalRepository,
            IEmailSender emailSender,
            ILogger<OrderService> logger,
            IShippingService shippingService,
            UserManager<AppUser> userManager)
        {
            _orderRepository = orderRepository;
            _productRepository = productRepository;
            _cartRepository = cartRepository;
            _couponRepository = couponRepository;
            _statisticalRepository = statisticalRepository;
            _emailSender = emailSender;
            _logger = logger;
            _shippingService = shippingService;
            _userManager = userManager;
        }

        public async Task<Order> CreateOrderAsync(
            string? userId,
            string userEmail,
            PaymentMethod paymentMethod,
            string couponCode = null,
            CheckoutShippingInput shippingInput = null)
        {
            var cartUserId = userId ?? userEmail;
            var carts = await _cartRepository.GetCartByUserIdAsync(cartUserId);
            var cartList = carts.ToList();

            if (!cartList.Any())
            {
                throw new Exception("Giỏ hàng đang trống.");
            }

            decimal grandTotal = cartList.Sum(x => x.Quantity * x.Product.Price);
            decimal discount = 0;

            if (!string.IsNullOrEmpty(couponCode))
            {
                var coupon = await _couponRepository.GetByNameAsync(couponCode);
                if (coupon != null && coupon.Status == 1 && coupon.Quantity > 0 && coupon.DateExpired >= DateTime.Today && grandTotal >= coupon.MinAmount)
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
                    _couponRepository.Update(coupon);
                }
                else
                {
                    couponCode = null;
                }
            }

            decimal shippingFee = 0;
            if (shippingInput != null && shippingInput.ShippingDistrictId > 0 && !string.IsNullOrEmpty(shippingInput.ShippingWardCode))
            {
                var totalWeight = cartList.Sum(c => (c.Product.WeightGram ?? 0) * c.Quantity);
                if (totalWeight == 0) totalWeight = 2000; // Default weight

                var quote = await _shippingService.GetShippingQuoteAsync(userId, new ShippingQuoteRequest
                {
                    DistrictId = shippingInput.ShippingDistrictId,
                    WardCode = shippingInput.ShippingWardCode,
                    TotalWeight = totalWeight
                });

                if (quote.IsSuccess)
                {
                    shippingFee = quote.Fee;
                }
            }

            var orderCode = Guid.NewGuid().ToString();
            var order = new Order
            {
                OrderCode = orderCode,
                UserName = userEmail,
                CreateDate = DateTime.Now,
                CouponCode = couponCode,
                DiscountAmount = discount,
                Status = OrderStatus.New,
                PaymentStatus = paymentMethod == PaymentMethod.COD ? PaymentStatus.Unpaid : PaymentStatus.Pending,
                PaymentMethod = paymentMethod.ToString(),
                ShippingPhone = shippingInput?.ShippingPhone,
                ShippingAddress = shippingInput?.ShippingAddress,
                ShippingDistrictId = shippingInput?.ShippingDistrictId,
                ShippingWardCode = shippingInput?.ShippingWardCode,
                ShippingProvinceName = shippingInput?.ShippingProvinceName,
                ShippingWardName = shippingInput?.ShippingWardName,
                ShippingFee = shippingFee,
                ShippingProvider = "GHN"
            };

            await _orderRepository.AddAsync(order);

            foreach (var cart in cartList)
            {
                var orderDetail = new OrderDetail
                {
                    OrderCode = orderCode,
                    ProductId = cart.ProductId,
                    Price = cart.Product.Price,
                    Quantity = cart.Quantity
                };
                await _orderRepository.AddOrderDetailAsync(orderDetail);
            }

            await _orderRepository.AddHistoryAsync(new OrderHistory
            {
                OrderCode = orderCode,
                Status = OrderStatus.New,
                CreatedDate = DateTime.Now,
                Note = "Đơn hàng mới, chờ xác nhận."
            });

            // Clear cart
            _cartRepository.RemoveRange(cartList);

            await _orderRepository.SaveChangesAsync();

            // Update user profile
            if (userId != null && shippingInput != null)
            {
                var user = await _userManager.FindByIdAsync(userId);
                if (user != null)
                {
                    bool modified = false;
                    if (string.IsNullOrWhiteSpace(user.Address)) { user.Address = shippingInput.ShippingAddress; modified = true; }
                    // Update other fields if needed
                    if (modified) await _userManager.UpdateAsync(user);
                }
            }

            if (paymentMethod == PaymentMethod.COD)
            {
                _ = SendEmailSafe(userEmail, orderCode);
            }

            return order;
        }

        public async Task<bool> CompleteOrderAsync(string orderCode)
        {
            var order = await _orderRepository.GetByCodeAsync(orderCode);
            if (order == null || order.PaymentStatus == PaymentStatus.Paid) return false;

            order.PaymentStatus = PaymentStatus.Paid;
            
            await _orderRepository.AddHistoryAsync(new OrderHistory
            {
                OrderCode = orderCode,
                Status = order.Status,
                CreatedDate = DateTime.Now,
                Note = "Thanh toán online thành công. Chờ Admin xác nhận đơn."
            });

            await _orderRepository.SaveChangesAsync();
            _ = SendEmailSafe(order.UserName, orderCode);
            return true;
        }

        public async Task<bool> UpdateStatusAsync(string orderCode, OrderStatus newStatus, string note = null)
        {
            var order = await _orderRepository.GetByCodeAsync(orderCode);
            if (order == null) return false;

            var oldStatus = order.Status;
            if (newStatus == oldStatus) return false;

            bool wasConfirmedOrLater = (int)oldStatus >= (int)OrderStatus.Confirmed;

            // Simple validation: don't allow backward transition unless specific cases
            if (newStatus != OrderStatus.Cancelled && newStatus != OrderStatus.Returned && newStatus != OrderStatus.ReturnRequested)
            {
                if ((int)newStatus <= (int)oldStatus) return false;
            }

            order.Status = newStatus;

            // Business Logic: Stock management
            if (newStatus == OrderStatus.Confirmed)
            {
                foreach (var detail in order.OrderDetails)
                {
                    var product = await _productRepository.GetByIdAsync(detail.ProductId);
                    if (product != null)
                    {
                        product.Quantity -= detail.Quantity;
                        product.Sold += detail.Quantity;
                        _productRepository.Update(product);
                    }
                }
            }
            
            // Logic: Cộng doanh thu tại Completed
            if (newStatus == OrderStatus.Completed)
            {
                var totalRevenue = order.OrderDetails.Sum(d => d.Price * d.Quantity) - order.DiscountAmount + order.ShippingFee;
                var stats = await _statisticalRepository.GetByDateAsync(DateTime.Today);
                if (stats == null)
                {
                    await _statisticalRepository.AddAsync(new Statistical
                    {
                        DateCreated = DateTime.Now,
                        Quantity = 1,
                        Revenue = totalRevenue,
                        Sold = order.OrderDetails.Sum(d => d.Quantity)
                    });
                }
                else
                {
                    stats.Quantity += 1;
                    stats.Revenue += totalRevenue;
                    stats.Sold += order.OrderDetails.Sum(d => d.Quantity);
                    _statisticalRepository.Update(stats);
                }
            }

            // Logic: Hoàn kho & Trừ doanh thu khi Cancelled/Returned
            if (newStatus == OrderStatus.Cancelled || newStatus == OrderStatus.Returned)
            {
                if (wasConfirmedOrLater)
                {
                    foreach (var detail in order.OrderDetails)
                    {
                        var product = await _productRepository.GetByIdAsync(detail.ProductId);
                        if (product != null)
                        {
                            product.Quantity += detail.Quantity;
                            product.Sold -= detail.Quantity;
                            _productRepository.Update(product);
                        }
                    }
                }

                if (oldStatus == OrderStatus.Completed)
                {
                    var stats = await _statisticalRepository.GetByDateAsync(order.CreateDate);
                    if (stats != null)
                    {
                        var totalRevenue = order.OrderDetails.Sum(d => d.Price * d.Quantity) - order.DiscountAmount + order.ShippingFee;
                        stats.Quantity -= 1;
                        stats.Revenue -= totalRevenue;
                        stats.Sold -= order.OrderDetails.Sum(d => d.Quantity);
                        _statisticalRepository.Update(stats);
                    }
                }
            }

            await _orderRepository.AddHistoryAsync(new OrderHistory
            {
                OrderCode = orderCode,
                Status = newStatus,
                CreatedDate = DateTime.Now,
                Note = note ?? GetStatusDescription(newStatus)
            });

            await _orderRepository.SaveChangesAsync();

            // Shipping integration
            if (newStatus == OrderStatus.Processing || newStatus == OrderStatus.Shipping)
            {
                await CreateShipmentIfReadyAsync(orderCode);
            }

            return true;
        }

        public async Task CreateShipmentIfReadyAsync(string orderCode)
        {
            var order = await _orderRepository.GetByCodeAsync(orderCode);
            if (order == null || !string.IsNullOrWhiteSpace(order.ShippingTrackingCode)) return;

            var result = await _shippingService.CreateShipmentAsync(orderCode);
            if (result.IsSuccess)
            {
                order.ShippingTrackingCode = result.TrackingCode;
                _orderRepository.Update(order);
                await _orderRepository.SaveChangesAsync();
            }
        }

        public async Task RestockOrderItemsAsync(string orderCode)
        {
            await UpdateStatusAsync(orderCode, OrderStatus.Cancelled, "Hủy đơn hàng và hoàn kho.");
        }

        public async Task<Order> GetOrderByCodeAsync(string orderCode)
        {
            return await _orderRepository.GetByCodeAsync(orderCode);
        }

        public async Task ProcessAutoCompletedOrdersAsync()
        {
            // Logic for auto-completion after delivery
            var orders = await _orderRepository.GetAllAsync();
            var deliveredOrders = orders.Where(o => o.Status == OrderStatus.Delivered);
            
            foreach(var order in deliveredOrders)
            {
                // Simple version: auto complete after 24h
                if (order.CreateDate < DateTime.Now.AddDays(-1))
                {
                    await UpdateStatusAsync(order.OrderCode, OrderStatus.Completed, "Tự động hoàn thành.");
                }
            }
        }

        public async Task<bool> DeleteOrderAsync(string orderCode)
        {
            var order = await _orderRepository.GetByCodeAsync(orderCode);
            if (order == null) return false;

            _orderRepository.Delete(order);
            await _orderRepository.SaveChangesAsync();
            return true;
        }

        private async Task SendEmailSafe(string receiver, string orderCode)
        {
            try
            {
                await _emailSender.SendEmailAsync(receiver, "Đặt hàng thành công", "Đơn hàng " + orderCode + " đã được tiếp nhận.");
            }
            catch (Exception ex)
            {
                _logger.LogWarning(ex, "Failed to send email");
            }
        }

        private string GetStatusDescription(OrderStatus status)
        {
            return status.ToString(); // Simplified for now
        }
    }
}
