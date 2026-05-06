using Microsoft.AspNetCore.Mvc;
using ShoppingCard.Application.Interfaces;
using System.Threading.Tasks;

namespace ShoppingCard.Components
{
    [ViewComponent(Name = "Brands")]
    public class BrandsViewComponent : ViewComponent
    {
        private readonly IBrandService _brandService;

        public BrandsViewComponent(IBrandService brandService)
        {
            _brandService = brandService;
        }

        public async Task<IViewComponentResult> InvokeAsync()
        {
            var brands = await _brandService.GetAllBrandsAsync();
            return View(brands);
        }
    }
}
