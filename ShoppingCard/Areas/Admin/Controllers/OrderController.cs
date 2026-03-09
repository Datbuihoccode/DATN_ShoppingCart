using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using ShoppingCard.Repository;

namespace ShoppingCard.Areas.Admin.Controllers
{
    [Area("Admin")]
    [Authorize]
    public class OrderController : Controller
    {
        private readonly DataContext _dataContext;
        public OrderController(DataContext context)
        {
            _dataContext = context;
        }
        public async Task<IActionResult> Index()    
        {
            return View(await _dataContext.Orders.OrderByDescending(p => p.Id).ToListAsync());
        }
        public async Task<IActionResult> ViewOrder(string odercode)
        {
            var DetailsOrder = await _dataContext.OrderDetails.Include(od=> od.Product).Where(od => od.OrderCode==odercode).ToListAsync();
            return View(DetailsOrder);
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

            order.Status = status;

            try
            {
                await _dataContext.SaveChangesAsync();
                return Ok(new { success = true, message = "Order updated successfully" });
            }
            catch (Exception ex)
            {
                return StatusCode(500,  "An error occurred while updating the order");
            }
        }

        [HttpPost]
        [Route("DeleteOrder")]
        public async Task<IActionResult> DeleteOrder(string ordercode)
        {
            // 1. Tìm đơn hàng theo mã OrderCode
            var order = await _dataContext.Orders.FirstOrDefaultAsync(o => o.OrderCode == ordercode);

            if (order == null)
            {
                return Json(new { success = false, message = "Không tìm thấy đơn hàng để xóa." });
            }

            try
            {
                // 2. Tìm và xóa các chi tiết đơn hàng (OrderDetails) liên quan trước
                var orderDetails = await _dataContext.OrderDetails
                                                     .Where(od => od.OrderCode == ordercode)
                                                     .ToListAsync();
                if (orderDetails.Any())
                {
                    _dataContext.OrderDetails.RemoveRange(orderDetails);
                }

                // 3. Xóa đơn hàng chính
                _dataContext.Orders.Remove(order);

                // 4. Lưu thay đổi vào Database
                await _dataContext.SaveChangesAsync();

                return Json(new { success = true, message = "Xóa đơn hàng thành công!" });
            }
            catch (Exception ex)
            {
                // Bắt lỗi và trả về message nếu có lỗi từ database (vd: lỗi khóa ngoại khác)
                return Json(new { success = false, message = "Đã xảy ra lỗi khi xóa: " + ex.Message });
            }
        }

    }
}
