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
        public IActionResult Index()
        {
            var countProduct = _dataContext.Products.Count();
            var countOrder = _dataContext.Orders.Count();
            var countCategory = _dataContext.Categories.Count();
            var countUser = _dataContext.Users.Count();

            ViewBag.CountProduct = countProduct;
            ViewBag.CountOrder = countOrder;
            ViewBag.CountCategory = countCategory;
            ViewBag.CountUser = countUser;

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
                    revenue = s.Revenue,
                    profit = s.Profit
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
                    revenue = s.Revenue,
                    profit = s.Profit
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
                    revenue = s.Revenue,
                    profit = s.Profit
                })
                .ToListAsync();

            return Json(data);
        }
    }
}
