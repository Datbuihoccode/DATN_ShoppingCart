using Microsoft.AspNetCore.Mvc;
using ShoppingCard.Models;
using ShoppingCard.Models.Shipping;
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
        public async Task<IActionResult> CreatePaymentMomo(OrderInfo model, CheckoutShippingInput shippingInput)
        {
            var userId = User.FindFirstValue(ClaimTypes.NameIdentifier);
            var userEmail = User.FindFirstValue(ClaimTypes.Email);
            if (string.IsNullOrEmpty(userId)) return RedirectToAction("Login", "Account");

            try
            {
                var couponCode = Request.Cookies["CouponTitle"];
                var order = await _orderService.CreateOrderAsync(userId, userEmail, PaymentMethod.Momo, couponCode, shippingInput);

                model.OrderId = order.OrderCode;
                model.OrderInformation = "Thanh toan don hang #" + order.OrderCode;
                model.Amount = await GetOrderFinalTotalAsync(order.OrderCode);
                model.ReturnUrl = Url.Action("PaymentCallBack", "Checkout", null, Request.Scheme);
                model.NotifyUrl = Url.Action("MomoNotify", "Payment", null, Request.Scheme);

                var response = await _momoService.CreatePaymentAsync(model);
                if (response == null || response.ErrorCode != 0 || string.IsNullOrWhiteSpace(response.PayUrl))
                {
                    TempData["error"] = "Loi ket noi MoMo.";
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
        public async Task<IActionResult> CreatePaymentUrlVnPay(PaymentInformationModel model, CheckoutShippingInput shippingInput)
        {
            var userId = User.FindFirstValue(ClaimTypes.NameIdentifier);
            var userEmail = User.FindFirstValue(ClaimTypes.Email);
            if (string.IsNullOrEmpty(userId)) return RedirectToAction("Login", "Account");

            try
            {
                var couponCode = Request.Cookies["CouponTitle"];
                var order = await _orderService.CreateOrderAsync(userId, userEmail, PaymentMethod.VnPay, couponCode, shippingInput);

                model.OrderId = order.OrderCode;
                model.OrderDescription = "Thanh toan don hang #" + order.OrderCode;
                model.Name = userEmail;
                model.Amount = await GetOrderFinalTotalAsync(order.OrderCode);

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

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> RetryPaymentVnPay(string orderCode, decimal amount)
        {
            var userEmail = User.FindFirstValue(ClaimTypes.NameIdentifier) != null
                ? User.FindFirstValue(ClaimTypes.Email)
                : null;

            if (string.IsNullOrEmpty(userEmail))
                return RedirectToAction("Login", "Account");

            var order = await _dataContext.Orders.FirstOrDefaultAsync(o =>
                o.OrderCode == orderCode && o.UserName == userEmail
                && o.PaymentStatus == PaymentStatus.Pending);

            if (order == null || DateTime.Now > order.CreateDate.AddHours(1))
            {
                TempData["error"] = "Don hang khong hop le hoac da het han thanh toan.";
                return RedirectToAction("History", "Account");
            }

            var model = new PaymentInformationModel
            {
                OrderId = order.OrderCode,
                Amount = amount,
                OrderDescription = "Thanh toan lai don hang #" + order.OrderCode,
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
                TempData["error"] = "Loi tao link VNPay: " + ex.Message;
                return RedirectToAction("RetryPayment", "Account", new { ordercode = orderCode });
            }
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> RetryPaymentMomo(string orderCode, decimal amount)
        {
            var userEmail = User.FindFirstValue(ClaimTypes.Email);
            if (string.IsNullOrEmpty(userEmail))
                return RedirectToAction("Login", "Account");

            var order = await _dataContext.Orders.FirstOrDefaultAsync(o =>
                o.OrderCode == orderCode && o.UserName == userEmail
                && o.PaymentStatus == PaymentStatus.Pending);

            if (order == null || DateTime.Now > order.CreateDate.AddHours(1))
            {
                TempData["error"] = "Don hang khong hop le hoac da het han thanh toan.";
                return RedirectToAction("History", "Account");
            }

            var model = new OrderInfo
            {
                OrderId = order.OrderCode,
                Amount = amount,
                OrderInformation = "Thanh toan lai don hang #" + order.OrderCode,
                ReturnUrl = Url.Action("PaymentCallBack", "Checkout", null, Request.Scheme),
                NotifyUrl = Url.Action("MomoNotify", "Payment", null, Request.Scheme)
            };

            try
            {
                var response = await _momoService.CreatePaymentAsync(model);
                if (response == null || response.ErrorCode != 0 || string.IsNullOrWhiteSpace(response.PayUrl))
                {
                    TempData["error"] = "Loi ket noi MoMo. Vui long thu lai.";
                    return RedirectToAction("RetryPayment", "Account", new { ordercode = orderCode });
                }
                return Redirect(response.PayUrl);
            }
            catch (Exception ex)
            {
                TempData["error"] = "Loi tao link MoMo: " + ex.Message;
                return RedirectToAction("RetryPayment", "Account", new { ordercode = orderCode });
            }
        }

        [HttpPost]
        public async Task<IActionResult> MomoNotify()
        {
            var orderId = Request.Form["orderId"];
            var resultCode = Request.Form["resultCode"];

            var order = await _dataContext.Orders.FirstOrDefaultAsync(o => o.OrderCode == orderId);
            if (order != null)
            {
                if (resultCode == "0")
                {
                    await _orderService.CompleteOrderAsync(orderId);
                }
                else
                {
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
            var response = _vnPayService.PaymentExecute(HttpContext.Request.Query);
            var orderId = response.OrderId;

            var order = await _dataContext.Orders.FirstOrDefaultAsync(o => o.OrderCode == orderId);
            if (order != null)
            {
                if (response.VnPayResponseCode == "00")
                {
                    await _orderService.CompleteOrderAsync(orderId);
                }
                else
                {
                    order.PaymentStatus = PaymentStatus.Failed;
                    order.Status = OrderStatus.Cancelled;
                }
                await _dataContext.SaveChangesAsync();
            }

            return Ok(new { RspCode = "00", Message = "Confirm Success" });
        }

        private async Task<decimal> GetOrderFinalTotalAsync(string orderCode)
        {
            var order = await _dataContext.Orders.FirstOrDefaultAsync(o => o.OrderCode == orderCode);
            if (order == null) return 0m;

            var subtotal = await _dataContext.OrderDetails
                .Where(od => od.OrderCode == orderCode)
                .SumAsync(od => od.Price * od.Quantity);

            var total = subtotal - order.DiscountAmount + order.ShippingFee;
            return total < 0 ? 0 : total;
        }
    }
}
