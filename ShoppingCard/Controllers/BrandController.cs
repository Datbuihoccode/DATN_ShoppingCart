using ShoppingCard.Application.Interfaces;
using ShoppingCard.Application.DTOs;

namespace ShoppingCard.Controllers
{
    public class BrandController : Controller
    {
        private readonly IProductService _productService;
        private readonly IBrandService _brandService;

        public BrandController(IProductService productService, IBrandService brandService)
        {
            _productService = productService;
            _brandService = brandService;
        }
        [Route("Brand/{Slug?}")]
        public async Task<IActionResult> Index(string Slug = "")
        {
            var brand = await _brandService.GetBrandBySlugAsync(Slug);
            if (brand == null)
                return RedirectToAction("Index", "Home");

            var filter = new ProductFilterDto
            {
                BrandSlug = Slug,
                PageSize = 100 // Load more for brand page
            };

            var result = await _productService.GetFilteredProductsAsync(filter);
            
            ViewBag.BrandName = brand.Name;
            return View(result.Items);
        }
    }
}
