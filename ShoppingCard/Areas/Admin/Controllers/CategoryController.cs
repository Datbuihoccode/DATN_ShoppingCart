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
    [Route("Admin/Category")]
    [Authorize(Roles = "Admin,Staff", AuthenticationSchemes = "AdminScheme")]
    public class CategoryController : Controller
    {
        private readonly ICategoryService _categoryService;
        public CategoryController(ICategoryService categoryService)
        {
            _categoryService = categoryService;
        }

        [Route("Index")]
        public async Task<IActionResult> Index(int pg = 1)
        {
            var categories = await _categoryService.GetAllCategoriesAsync();

            const int pageSize = 10;
            if (pg < 1) pg = 1;
            int recsCount = categories.Count();
            var pager = new Paginate(recsCount, pg, pageSize);
            int recSkip = (pg - 1) * pageSize;
            var data = categories.Skip(recSkip).Take(pager.PageSize).ToList();

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
        public async Task<IActionResult> Create(CategoryDto categoryDto)
        {
            if (ModelState.IsValid)
            {
                try 
                {
                    await _categoryService.CreateCategoryAsync(categoryDto);
                    TempData["success"] = "Thêm danh mục thành công.";
                    return RedirectToAction("Index");
                }
                catch (Exception ex)
                {
                    ModelState.AddModelError("", ex.Message);
                }
            }
            return View(categoryDto);
        }

        [Route("Edit/{Id}")]
        public async Task<IActionResult> Edit(int Id)
        {
            var category = await _categoryService.GetCategoryByIdAsync(Id); 
            if (category == null) return NotFound();
            return View(category); 
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        [Route("Edit/{Id}")]
        public async Task<IActionResult> Edit(int Id, CategoryDto categoryDto)
        {
            if (ModelState.IsValid)
            {
                try 
                {
                    await _categoryService.UpdateCategoryAsync(Id, categoryDto);
                    TempData["success"] = "Cập nhật danh mục thành công.";
                    return RedirectToAction("Index");
                }
                catch (Exception ex)
                {
                    ModelState.AddModelError("", ex.Message);
                }
            }
            return View(categoryDto);
        }

        [Route("Delete/{Id}")]
        public async Task<IActionResult> Delete(int Id)
        {
            await _categoryService.DeleteCategoryAsync(Id);
            TempData["success"] = "Đã xóa danh mục.";
            return RedirectToAction("Index");
        }
    }
}
