using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using ShoppingCard.Models;
using ShoppingCard.Repository;

namespace ShoppingCard.Areas.Admin.Controllers
{
    [Area("Admin")]
    [Authorize(Roles = "Admin")]
    public class CouponController : Controller
    {
        private readonly DataContext _dataContext;

        public CouponController(DataContext context)
        {
            _dataContext = context;
        }

        public async Task<IActionResult> Index()
        {
            ViewBag.Coupons = await _dataContext.Coupons.ToListAsync();
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create(CouponModel coupon)
        {
            if (coupon.DateExpired.Date < coupon.DateStart.Date)
            {
                ModelState.AddModelError(nameof(coupon.DateExpired), "Ngày kết thúc phải lớn hơn hoặc bằng ngày bắt đầu.");
            }

            var existingCoupon = await _dataContext.Coupons.AnyAsync(c => c.Name == coupon.Name);
            if (existingCoupon)
            {
                ModelState.AddModelError(nameof(coupon.Name), "Mã coupon đã tồn tại.");
            }

            if (!ModelState.IsValid)
            {
                TempData["error"] = "Thông tin coupon chưa hợp lệ.";
                ViewBag.Coupons = await _dataContext.Coupons.ToListAsync();
                return View("Index", coupon);
            }

            _dataContext.Coupons.Add(coupon);
            await _dataContext.SaveChangesAsync();

            TempData["success"] = "Thêm coupon thành công";
            return RedirectToAction(nameof(Index));
        }
    }
}
