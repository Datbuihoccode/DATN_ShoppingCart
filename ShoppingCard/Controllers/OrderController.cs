using ShoppingCard.Application.Interfaces;
using ShoppingCard.Domain.Entities;

namespace ShoppingCard.Controllers
{
    public class OrderController : Controller
    {
        private readonly IOrderService _orderService;

        public OrderController(IOrderService orderService)
        {
            _orderService = orderService;
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

            var order = await _orderService.GetOrderByCodeAsync(orderCode);

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
            var order = await _orderService.GetOrderByCodeAsync(orderCode);

            if (order == null) return NotFound();

            return View(order);
        }
    }
}
