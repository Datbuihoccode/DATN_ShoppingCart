using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using ShoppingCard.Models;
using ShoppingCard.Repository;

namespace ShoppingCard.Areas.Admin.Controllers
{
    [Area("Admin")]
    [Authorize]
    public class OrderController : Controller
    {
        private readonly DataContext _dataContext;
        private readonly UserManager<AppUserModel> _userManager;

        public OrderController(DataContext context, UserManager<AppUserModel> userManager)
        {
            _dataContext = context;
            _userManager = userManager;
        }

        public async Task<IActionResult> Index()
        {
            return View(await _dataContext.Orders.OrderByDescending(p => p.Id).ToListAsync());
        }

        public async Task<IActionResult> ViewOrder(string odercode)
        {
            if (string.IsNullOrWhiteSpace(odercode))
            {
                return NotFound();
            }

            var order = await _dataContext.Orders.AsNoTracking().FirstOrDefaultAsync(o => o.OrderCode == odercode);
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
        public async Task<IActionResult> UpdateOrder(string ordercode, int status)
        {
            var order = await _dataContext.Orders.FirstOrDefaultAsync(o => o.OrderCode == ordercode);
            if (order == null)
            {
                return NotFound();
            }

            if (order.Status == OrderStatus.Cancelled)
            {
                return BadRequest(new { success = false, message = "Đơn hàng đã bị hủy và không thể cập nhật." });
            }

            var newStatus = (OrderStatus)status;
            var isMovingToCompleted = order.Status != OrderStatus.Completed && newStatus == OrderStatus.Completed;

            order.Status = newStatus;

            // Optional: If Completed, set PaymentStatus to Paid if it was COD
            if (newStatus == OrderStatus.Completed && order.PaymentStatus == PaymentStatus.Unpaid)
            {
                order.PaymentStatus = PaymentStatus.Paid;
            }

            _dataContext.Update(order);

            if (isMovingToCompleted)
            {
                var detailsOrder = await _dataContext.OrderDetails
                    .Include(od => od.Product)
                    .Where(od => od.OrderCode == order.OrderCode)
                    .Select(od => new
                    {
                        od.Quantity,
                        od.Price
                    })
                    .ToListAsync();

                var statisticalModel = await _dataContext.Statisticals
                    .FirstOrDefaultAsync(s => s.DateCreated.Date == order.CreateDate.Date);

                if (statisticalModel != null)
                {
                    foreach (var orderDetail in detailsOrder)
                    {
                        statisticalModel.Quantity += 1;
                        statisticalModel.Sold += orderDetail.Quantity;
                        statisticalModel.Revenue += orderDetail.Quantity * orderDetail.Price;
                    }

                    _dataContext.Update(statisticalModel);
                }
                else
                {
                    var newQuantity = 0;
                    var newSold = 0;
                    decimal newRevenue = 0m;
                    foreach (var orderDetail in detailsOrder)
                    {
                        newQuantity += 1;
                        newSold += orderDetail.Quantity;
                        newRevenue += orderDetail.Quantity * orderDetail.Price;
                    }

                    statisticalModel = new StatisticalModel
                    {
                        DateCreated = order.CreateDate.Date,
                        Quantity = newQuantity,
                        Sold = newSold,
                        Revenue = newRevenue
                    };

                    _dataContext.Add(statisticalModel);
                }
            }

            try
            {
                await _dataContext.SaveChangesAsync();
                return Ok(new { success = true, message = "Cập nhật trạng thái đơn hàng thành công" });
            }
            catch (Exception)
            {
                return StatusCode(500, "Đã xảy ra lỗi khi cập nhật trạng thái đơn hàng.");
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
    }
}

