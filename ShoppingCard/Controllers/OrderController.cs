using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using ShoppingCard.Models;
using ShoppingCard.Repository;

namespace ShoppingCard.Controllers
{
    public class OrderController : Controller
    {
        private readonly DataContext _dataContext;

        public OrderController(DataContext dataContext)
        {
            _dataContext = dataContext;
        }

        [HttpGet]
        public IActionResult Track()
        {
            ViewBag.OrderCode = Request.Query["orderCode"];
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Track(string orderCode)
        {
            if (string.IsNullOrWhiteSpace(orderCode))
            {
                TempData["error"] = "Vui lòng nhập Mã đơn hàng.";
                return View();
            }

            var order = await _dataContext.Orders
                .Include(o => o.OrderDetails)
                    .ThenInclude(od => od.Product)
                .Include(o => o.OrderHistories)
                .FirstOrDefaultAsync(o => o.OrderCode == orderCode);

            if (order == null)
            {
                TempData["error"] = "Không tìm thấy đơn hàng. Vui lòng kiểm tra lại thông tin.";
                return View();
            }

            return View("Details", order);
        }

        [HttpGet]
        public async Task<IActionResult> Details(string orderCode)
        {
            // Bảo mật: Nếu truy cập trực tiếp qua GET mà không qua POST (tra cứu), 
            // có thể cần thêm check SĐT hoặc check User login.
            // Ở đây ta cho phép xem nếu có OrderCode (vì GUID khó đoán).
            
            var order = await _dataContext.Orders
                .Include(o => o.OrderDetails)
                    .ThenInclude(od => od.Product)
                .Include(o => o.OrderHistories)
                .FirstOrDefaultAsync(o => o.OrderCode == orderCode);

            if (order == null) return NotFound();

            return View(order);
        }
    }
}
