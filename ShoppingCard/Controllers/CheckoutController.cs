using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using ShoppingCard.Models;
using ShoppingCard.Repository;
using ShoppingCard.Areas.Admin.Repository;
using ShoppingCard.Services.Momo;
using ShoppingCard.Services.Vnpay;
using System.Globalization;
using System.Security.Claims;
using ShoppingCard.Services;
using ShoppingCard.Models.Shipping;
using System.Text.Json;

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
        private readonly IShippingService _shippingService;

        public CheckoutController(
            DataContext dataContext,
            IEmailSender emailSender,
            ILogger<CheckoutController> logger,
            IMomoService momoService,
            IVnPayService vnPayService,
            IOrderService orderService,
            IShippingService shippingService)
        {
            _dataContext = dataContext;
            _emailSender = emailSender;
            _logger = logger;
            _momoService = momoService;
            _vnPayService = vnPayService;
            _orderService = orderService;
            _shippingService = shippingService;
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Checkout(CheckoutShippingInput shippingInput)
        {
            var userId = ShoppingCard.Library.CartHelper.GetUserId(HttpContext);
            var userEmail = User.FindFirstValue(ClaimTypes.Email) ?? shippingInput.ShippingEmail;

            if (string.IsNullOrEmpty(userEmail))
            {
                TempData["error"] = "Vui lòng cung cấp email để đặt hàng.";
                return RedirectToAction("Index", "Cart");
            }

            try
            {
                var couponCode = Request.Cookies["CouponTitle"];
                var order = await _orderService.CreateOrderAsync(userId, userEmail, PaymentMethod.COD, couponCode, shippingInput);

                TempData["success"] = "Đặt hàng thành công, vui lòng chờ duyệt đơn hàng.";
                return RedirectToAction("Success", new { orderCode = order.OrderCode });
            }
            catch (Exception ex)
            {
                TempData["error"] = ex.Message;
                return RedirectToAction("Index", "Cart");
            }
        }

        [HttpPost]
        [IgnoreAntiforgeryToken]
        public async Task<IActionResult> QuoteShipping(ShippingQuoteRequest request)
        {
            var userId = ShoppingCard.Library.CartHelper.GetUserId(HttpContext);

            var quote = await _shippingService.GetShippingQuoteAsync(userId, request);
            if (!quote.IsSuccess)
            {
                return BadRequest(new { success = false, message = quote.Message });
            }

            return Ok(new { success = true, shippingFee = quote.Fee, message = quote.Message });
        }

        [HttpGet]
        public async Task<IActionResult> ShippingProvinces()
        {
            var items = await _shippingService.GetProvincesAsync();
            if (items.Count == 0)
            {
                return BadRequest(new { success = false, message = "Không thể lấy danh sách tỉnh thành từ GHN." });
            }
            return Ok(items);
        }

        [HttpGet]
        public async Task<IActionResult> ShippingWards(string provinceCode)
        {
            if (string.IsNullOrWhiteSpace(provinceCode)) return BadRequest(new List<ShippingLocationModel>());
            var items = await _shippingService.GetWardsAsync(provinceCode);
            return Ok(items);
        }

        [HttpPost]
        [IgnoreAntiforgeryToken]
        public async Task<IActionResult> ShippingWebhook([FromBody] JsonElement payload)
        {
            string trackingCode = "";
            string status = "";

            if (payload.ValueKind == JsonValueKind.Object)
            {
                if (payload.TryGetProperty("OrderCode", out var oc)) trackingCode = oc.GetString() ?? "";
                if (payload.TryGetProperty("Status", out var st)) status = st.GetString() ?? "";
            }

            if (string.IsNullOrWhiteSpace(trackingCode))
            {
                return BadRequest(new { success = false, message = "Missing tracking code." });
            }

            var order = await _dataContext.Orders.FirstOrDefaultAsync(o => o.ShippingTrackingCode == trackingCode);
            if (order == null) 
            {
                return NotFound(new { success = false, message = $"Không tìm thấy đơn hàng với mã vận đơn: {trackingCode}" });
            }

            order.ShippingStatus = status;
            
            if (_shippingService.TryMapWebhookStatus(status, out var mappedStatus))
            {
                // Sử dụng UpdateStatusAsync để xử lý tập trung logic mapping, history, stock, revenue
                await _orderService.UpdateStatusAsync(order.OrderCode, mappedStatus, $"GHN Webhook: {status}");
            }
            else
            {
                await _dataContext.SaveChangesAsync();
            }

            return Ok(new { success = true, message = $"Đã cập nhật trạng thái đơn hàng {trackingCode} thành {status}" });
        }

        [AcceptVerbs("GET", "POST")]
        public async Task<IActionResult> PaymentCallBack()
        {
            var resultCode = Request.Query["resultCode"].ToString();
            var orderId = Request.Query["orderId"].ToString();

            if (resultCode == "0")
            {
                await _orderService.CompleteOrderAsync(orderId);
                TempData["success"] = "Thanh toán MoMo thành công!";
                return RedirectToAction("Success", new { orderCode = orderId });
            }
            else
            {
                TempData["error"] = "Thanh toán MoMo thất bại hoặc đã bị hủy.";
                return RedirectToAction("Index", "Cart");
            }
        }

        [HttpGet]
        public async Task<IActionResult> PaymentCallBackVnPay()
        {
            var response = _vnPayService.PaymentExecute(HttpContext.Request.Query);

            if (response != null && response.Success && response.VnPayResponseCode == "00")
            {
                await _orderService.CompleteOrderAsync(response.OrderId);
                TempData["success"] = "Thanh toán VNPAY thành công!";
                return RedirectToAction("Success", new { orderCode = response.OrderId });
            }
            else
            {
                TempData["error"] = "Thanh toán VNPAY thất bại.";
                return RedirectToAction("Index", "Cart");
            }
        }

        [HttpGet]
        public async Task<IActionResult> Success(string orderCode)
        {
            if (string.IsNullOrWhiteSpace(orderCode)) return RedirectToAction("Index", "Home");
            
            var order = await _dataContext.Orders.FirstOrDefaultAsync(o => o.OrderCode == orderCode);
            if (order == null) return NotFound();

            return View(order);
        }
    }
}
