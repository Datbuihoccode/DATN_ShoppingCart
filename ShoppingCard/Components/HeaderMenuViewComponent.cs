using Microsoft.AspNetCore.Mvc;
using ShoppingCard.Application.Interfaces;
using ShoppingCard.Models.ViewModels;
using System.Threading.Tasks;
using ShoppingCard.Domain.Entities;
using System.Linq;

namespace ShoppingCard.Components
{
    [ViewComponent(Name = "HeaderMenu")]
    public class HeaderMenuViewComponent : ViewComponent
    {
        private readonly ICategoryService _categoryService;
        private readonly IBrandService _brandService;

        public HeaderMenuViewComponent(ICategoryService categoryService, IBrandService brandService)
        {
            _categoryService = categoryService;
            _brandService = brandService;
        }

        public async Task<IViewComponentResult> InvokeAsync()
        {
            var categoriesDto = await _categoryService.GetAllCategoriesAsync();
            var brandsDto = await _brandService.GetAllBrandsAsync();

            var model = new HeaderMenuViewModel
            {
                Categories = categoriesDto.Select(c => new Category { Id = c.Id, Name = c.Name, Slug = c.Slug }),
                Brands = brandsDto.Select(b => new Brand { Id = b.Id, Name = b.Name, Slug = b.Slug })
            };

            return View(model);
        }
    }
}
