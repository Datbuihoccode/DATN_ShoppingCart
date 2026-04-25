using Microsoft.AspNetCore.Mvc;
using ShoppingCard.Models;
using ShoppingCard.Models.VNP;
using ShoppingCard.Services.Momo;
using ShoppingCard.Services.Vnpay;
using System.Security.Claims;
using Microsoft.EntityFrameworkCore;
using ShoppingCard.Services;
using ShoppingCard.Repository;

namespace ShoppingCard.Controllers
{
    public class PaymentController : Controller
    {
        private readonly IMomoService _momoService;
        private readonly IVnPayService _vnPayService;
        private readonly IOrderService _orderService;
        private readonly DataContext _dataContext;

        public PaymentController(IMomoService momoService, IVnPayService vnPayService, IOrderService orderService, DataContext dataContext)
        {
            _momoService = momoService;
            _vnPayService = vnPayService;
            _orderService = orderService;
            _dataContext = dataContext;
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> CreatePaymentMomo(OrderInfo model, string shippingPhone)
        {
            var userId = User.FindFirstValue(System.Security.Claims.ClaimTypes.NameIdentifier);
            var userEmail = User.FindFirstValue(System.Security.Claims.ClaimTypes.Email);

            if (string.IsNullOrEmpty(userId)) return RedirectToAction("Login", "Account");

            try
            {
                var couponCode = Request.Cookies["CouponTitle"];
                var order = await _orderService.CreateOrderAsync(userId, userEmail, PaymentMethod.Momo, couponCode, shippingPhone);

                model.OrderId = order.OrderCode;
                model.OrderInformation = "Thanh toán đơn hàng #" + order.OrderCode;
                model.ReturnUrl = Url.Action("PaymentCallBack", "Checkout", null, Request.Scheme);
                model.NotifyUrl = Url.Action("MomoNotify", "Payment", null, Request.Scheme);

                var response = await _momoService.CreatePaymentAsync(model);
                if (response == null || response.ErrorCode != 0 || string.IsNullOrWhiteSpace(response.PayUrl))
                {
                    TempData["error"] = "Lỗi kết nối MoMo.";
                    return RedirectToAction("Index", "Cart");
                }

                return Redirect(response.PayUrl);
            }
            catch (Exception ex)
            {
                TempData["error"] = ex.Message;
                return RedirectToAction("Index", "Cart");
            }
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> CreatePaymentUrlVnPay(PaymentInformationModel model, string shippingPhone)
        {
            var userId = User.FindFirstValue(System.Security.Claims.ClaimTypes.NameIdentifier);
            var userEmail = User.FindFirstValue(System.Security.Claims.ClaimTypes.Email);

            if (string.IsNullOrEmpty(userId)) return RedirectToAction("Login", "Account");

            try
            {
                var couponCode = Request.Cookies["CouponTitle"];
                var order = await _orderService.CreateOrderAsync(userId, userEmail, PaymentMethod.VnPay, couponCode, shippingPhone);

                model.OrderId = order.OrderCode;
                model.OrderDescription = "Thanh toán đơn hàng #" + order.OrderCode;
                model.Name = userEmail;

                var paymentUrl = _vnPayService.CreatePaymentUrl(HttpContext, model);
                return Redirect(paymentUrl);
            }
            catch (Exception ex)
            {
                TempData["error"] = ex.Message;
                return RedirectToAction("Index", "Cart");
            }
        }

        [HttpGet]
        public IActionResult PaymentCallback()
        {
            return Redirect($"/Checkout/PaymentCallBack{Request.QueryString}");
        }

        [HttpGet]
        public IActionResult PaymentCallbackVnPay()
        {
            return Redirect($"/Checkout/PaymentCallBackVnPay{Request.QueryString}");
        }

        /// <summary>
        /// Retry VnPay for an existing Pending order - does NOT create a new order.
        /// </summary>
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> RetryPaymentVnPay(string orderCode, decimal amount)
        {
            var userEmail = User.FindFirstValue(ClaimTypes.NameIdentifier) != null
                ? User.FindFirstValue(System.Security.Claims.ClaimTypes.Email)
                : null;

            if (string.IsNullOrEmpty(userEmail))
                return RedirectToAction("Login", "Account");

            var order = await _dataContext.Orders.FirstOrDefaultAsync(o =>
                o.OrderCode == orderCode && o.UserName == userEmail
                && o.PaymentStatus == PaymentStatus.Pending);

            if (order == null || DateTime.Now > order.CreateDate.AddHours(1))
            {
                TempData["error"] = "Đơn hàng không hợp lệ hoặc đã hết hạn thanh toán.";
                return RedirectToAction("History", "Account");
            }

            var model = new PaymentInformationModel
            {
                OrderId = order.OrderCode,
                Amount = amount,
                OrderDescription = "Thanh toán lại đơn hàng #" + order.OrderCode,
                Name = userEmail,
                OrderType = "other",
                CreatedDate = DateTime.Now
            };

            try
            {
                var paymentUrl = _vnPayService.CreatePaymentUrl(HttpContext, model);
                return Redirect(paymentUrl);
            }
            catch (Exception ex)
            {
                TempData["error"] = "Lỗi tạo link VNPay: " + ex.Message;
                return RedirectToAction("RetryPayment", "Account", new { ordercode = orderCode });
            }
        }

        /// <summary>
        /// Retry MoMo for an existing Pending order - does NOT create a new order.
        /// </summary>
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> RetryPaymentMomo(string orderCode, decimal amount)
        {
            var userEmail = User.FindFirstValue(System.Security.Claims.ClaimTypes.Email);

            if (string.IsNullOrEmpty(userEmail))
                return RedirectToAction("Login", "Account");

            var order = await _dataContext.Orders.FirstOrDefaultAsync(o =>
                o.OrderCode == orderCode && o.UserName == userEmail
                && o.PaymentStatus == PaymentStatus.Pending);

            if (order == null || DateTime.Now > order.CreateDate.AddHours(1))
            {
                TempData["error"] = "Đơn hàng không hợp lệ hoặc đã hết hạn thanh toán.";
                return RedirectToAction("History", "Account");
            }

            var model = new OrderInfo
            {
                OrderId = order.OrderCode,
                Amount = amount,
                OrderInformation = "Thanh toán lại đơn hàng #" + order.OrderCode,
                ReturnUrl = Url.Action("PaymentCallBack", "Checkout", null, Request.Scheme),
                NotifyUrl = Url.Action("MomoNotify", "Payment", null, Request.Scheme)
            };

            try
            {
                var response = await _momoService.CreatePaymentAsync(model);
                if (response == null || response.ErrorCode != 0 || string.IsNullOrWhiteSpace(response.PayUrl))
                {
                    TempData["error"] = "Lỗi kết nối MoMo. Vui lòng thử lại.";
                    return RedirectToAction("RetryPayment", "Account", new { ordercode = orderCode });
                }
                return Redirect(response.PayUrl);
            }
            catch (Exception ex)
            {
                TempData["error"] = "Lỗi tạo link MoMo: " + ex.Message;
                return RedirectToAction("RetryPayment", "Account", new { ordercode = orderCode });
            }
        }

        [HttpPost]
        public async Task<IActionResult> MomoNotify()
        {
            // IPN logic for MoMo
            var orderId = Request.Form["orderId"];
            var resultCode = Request.Form["resultCode"];

            var order = await _dataContext.Orders.FirstOrDefaultAsync(o => o.OrderCode == orderId);
            if (order != null)
            {
                if (resultCode == "0")
                {
                    order.PaymentStatus = PaymentStatus.Paid;
                    order.Status = OrderStatus.Confirmed;
                }
                else
                {
                    // Payment explicitly rejected by MoMo → cancel the order
                    order.PaymentStatus = PaymentStatus.Failed;
                    order.Status = OrderStatus.Cancelled;
                }
                await _dataContext.SaveChangesAsync();
            }

            return Ok();
        }

        [HttpGet]
        public async Task<IActionResult> VnPayIPN()
        {
            // IPN logic for VnPay
            var response = _vnPayService.PaymentExecute(HttpContext.Request.Query);
            var orderId = response.OrderId;

            var order = await _dataContext.Orders.FirstOrDefaultAsync(o => o.OrderCode == orderId);
            if (order != null)
            {
                if (response.VnPayResponseCode == "00")
                {
                    order.PaymentStatus = PaymentStatus.Paid;
                    order.Status = OrderStatus.Confirmed;
                    order.PaymentMethod = "VnPay " + response.TransactionId;
                }
                else
                {
                    // Payment explicitly rejected by VnPay → cancel the order
                    order.PaymentStatus = PaymentStatus.Failed;
                    order.Status = OrderStatus.Cancelled;
                }
                await _dataContext.SaveChangesAsync();
            }

            return Ok(new { RspCode = "00", Message = "Confirm Success" });
        }
    }
}
