using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Authorization;
using ShoppingCard.Application.Interfaces;
using ShoppingCard.Domain.Entities;
using System.Threading.Tasks;
using System;

namespace ShoppingCard.Areas.Admin.Controllers
{
    [Area("Admin")]
    [Authorize(Roles = "Admin,Staff", AuthenticationSchemes = "AdminScheme")]
    public class CouponController : Controller
    {
        private readonly ICouponService _couponService;

        public CouponController(ICouponService couponService)
        {
            _couponService = couponService;
        }

        public async Task<IActionResult> Index()
        {
            return View(await _couponService.GetAllCouponsAsync());
        }

        [HttpGet]
        public IActionResult Create()
        {
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create(Coupon coupon)
        {
            if (coupon.DateExpired.Date < coupon.DateStart.Date)
            {
                ModelState.AddModelError(nameof(coupon.DateExpired), "Ngày kết thúc phải lớn hơn hoặc bằng ngày bắt đầu.");
            }

            if (ModelState.IsValid)
            {
                try 
                {
                    await _couponService.CreateCouponAsync(coupon);
                    TempData["success"] = "Thêm mã giảm giá thành công.";
                    return RedirectToAction(nameof(Index));
                }
                catch (Exception ex)
                {
                    ModelState.AddModelError("", ex.Message);
                }
            }

            TempData["error"] = "Có lỗi xảy ra, vui lòng kiểm tra lại.";
            return View(coupon);
        }

        [HttpGet]
        public async Task<IActionResult> Edit(int id)
        {
            var coupon = await _couponService.GetCouponByIdAsync(id);
            if (coupon == null) return NotFound();
            return View(coupon);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(Coupon coupon)
        {
            if (coupon.DateExpired.Date < coupon.DateStart.Date)
            {
                ModelState.AddModelError(nameof(coupon.DateExpired), "Ngày kết thúc phải lớn hơn hoặc bằng ngày bắt đầu.");
            }

            if (ModelState.IsValid)
            {
                await _couponService.UpdateCouponAsync(coupon);
                TempData["success"] = "Cập nhật mã giảm giá thành công.";
                return RedirectToAction(nameof(Index));
            }

            TempData["error"] = "Có lỗi xảy ra, vui lòng kiểm tra lại.";
            return View(coupon);
        }

        public async Task<IActionResult> Delete(int id)
        {
            await _couponService.DeleteCouponAsync(id);
            TempData["success"] = "Đã xóa mã giảm giá thành công.";
            return RedirectToAction(nameof(Index));
        }

        public async Task<IActionResult> ToggleStatus(int id)
        {
            await _couponService.ToggleStatusAsync(id);
            TempData["success"] = "Đã cập nhật trạng thái.";
            return RedirectToAction(nameof(Index));
        }
    }
}
