using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using ShoppingCard.Models;
using ShoppingCard.Repository;
using ShoppingCard.Services;

namespace ShoppingCard.Areas.Admin.Controllers
{
    [Area("Admin")]
    [Authorize(Roles = "Admin,Staff", AuthenticationSchemes = "AdminScheme")]
    public class OrderController : Controller
    {
        private readonly DataContext _dataContext;
        private readonly UserManager<AppUserModel> _userManager;
        private readonly IOrderService _orderService;
        private readonly IShippingService _shippingService;

        public OrderController(DataContext context, UserManager<AppUserModel> userManager, IOrderService orderService, IShippingService shippingService)
        {
            _dataContext = context;
            _userManager = userManager;
            _orderService = orderService;
            _shippingService = shippingService;
        }

        public async Task<IActionResult> Index()
        {
            await _orderService.ProcessAutoCompletedOrdersAsync();
            return View(await _dataContext.Orders.OrderByDescending(p => p.Id).ToListAsync());
        }

        public async Task<IActionResult> ViewOrder(string odercode)
        {
            if (string.IsNullOrWhiteSpace(odercode))
            {
                return NotFound();
            }

            var order = await _dataContext.Orders
                .Include(o => o.OrderHistories)
                .AsNoTracking()
                .FirstOrDefaultAsync(o => o.OrderCode == odercode);
            if (order == null)
            {
                return NotFound();
            }

            var detailsOrder = await _dataContext.OrderDetails
                .Include(od => od.Product)
                .Where(od => od.OrderCode == odercode)
                .ToListAsync();

            ViewBag.OrderCode = order.OrderCode;
            ViewBag.CouponCode = order.CouponCode;
            ViewBag.Order = order;
            ViewBag.OrderStatus = order.Status;
            ViewBag.Status = (int)order.Status;

            // Fetch account info to show the "Name" (UserName)
            var customer = await _userManager.FindByEmailAsync(order.UserName) 
                        ?? await _userManager.FindByNameAsync(order.UserName);
            ViewBag.CustomerName = customer?.UserName ?? order.UserName;

            return View(detailsOrder);
        }

        [HttpGet]
        public async Task<IActionResult> PaymentMomoInfo(string orderId)
        {
            if (string.IsNullOrWhiteSpace(orderId))
            {
                return NotFound();
            }

            var momoInfo = await _dataContext.MomoInfos
                .AsNoTracking()
                .FirstOrDefaultAsync(m => m.OrderId == orderId);

            if (momoInfo == null)
            {
                return NotFound();
            }

            return View(momoInfo);
        }

        [HttpGet]
        [Route("PaymentVnpayInfo")]
        public async Task<IActionResult> PaymentVnpayInfo(string orderId)
        {
            var vnpayInfo = await _dataContext.VnpayInfos.FirstOrDefaultAsync(m => m.PaymentId == orderId);
            
            if (vnpayInfo == null)
            {
                return NotFound();
            }
            return View(vnpayInfo);
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
            if (string.IsNullOrWhiteSpace(ordercode))
            {
                TempData["error"] = "Mã đơn hàng không hợp lệ.";
                return RedirectToAction(nameof(Index));
            }

            var order = await _dataContext.Orders.FirstOrDefaultAsync(o => o.OrderCode == ordercode);
            if (order == null)
            {
                TempData["error"] = "Không tìm thấy đơn hàng để xóa.";
                return RedirectToAction(nameof(Index));
            }

            try
            {
                var orderDetails = await _dataContext.OrderDetails
                    .Where(od => od.OrderCode == ordercode)
                    .ToListAsync();

                if (orderDetails.Any())
                {
                    _dataContext.OrderDetails.RemoveRange(orderDetails);
                }

                _dataContext.Orders.Remove(order);
                await _dataContext.SaveChangesAsync();

                TempData["success"] = "Xóa đơn hàng thành công!";
                return RedirectToAction(nameof(Index));
            }
            catch (Exception ex)
            {
                TempData["error"] = "Đã xảy ra lỗi khi xóa: " + ex.Message;
                return RedirectToAction(nameof(Index));
            }
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> RetryCreateShipment(string ordercode)
        {
            if (string.IsNullOrWhiteSpace(ordercode))
            {
                TempData["error"] = "Mã đơn không hợp lệ.";
                return RedirectToAction(nameof(Index));
            }

            var order = await _dataContext.Orders.FirstOrDefaultAsync(o => o.OrderCode == ordercode);
            if (order != null && string.IsNullOrWhiteSpace(order.ShippingTrackingCode))
            {
                var shipment = await _shippingService.CreateShipmentAsync(ordercode);
                if (shipment.IsSuccess)
                {
                    order.ShippingTrackingCode = shipment.TrackingCode;
                    _dataContext.Update(order);
                    await _dataContext.SaveChangesAsync();
                    TempData["success"] = "Tạo vận đơn GHN thành công: " + shipment.TrackingCode;
                }
                else
                {
                    TempData["error"] = "Lỗi GHN: " + shipment.Message;
                }
            }
            else
            {
                TempData["info"] = "Đơn hàng đã có mã vận đơn hoặc không hợp lệ.";
            }

            return RedirectToAction(nameof(ViewOrder), new { ordercode = ordercode });
        }
    }
}
