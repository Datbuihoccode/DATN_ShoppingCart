using Microsoft.EntityFrameworkCore;
using ShoppingCard.Areas.Admin.Repository;
using ShoppingCard.Models;
using ShoppingCard.Repository;

namespace ShoppingCard.Services
{
    public class OrderService : IOrderService
    {
        private readonly DataContext _dataContext;
        private readonly IEmailSender _emailSender;
        private readonly ILogger<OrderService> _logger;

        public OrderService(DataContext dataContext, IEmailSender emailSender, ILogger<OrderService> logger)
        {
            _dataContext = dataContext;
            _emailSender = emailSender;
            _logger = logger;
        }

        public async Task<OrderModel> CreateOrderAsync(string userId, string userEmail, PaymentMethod method, string couponCode = null, string shippingPhone = null)
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
                ShippingPhone = shippingPhone
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

                // Chỉ trừ tồn kho ngay lập tức nếu là COD
                if (method == PaymentMethod.COD && cart.Product != null)
                {
                    cart.Product.Quantity -= cart.Quantity;
                    cart.Product.Sold += cart.Quantity;
                    _dataContext.Update(cart.Product);
                }
            }

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
                return false; // Đã xử lý hoặc không tìm thấy
            }

            // 1. Cập nhật trạng thái
            order.PaymentStatus = PaymentStatus.Paid;
            order.Status = OrderStatus.Confirmed;

            // 2. Trừ tồn kho và tăng lượt bán
            var details = await _dataContext.OrderDetails.Where(d => d.OrderCode == orderCode).ToListAsync();
            foreach (var detail in details)
            {
                var product = await _dataContext.Products.FindAsync(detail.ProductId);
                if (product != null)
                {
                    product.Quantity -= detail.Quantity;
                    product.Sold += detail.Quantity;
                    _dataContext.Update(product);
                }
            }

            // (Không cần xóa giỏ hàng ở đây nữa vì đã xóa ở CreateOrderAsync)

            await _dataContext.SaveChangesAsync();

            // 3. Gửi mail xác nhận thanh toán thành công
            _ = SendEmailSafe(order.UserName, orderCode);

            return true;
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
