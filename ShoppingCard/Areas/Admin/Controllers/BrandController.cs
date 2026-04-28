using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using ShoppingCard.Models;
using ShoppingCard.Repository;

namespace ShoppingCard.Areas.Admin.Controllers
{
    [Area("Admin")]
    [Route("Admin/Brand")]
    [Authorize(Roles = "Admin,Staff")]
    public class BrandController : Controller
    {
        private readonly DataContext _dataContext;
        public BrandController(DataContext context)
        {
            _dataContext = context;
        }

        [Route("Index")]
        public async Task<IActionResult> Index(int pg = 1)
        {
            List<BrandModel> brand = _dataContext.Brands.ToList();

            const int pageSize = 10;
            if (pg < 1) pg = 1;
            int recsCount = brand.Count();
            var pager = new Paginate(recsCount, pg, pageSize);
            int recSkip = (pg - 1) * pageSize;
            var data = brand.Skip(recSkip).Take(pager.PageSize).ToList();

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
        public async Task<IActionResult> Create(BrandModel brand)
        {
            if (ModelState.IsValid)
            {
                if (string.IsNullOrEmpty(brand.Slug)) {
                    brand.Slug = brand.Name.Replace(" ", "-").ToLower();
                }

                var slugCheck = await _dataContext.Brands.FirstOrDefaultAsync(b => b.Slug == brand.Slug);
                if (slugCheck != null)
                {
                    ModelState.AddModelError("", "Thương hiệu với slug này đã tồn tại.");
                    return View(brand);
                }

                _dataContext.Brands.Add(brand);
                await _dataContext.SaveChangesAsync();
                TempData["success"] = "Thêm thương hiệu thành công.";
                return RedirectToAction("Index");
            }
            return View(brand);
        }

        [Route("Edit/{Id}")]
        public async Task<IActionResult> Edit(int Id)
        {
            BrandModel brand = await _dataContext.Brands.FindAsync(Id);
            return View(brand);
        }

        [Route("Edit/{Id}")]
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(BrandModel brand)
        {
            if (ModelState.IsValid)
            {
                if (string.IsNullOrEmpty(brand.Slug)) {
                    brand.Slug = brand.Name.Replace(" ", "-").ToLower();
                }

                var slugCheck = await _dataContext.Brands.FirstOrDefaultAsync(b => b.Slug == brand.Slug && b.Id != brand.Id);
                if (slugCheck != null)
                {
                    ModelState.AddModelError("", "Thương hiệu với slug này đã tồn tại.");
                    return View(brand);
                }

                _dataContext.Brands.Update(brand);
                await _dataContext.SaveChangesAsync();
                TempData["success"] = "Cập nhật thương hiệu thành công.";
                return RedirectToAction("Index");
            }
            return View(brand);
        }

        [Route("Delete/{Id}")]
        public async Task<IActionResult> Delete(int Id)
        {
            BrandModel brand = await _dataContext.Brands.FindAsync(Id);
            if (brand == null) return NotFound();

            _dataContext.Brands.Remove(brand);
            await _dataContext.SaveChangesAsync();
            TempData["success"] = "Đã xóa thương hiệu.";
            return RedirectToAction("Index");
        }
    }
}
