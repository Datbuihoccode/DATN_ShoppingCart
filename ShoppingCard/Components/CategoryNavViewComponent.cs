using Microsoft.AspNetCore.Mvc;
using ShoppingCard.Application.Interfaces;
using System.Threading.Tasks;

namespace ShoppingCard.Components
{
    [ViewComponent(Name = "CategoryNav")]
    public class CategoryNavViewComponent : ViewComponent
    {
        private readonly ICategoryService _categoryService;

        public CategoryNavViewComponent(ICategoryService categoryService)
        {
            _categoryService = categoryService;
        }

        public async Task<IViewComponentResult> InvokeAsync()
        {
            var categories = await _categoryService.GetAllCategoriesAsync();
            return View(categories);
        }
    }
}
