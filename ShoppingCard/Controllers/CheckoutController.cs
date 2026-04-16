using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using ShoppingCard.Areas.Admin.Repository;
using ShoppingCard.Models;
using ShoppingCard.Repository;
using ShoppingCard.Services.Momo;
using ShoppingCard.Services.Vnpay;
using System.Globalization;
using System.Security.Claims;

namespace ShoppingCard.Controllers
{
    public class CheckoutController : Controller
    {
        private readonly DataContext _dataContext;
        private readonly IEmailSender _emailSender;
        private readonly IMomoService _momoService;
        private readonly IVnPayService _vnPayService;

        public CheckoutController(DataContext dataContext, IEmailSender emailSender, IMomoService momoService, IVnPayService vnPayService)
        {
            _dataContext = dataContext;
            _emailSender = emailSender;
            _momoService = momoService;
            _vnPayService = vnPayService;
        }

        public async Task<IActionResult> Checkout(string orderId = null)
        {
            var checkoutResult = await CreateOrderFromCartAsync(orderId);
            if (!checkoutResult.Success)
            {
                TempData["error"] = checkoutResult.Message;
                return RedirectToAction("Index", "Cart");
            }

            TempData["Success"] = string.IsNullOrWhiteSpace(orderId)
                ? "Thanh toán thành công, vui lòng chờ duyệt đơn hàng."
                : "Giao dịch thanh toán thành công, đơn hàng đã được tạo.";

            return RedirectToAction("History", "Account");
        }

        [HttpGet]
        public async Task<IActionResult> PaymentCallBack()
        {
            _momoService.PaymentExecuteAsync(HttpContext.Request.Query);
            var requestQuery = HttpContext.Request.Query;
            var resultCode = requestQuery["resultCode"].ToString();

            if (!string.Equals(resultCode, "0", StringComparison.Ordinal))
            {
                TempData["error"] = "Giao dịch Momo không thành công.";
                return RedirectToAction("Index", "Cart");
            }

            var orderId = requestQuery["orderId"].ToString();
            if (string.IsNullOrWhiteSpace(orderId))
            {
                TempData["error"] = "Không nhận được mã giao dịch Momo.";
                return RedirectToAction("Index", "Cart");
            }

            var userEmail = User.FindFirstValue(ClaimTypes.Email);
            if (string.IsNullOrWhiteSpace(userEmail))
            {
                TempData["error"] = "Vui lòng đăng nhập lại để hoàn tất giao dịch Momo.";
                return RedirectToAction("Login", "Account");
            }

            var paymentMethod = $"MOMO-{orderId}";
            var hasMomoInfo = await _dataContext.MomoInfos.AnyAsync(m => m.OrderId == orderId);
            if (!hasMomoInfo)
            {
                var newMomoInsert = new MomoInfoModel
                {
                    OrderId = orderId,
                    FullName = userEmail,
                    Amount = ParseAmount(requestQuery["amount"].ToString()),
                    OrderInfo = requestQuery["orderInfo"].ToString(),
                    DatePaid = DateTime.Now
                };

                _dataContext.Add(newMomoInsert);
                await _dataContext.SaveChangesAsync();
            }

            var hasOrder = await _dataContext.Orders
                .AnyAsync(o => (o.PaymentMethod == paymentMethod || o.PaymentMethod == orderId) && o.UserName == userEmail);

            if (hasOrder)
            {
                TempData["Success"] = "Giao dich Momo da duoc ghi nhan truoc do.";
                return RedirectToAction("History", "Account");
            }

            return await Checkout(paymentMethod);
        }

        [HttpGet]
        public async Task<IActionResult> PaymentCallBackVnPay()
        {
            var response = _vnPayService.PaymentExecute(HttpContext.Request.Query);

            if (response == null || !response.Success || !string.Equals(response.VnPayResponseCode, "00", StringComparison.Ordinal))
            {
                var responseCode = response?.VnPayResponseCode ?? "UNKNOWN";
                TempData["error"] = $"Giao dịch VNPay không thành công. Mã lỗi: {responseCode}.";
                return RedirectToAction("Index", "Cart");
            }

            var userEmail = User.FindFirstValue(ClaimTypes.Email);
            if (string.IsNullOrWhiteSpace(userEmail))
            {
                TempData["error"] = "Vui lòng đăng nhập lại để hoàn tất giao dịch VNPay.";
                return RedirectToAction("Login", "Account");
            }

            var paymentRef = response.OrderId;
            if (string.IsNullOrWhiteSpace(paymentRef))
            {
                paymentRef = response.PaymentId;
            }

            if (string.IsNullOrWhiteSpace(paymentRef))
            {
                paymentRef = response.TransactionId;
            }

            if (string.IsNullOrWhiteSpace(paymentRef))
            {
                TempData["error"] = "Không nhận được mã giao dịch VNPay.";
                return RedirectToAction("Index", "Cart");
            }

            var paymentMethod = $"VNPAY-{paymentRef}";

            var hasVnpayInfo = !string.IsNullOrWhiteSpace(response.OrderId) &&
                await _dataContext.VnpayInfos.AnyAsync(v => v.OrderId == response.OrderId);

            if (!hasVnpayInfo)
            {
                var newVnpayInsert = new VnpayModel
                {
                    OrderId = response.OrderId,
                    PaymentMethod = response.PaymentMethod,
                    OrderDescription = response.OrderDescription,
                    TransactionId = response.TransactionId,
                    PaymentId = response.PaymentId,
                    DateCreated = DateTime.Now
                };

                _dataContext.Add(newVnpayInsert);
            }

            var hasOrder = await _dataContext.Orders
                .AnyAsync(o => o.PaymentMethod == paymentMethod && o.UserName == userEmail);

            if (hasOrder)
            {
                TempData["success"] = "Giao dich VNPay da duoc ghi nhan truoc do.";
                if (!hasVnpayInfo)
                {
                    await _dataContext.SaveChangesAsync();
                }

                return RedirectToAction("Index", "Cart");
            }

            var checkoutResult = await CreateOrderFromCartAsync(paymentMethod);
            if (!checkoutResult.Success)
            {
                TempData["error"] = checkoutResult.Message;
                return RedirectToAction("Index", "Cart");
            }

            TempData["success"] = "Giao dịch VNPay thành công.";
            return RedirectToAction("Index", "Cart");
        }

        private async Task<(bool Success, string Message)> CreateOrderFromCartAsync(string orderId)
        {
            var userEmail = User.FindFirstValue(ClaimTypes.Email);
            var userId = User.FindFirstValue(ClaimTypes.NameIdentifier);

            if (string.IsNullOrWhiteSpace(userEmail) || string.IsNullOrWhiteSpace(userId))
            {
                return (false, "Vui lòng đăng nhập để tiếp tục thanh toán.");
            }

            var dbCarts = await _dataContext.Carts.Include(c => c.Product).Where(c => c.UserId == userId).ToListAsync();

            List<CartItemModel> cartItems = dbCarts.Select(c => new CartItemModel {
                ProductId = c.ProductId,
                Price = c.Product?.Price ?? 0,
                Quantity = c.Quantity
            }).ToList();

            if (cartItems.Count == 0)
            {
                return (false, "Gio hang dang trong.");
            }

            var couponCode = Request.Cookies["CouponTitle"];
            var paymentMethod = string.IsNullOrWhiteSpace(orderId) ? "COD" : orderId;

            var orderCode = Guid.NewGuid().ToString();
            var orderItem = new OrderModel
            {
                OrderCode = orderCode,
                UserName = userEmail,
                Status = 1,
                CreateDate = DateTime.Now,
                CouponCode = couponCode,
                PaymentMethod = paymentMethod
            };

            _dataContext.Orders.Add(orderItem);

            foreach (var cart in cartItems)
            {
                var orderDetails = new OrderDetailsModel
                {
                    UserName = userEmail,
                    OrderCode = orderCode,
                    ProductId = cart.ProductId,
                    Price = cart.Price,
                    Quantity = cart.Quantity
                };

                var product = await _dataContext.Products.FirstOrDefaultAsync(p => p.Id == cart.ProductId);
                if (product != null)
                {
                    product.Quantity -= cart.Quantity;
                    product.Sold += cart.Quantity;
                    _dataContext.Update(product);
                }

                _dataContext.Add(orderDetails);
            }

            _dataContext.Carts.RemoveRange(dbCarts);
            await _dataContext.SaveChangesAsync();

            HttpContext.Session.Remove("Cart"); // remove just in case
            Response.Cookies.Delete("CouponTitle");

            var receiver = "1977datbui@gmail.com";
            var subject = "Đặt hàng thành công.";
            var message = "Đơn hàng đang được xử lý.";
            await _emailSender.SendEmailAsync(receiver, subject, message);

            return (true, "Success");
        }

        private static decimal ParseAmount(string amountText)
        {
            if (decimal.TryParse(amountText, NumberStyles.Number, CultureInfo.InvariantCulture, out var amountByInvariant))
            {
                return amountByInvariant;
            }

            if (decimal.TryParse(amountText, NumberStyles.Number, CultureInfo.CurrentCulture, out var amountByCurrent))
            {
                return amountByCurrent;
            }

            return 0m;
        }
    }
}
