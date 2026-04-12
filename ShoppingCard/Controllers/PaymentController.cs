using Microsoft.AspNetCore.Mvc;
using ShoppingCard.Models;
using ShoppingCard.Models.VNP;
using ShoppingCard.Services.Momo;
using ShoppingCard.Services.Vnpay;

namespace ShoppingCard.Controllers
{
    public class PaymentController : Controller
    {
        private readonly IMomoService _momoService;
        private readonly IVnPayService _vnPayService;

        public PaymentController(IMomoService momoService, IVnPayService vnPayService)
        {
            _momoService = momoService;
            _vnPayService = vnPayService;
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> CreatePaymentMomo(OrderInfo model)
        {
            if (model == null || model.Amount <= 0)
            {
                TempData["error"] = "Số tiền thanh toán không hợp lệ.";
                return RedirectToAction("Index", "Cart");
            }

            model.ReturnUrl ??= Url.Action("PaymentCallBack", "Checkout", null, Request.Scheme) ?? string.Empty;
            model.NotifyUrl ??= Url.Action("MomoNotify", "Payment", null, Request.Scheme) ?? string.Empty;

            var response = await _momoService.CreatePaymentAsync(model);
            if (response == null || response.ErrorCode != 0 || string.IsNullOrWhiteSpace(response.PayUrl))
            {
                TempData["error"] = response == null
                    ? "Không tạo được liên kết thanh toán MoMo."
                    : $"{response.Message} (code: {response.ErrorCode})";
                return RedirectToAction("Index", "Cart");
            }

            return Redirect(response.PayUrl);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public IActionResult CreatePaymentUrlVnPay(PaymentInformationModel model)
        {
            if (model == null || model.Amount <= 0)
            {
                TempData["error"] = "Số tiền thanh toán VNPay không hợp lệ.";
                return RedirectToAction("Index", "Cart");
            }

            model.CreatedDate = DateTime.Now;
            model.Name ??= User.Identity?.Name ?? "Khach";
            model.OrderDescription ??= "Thanh toán đơn hàng tại ShoppingCard";
            model.OrderType ??= "other";

            try
            {
                var paymentUrl = _vnPayService.CreatePaymentUrl(HttpContext, model);
                return Redirect(paymentUrl);
            }
            catch (Exception ex)
            {
                TempData["error"] = $"Không tạo được liên kết thanh toán VNPay: {ex.Message}";
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

        [HttpPost]
        public IActionResult MomoNotify()
        {
            return Ok();
        }
    }
}
