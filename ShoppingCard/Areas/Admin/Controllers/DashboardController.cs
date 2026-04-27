using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using ShoppingCard.Repository;

namespace ShoppingCard.Areas.Admin.Controllers
{
    [Area("Admin")]
    [Route("Admin/Dashboard")]
    [Authorize(Roles = "Admin")]
    public class DashboardController : Controller
    {
        private readonly DataContext _dataContext;

        public DashboardController(DataContext context)
        {
            _dataContext = context;
        }

        [Route("Index")]
        [HttpGet]
        public async Task<IActionResult> Index()
        {
            var countProduct = await _dataContext.Products.CountAsync();
            var countOrder = await _dataContext.Orders.CountAsync();
            var countCategory = await _dataContext.Categories.CountAsync();
            var countUser = await _dataContext.Users.CountAsync();

            ViewBag.CountProduct = countProduct;
            ViewBag.CountOrder = countOrder;
            ViewBag.CountCategory = countCategory;
            ViewBag.CountUser = countUser;

            // 1. Recent Orders (Top 5)
            var recentOrders = await _dataContext.Orders
                .OrderByDescending(o => o.CreateDate)
                .Take(5)
                .Select(o => new
                {
                    o.OrderCode,
                    o.UserName,
                    o.CreateDate,
                    o.Status,
                    o.PaymentStatus,
                    TotalAmount = _dataContext.OrderDetails
                        .Where(od => od.OrderCode == o.OrderCode)
                        .Sum(od => od.Price * od.Quantity)
                })
                .ToListAsync();

            // 2. Top Products (Top 5 by Sold)
            var topProducts = await _dataContext.Products
                .OrderByDescending(p => p.Sold)
                .Take(5)
                .Select(p => new {
                    p.Id,
                    p.Name,
                    p.Image,
                    p.Sold,
                    p.Price,
                    p.Quantity,
                    Revenue = _dataContext.OrderDetails
                        .Where(od => od.ProductId == p.Id)
                        .Sum(od => od.Price * od.Quantity)
                })
                .ToListAsync();

            // 3. Low Stock Products (Quantity < 10)
            var lowStock = await _dataContext.Products
                .Where(p => p.Quantity < 10)
                .OrderBy(p => p.Quantity)
                .Take(5)
                .ToListAsync();

            // 4. Total Revenue from Statisticals
            ViewBag.TotalRevenue = await _dataContext.Statisticals.SumAsync(s => s.Revenue);

            ViewBag.RecentOrders = recentOrders;
            ViewBag.TopProducts = topProducts;
            ViewBag.LowStock = lowStock;

            return View();
        }

        [HttpPost]
        [Route("GetChartData")]
        public async Task<IActionResult> GetChartData()
        {
            var data = await _dataContext.Statisticals
                .OrderBy(s => s.DateCreated)
                .Select(s => new
                {
                    date = s.DateCreated.ToString("yyyy-MM-dd"),
                    sold = s.Sold,
                    quantity = s.Quantity,
                    revenue = s.Revenue
                })
                .ToListAsync();

            return Json(data);
        }

        [HttpPost]
        [Route("GetChartDataBySelect")]
        public async Task<IActionResult> GetChartDataBySelect(int days = 30)
        {
            if (days <= 0)
            {
                days = 30;
            }

            var endDateExclusive = DateTime.Today.AddDays(1);
            var startDate = endDateExclusive.AddDays(-days);

            var data = await _dataContext.Statisticals
                .Where(s => s.DateCreated >= startDate && s.DateCreated < endDateExclusive)
                .OrderBy(s => s.DateCreated)
                .Select(s => new
                {
                    date = s.DateCreated.ToString("yyyy-MM-dd"),
                    sold = s.Sold,
                    quantity = s.Quantity,
                    revenue = s.Revenue
                })
                .ToListAsync();

            return Json(data);
        }

        [HttpPost]
        [Route("FilterData")]
        public async Task<IActionResult> FilterData(DateTime? fromDate, DateTime? toDate)
        {
            var query = _dataContext.Statisticals.AsQueryable();

            if (fromDate.HasValue)
            {
                var startDate = fromDate.Value.Date;
                query = query.Where(s => s.DateCreated >= startDate);
            }

            if (toDate.HasValue)
            {
                var endDateExclusive = toDate.Value.Date.AddDays(1);
                query = query.Where(s => s.DateCreated < endDateExclusive);
            }

            var data = await query
                .OrderBy(s => s.DateCreated)
                .Select(s => new
                {
                    date = s.DateCreated.ToString("yyyy-MM-dd"),
                    sold = s.Sold,
                    quantity = s.Quantity,
                    revenue = s.Revenue
                })
                .ToListAsync();

            return Json(data);
        }
    }
}
