using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using ShoppingCard.Models;
using ShoppingCard.Repository;

namespace ShoppingCard.Areas.Admin.Controllers
{
    [Area("Admin")]
    [Route("Admin/Category")]
    [Authorize(Roles = "Admin,Staff")]
    public class CategoryController : Controller
    {
        private readonly DataContext _dataContext;
        public CategoryController(DataContext context)
        {
            _dataContext = context;
        }

        [Route("Index")]
        public async Task<IActionResult> Index(int pg = 1)
        {
            List<CategoryModel> category = _dataContext.Categories.ToList();

            const int pageSize = 10;
            if (pg < 1) pg = 1;
            int recsCount = category.Count();
            var pager = new Paginate(recsCount, pg, pageSize);
            int recSkip = (pg - 1) * pageSize;
            var data = category.Skip(recSkip).Take(pager.PageSize).ToList();

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
        public async Task<IActionResult> Create(CategoryModel category)
        {
            if (ModelState.IsValid)
            {
                if (string.IsNullOrEmpty(category.Slug)) {
                    category.Slug = category.Name.Replace(" ", "-").ToLower();
                }

                var slugCheck = await _dataContext.Categories.FirstOrDefaultAsync(c => c.Slug == category.Slug);
                if (slugCheck != null)
                {
                    ModelState.AddModelError("", "Danh mục với slug này đã tồn tại.");
                    return View(category);
                }

                _dataContext.Categories.Add(category);
                await _dataContext.SaveChangesAsync();
                TempData["success"] = "Thêm danh mục thành công.";
                return RedirectToAction("Index");
            }
            return View(category);
        }

        [Route("Edit/{Id}")]
        public async Task<IActionResult> Edit(int Id)
        {
            CategoryModel category = await _dataContext.Categories.FindAsync(Id); 
            return View(category); 
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        [Route("Edit/{Id}")]
        public async Task<IActionResult> Edit(CategoryModel category)
        {
            if (ModelState.IsValid)
            {
                if (string.IsNullOrEmpty(category.Slug)) {
                    category.Slug = category.Name.Replace(" ", "-").ToLower();
                }

                var slugCheck = await _dataContext.Categories.FirstOrDefaultAsync(c => c.Slug == category.Slug && c.Id != category.Id);
                if (slugCheck != null)
                {
                    ModelState.AddModelError("", "Danh mục với slug này đã tồn tại.");
                    return View(category);
                }

                _dataContext.Categories.Update(category);
                await _dataContext.SaveChangesAsync();
                TempData["success"] = "Cập nhật danh mục thành công.";
                return RedirectToAction("Index");
            }
            return View(category);
        }

        [Route("Delete/{Id}")]
        public async Task<IActionResult> Delete(int Id)
        {
            CategoryModel category = await _dataContext.Categories.FindAsync(Id); 
            if (category == null) return NotFound();

            _dataContext.Categories.Remove(category);
            await _dataContext.SaveChangesAsync();
            TempData["success"] = "Đã xóa danh mục.";
            return RedirectToAction("Index");
        }
    }
}
