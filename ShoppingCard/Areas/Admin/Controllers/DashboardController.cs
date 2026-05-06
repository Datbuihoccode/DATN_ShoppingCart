using ShoppingCard.Application.Interfaces;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Authorization;

namespace ShoppingCard.Areas.Admin.Controllers
{
    [Area("Admin")]
    [Authorize(Roles = "Admin,Staff", AuthenticationSchemes = "AdminScheme")]
    public class DashboardController : Controller
    {
        private readonly IDashboardService _dashboardService;

        public DashboardController(IDashboardService dashboardService)
        {
            _dashboardService = dashboardService;
        }

        [HttpGet]
        public async Task<IActionResult> Index()
        {
            var stats = await _dashboardService.GetDashboardStatsAsync();

            ViewBag.CountProduct = stats.CountProduct;
            ViewBag.CountOrder = stats.CountOrder;
            ViewBag.CountCategory = stats.CountCategory;
            ViewBag.CountUser = stats.CountUser;
            ViewBag.TotalRevenue = stats.TotalRevenue;

            ViewBag.RecentOrders = stats.RecentOrders;
            ViewBag.TopProducts = stats.TopProducts;
            ViewBag.LowStock = stats.LowStockProducts;

            return View();
        }

        [HttpPost]
        [Route("GetChartData")]
        public async Task<IActionResult> GetChartData()
        {
            var data = await _dashboardService.GetChartDataAsync(30);
            return Json(data);
        }

        [HttpPost]
        [Route("GetChartDataBySelect")]
        public async Task<IActionResult> GetChartDataBySelect(int days = 30)
        {
            var data = await _dashboardService.GetChartDataAsync(days);
            return Json(data);
        }

        [HttpPost]
        [Route("FilterData")]
        public async Task<IActionResult> FilterData(DateTime? fromDate, DateTime? toDate)
        {
            var data = await _dashboardService.GetFilteredChartDataAsync(fromDate, toDate);
            return Json(data);
        }
    }
}
