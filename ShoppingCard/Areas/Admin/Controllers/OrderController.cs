using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using ShoppingCard.Application.Interfaces;
using ShoppingCard.Domain.Entities;
using ShoppingCard.Domain.Enums;
using ShoppingCard.Domain.Interfaces;

namespace ShoppingCard.Areas.Admin.Controllers
{
    [Area("Admin")]
    [Authorize(Roles = "Admin,Staff", AuthenticationSchemes = "AdminScheme")]
    public class OrderController : Controller
    {
        private readonly IOrderRepository _orderRepository;
        private readonly UserManager<AppUser> _userManager;
        private readonly IOrderService _orderService;
        private readonly IShippingService _shippingService;

        public OrderController(IOrderRepository orderRepository, UserManager<AppUser> userManager, IOrderService orderService, IShippingService shippingService)
        {
            _orderRepository = orderRepository;
            _userManager = userManager;
            _orderService = orderService;
            _shippingService = shippingService;
        }

        public async Task<IActionResult> Index()
        {
            await _orderService.ProcessAutoCompletedOrdersAsync();
            var orders = await _orderRepository.GetAllAsync();
            return View(orders);
        }

        public async Task<IActionResult> ViewOrder(string odercode)
        {
            if (string.IsNullOrWhiteSpace(odercode))
            {
                return NotFound();
            }

            var order = await _orderRepository.GetByCodeAsync(odercode);
            if (order == null)
            {
                return NotFound();
            }

            var detailsOrder = await _orderRepository.GetOrderDetailsAsync(odercode);

            ViewBag.OrderCode = order.OrderCode;
            ViewBag.CouponCode = order.CouponCode;
            ViewBag.Order = order;
            ViewBag.OrderStatus = order.Status;
            ViewBag.Status = (int)order.Status;

            // Fetch account info to show the "Name" (UserName)
            var customer = await _userManager.FindByEmailAsync(order.UserName) 
                        ?? await _userManager.FindByNameAsync(order.UserName);
            ViewBag.CustomerName = customer?.UserName ?? order.UserName;
            ViewBag.CustomerAddress = customer?.Address;

            return View(detailsOrder);
        }

        [HttpGet]
        public async Task<IActionResult> PaymentMomoInfo(string orderId)
        {
            var order = await _orderRepository.GetByCodeAsync(orderId);
            if (order == null || order.MomoInfo == null)
            {
                return NotFound();
            }
            return View(order.MomoInfo);
        }

        [HttpGet]
        [Route("PaymentVnpayInfo")]
        public async Task<IActionResult> PaymentVnpayInfo(string orderId)
        {
            var order = await _orderRepository.GetByCodeAsync(orderId);
            if (order == null || order.VnpayInfo == null)
            {
                return NotFound();
            }
            return View(order.VnpayInfo);
        }

        [HttpPost]
        [Route("UpdateOrder")]
        public async Task<IActionResult> UpdateOrder(string ordercode, int status, string note = null)
        {
            var result = await _orderService.UpdateStatusAsync(ordercode, (OrderStatus)status, note);
            
            if (result)
            {
                return Ok(new { success = true, message = "Cập nhật trạng thái đơn hàng thành công" });
            }
            else
            {
                return BadRequest(new { success = false, message = "Cập nhật trạng thái thất bại. Vui lòng kiểm tra lại luồng trạng thái." });
            }
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        [Route("DeleteOrder")]
        public async Task<IActionResult> DeleteOrder(string ordercode)
        {
            try
            {
                var result = await _orderService.DeleteOrderAsync(ordercode);
                if (result)
                {
                    TempData["success"] = "Xóa đơn hàng thành công!";
                }
                else
                {
                    TempData["error"] = "Không tìm thấy đơn hàng để xóa.";
                }
            }
            catch (Exception ex)
            {
                TempData["error"] = "Đã xảy ra lỗi khi xóa: " + ex.Message;
            }
            return RedirectToAction(nameof(Index));
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> RetryCreateShipment(string ordercode)
        {
            await _orderService.CreateShipmentIfReadyAsync(ordercode);
            TempData["info"] = "Đã yêu cầu tạo lại vận đơn. Kiểm tra chi tiết đơn hàng.";
            return RedirectToAction(nameof(ViewOrder), new { odercode = ordercode });
        }
    }
}
