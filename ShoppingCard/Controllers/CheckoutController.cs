using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using ShoppingCard.Areas.Admin.Repository;
using ShoppingCard.Models;
using ShoppingCard.Repository;
using ShoppingCard.Services.Momo;
using ShoppingCard.Services.Vnpay;
using System.Globalization;
using System.Security.Claims;
using ShoppingCard.Services;

namespace ShoppingCard.Controllers
{
    public class CheckoutController : Controller
    {
        private readonly DataContext _dataContext;
        private readonly IEmailSender _emailSender;
        private readonly ILogger<CheckoutController> _logger;
        private readonly IMomoService _momoService;
        private readonly IVnPayService _vnPayService;
        private readonly IOrderService _orderService;

        public CheckoutController(
            DataContext dataContext,
            IEmailSender emailSender,
            ILogger<CheckoutController> logger,
            IMomoService momoService,
            IVnPayService vnPayService,
            IOrderService orderService)
        {
            _dataContext = dataContext;
            _emailSender = emailSender;
            _logger = logger;
            _momoService = momoService;
            _vnPayService = vnPayService;
            _orderService = orderService;
        }

        public async Task<IActionResult> Checkout(string shippingPhone)
        {
            var userId = User.FindFirstValue(ClaimTypes.NameIdentifier);
            var userEmail = User.FindFirstValue(ClaimTypes.Email);

            if (string.IsNullOrEmpty(userId))
            {
                return RedirectToAction("Login", "Account");
            }

            try
            {
                var couponCode = Request.Cookies["CouponTitle"];
                var order = await _orderService.CreateOrderAsync(userId, userEmail, PaymentMethod.COD, couponCode, shippingPhone);

                TempData["success"] = "Đặt hàng thành công, vui lòng chờ duyệt đơn hàng.";
                return RedirectToAction("History", "Account");
            }
            catch (Exception ex)
            {
                TempData["error"] = ex.Message;
                return RedirectToAction("Index", "Cart");
            }
        }

        [AcceptVerbs("GET", "POST")]
        public async Task<IActionResult> PaymentCallBack()
        {
            // Momo Return URL logic
            var resultCode = Request.Query["resultCode"].ToString();
            var orderId = Request.Query["orderId"].ToString(); // This is the OrderCode from our DB

            if (resultCode == "0")
            {
                await _orderService.CompleteOrderAsync(orderId);
                TempData["success"] = "Thanh toán MoMo thành công!";
            }
            else
            {
                TempData["error"] = "Thanh toán MoMo thất bại hoặc đã bị hủy.";
            }

            return RedirectToAction("History", "Account");
        }

        [HttpGet]
        public async Task<IActionResult> PaymentCallBackVnPay()
        {
            // VnPay Return URL logic
            var response = _vnPayService.PaymentExecute(HttpContext.Request.Query);

            if (response != null && response.Success && response.VnPayResponseCode == "00")
            {
                await _orderService.CompleteOrderAsync(response.OrderId);
                TempData["success"] = "Thanh toán VNPAY thành công!";
            }
            else
            {
                TempData["error"] = "Thanh toán VNPAY thất bại.";
            }

            return RedirectToAction("History", "Account");
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
