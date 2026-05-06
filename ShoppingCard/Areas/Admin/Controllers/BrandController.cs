using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Authorization;
using ShoppingCard.Application.Interfaces;
using ShoppingCard.Application.DTOs;
using ShoppingCard.Application.Common;
using System.Threading.Tasks;
using System.Linq;
using System;

namespace ShoppingCard.Areas.Admin.Controllers
{
    [Area("Admin")]
    [Route("Admin/Brand")]
    [Authorize(Roles = "Admin,Staff", AuthenticationSchemes = "AdminScheme")]
    public class BrandController : Controller
    {
        private readonly IBrandService _brandService;
        public BrandController(IBrandService brandService)
        {
            _brandService = brandService;
        }

        [Route("Index")]
        public async Task<IActionResult> Index(int pg = 1)
        {
            var brands = await _brandService.GetAllBrandsAsync();

            const int pageSize = 10;
            if (pg < 1) pg = 1;
            int recsCount = brands.Count();
            var pager = new Paginate(recsCount, pg, pageSize);
            int recSkip = (pg - 1) * pageSize;
            var data = brands.Skip(recSkip).Take(pager.PageSize).ToList();

            ViewBag.Pager = pager;
            return View(data);
        }

        [Route("Create")]
        public IActionResult Create()
        {
            return View();
        }

        [Route("Create")]
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create(BrandDto brandDto)
        {
            if (ModelState.IsValid)
            {
                try 
                {
                    await _brandService.CreateBrandAsync(brandDto);
                    TempData["success"] = "Thêm thương hiệu thành công.";
                    return RedirectToAction("Index");
                }
                catch (Exception ex)
                {
                    ModelState.AddModelError("", ex.Message);
                }
            }
            return View(brandDto);
        }

        [Route("Edit/{Id}")]
        public async Task<IActionResult> Edit(int Id)
        {
            var brand = await _brandService.GetBrandByIdAsync(Id);
            if (brand == null) return NotFound();
            return View(brand);
        }

        [Route("Edit/{Id}")]
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int Id, BrandDto brandDto)
        {
            if (ModelState.IsValid)
            {
                try 
                {
                    await _brandService.UpdateBrandAsync(Id, brandDto);
                    TempData["success"] = "Cập nhật thương hiệu thành công.";
                    return RedirectToAction("Index");
                }
                catch (Exception ex)
                {
                    ModelState.AddModelError("", ex.Message);
                }
            }
            return View(brandDto);
        }

        [Route("Delete/{Id}")]
        public async Task<IActionResult> Delete(int Id)
        {
            await _brandService.DeleteBrandAsync(Id);
            TempData["success"] = "Đã xóa thương hiệu.";
            return RedirectToAction("Index");
        }
    }
}
