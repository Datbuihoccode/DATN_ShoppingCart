using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using ShoppingCard.Models;
using ShoppingCard.Repository;

namespace ShoppingCard.Areas.Admin.Controllers
{
    [Area("Admin")]
    [Authorize(Roles = "Admin,Staff", AuthenticationSchemes = "AdminScheme")]
    public class CouponController : Controller
    {
        private readonly DataContext _dataContext;

        public CouponController(DataContext context)
        {
            _dataContext = context;
        }

        public async Task<IActionResult> Index()
        {
            return View(await _dataContext.Coupons.OrderByDescending(c => c.Id).ToListAsync());
        }

        [HttpGet]
        public IActionResult Create()
        {
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

            if (ModelState.IsValid)
            {
                _dataContext.Coupons.Add(coupon);
                await _dataContext.SaveChangesAsync();
                TempData["success"] = "Thêm mã giảm giá thành công.";
                return RedirectToAction(nameof(Index));
            }

            TempData["error"] = "Có lỗi xảy ra, vui lòng kiểm tra lại.";
            return View(coupon);
        }

        [HttpGet]
        public async Task<IActionResult> Edit(int id)
        {
            var coupon = await _dataContext.Coupons.FindAsync(id);
            if (coupon == null) return NotFound();
            return View(coupon);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(CouponModel coupon)
        {
            if (coupon.DateExpired.Date < coupon.DateStart.Date)
            {
                ModelState.AddModelError(nameof(coupon.DateExpired), "Ngày kết thúc phải lớn hơn hoặc bằng ngày bắt đầu.");
            }

            if (ModelState.IsValid)
            {
                _dataContext.Update(coupon);
                await _dataContext.SaveChangesAsync();
                TempData["success"] = "Cập nhật mã giảm giá thành công.";
                return RedirectToAction(nameof(Index));
            }

            TempData["error"] = "Có lỗi xảy ra, vui lòng kiểm tra lại.";
            return View(coupon);
        }

        public async Task<IActionResult> Delete(int id)
        {
            var coupon = await _dataContext.Coupons.FindAsync(id);
            if (coupon != null)
            {
                _dataContext.Coupons.Remove(coupon);
                await _dataContext.SaveChangesAsync();
                TempData["success"] = "Đã xóa mã giảm giá thành công.";
            }
            return RedirectToAction(nameof(Index));
        }

        public async Task<IActionResult> ToggleStatus(int id)
        {
            var coupon = await _dataContext.Coupons.FindAsync(id);
            if (coupon != null)
            {
                coupon.Status = coupon.Status == 1 ? 0 : 1;
                _dataContext.Update(coupon);
                await _dataContext.SaveChangesAsync();
                TempData["success"] = "Đã cập nhật trạng thái.";
            }
            return RedirectToAction(nameof(Index));
        }
    }
}
