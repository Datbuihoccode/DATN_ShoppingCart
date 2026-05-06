using Microsoft.AspNetCore.Mvc;
using ShoppingCard.Application.Interfaces;
using System.Threading.Tasks;

namespace ShoppingCard.Components
{
    [ViewComponent(Name = "Categories")]
    public class CategoriesViewComponent : ViewComponent
    {
        private readonly ICategoryService _categoryService;

        public CategoriesViewComponent(ICategoryService categoryService)
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
