using ShoppingCard.Application.Interfaces;
using ShoppingCard.Application.DTOs;

namespace ShoppingCard.Controllers
{
    public class CategoryController : Controller
    {
        private readonly IProductService _productService;
        private readonly ICategoryService _categoryService;

        public CategoryController(IProductService productService, ICategoryService categoryService)
        {
            _productService = productService;
            _categoryService = categoryService;
        }

        [Route("Category/{slug?}")]
        public async Task<IActionResult> Index(string slug = "", string sort_by = "", string startprice = "", string endprice = "", string brand = "", int pg = 1)
        {
            var category = await _categoryService.GetCategoryBySlugAsync(slug);
            if (category == null)
                return RedirectToAction("Index", "Home");

            ViewBag.CategoryName = category.Name;

            decimal? startPriceValue = null;
            decimal? endPriceValue = null;
            if (decimal.TryParse(startprice, out var sp)) startPriceValue = sp;
            if (decimal.TryParse(endprice, out var ep)) endPriceValue = ep;

            var filter = new ProductFilterDto
            {
                CategorySlug = slug,
                BrandSlug = brand,
                SortBy = sort_by,
                StartPrice = startPriceValue,
                EndPrice = endPriceValue,
                Page = pg,
                PageSize = 40
            };

            var result = await _productService.GetFilteredProductsAsync(filter);

            ViewBag.CurrentPage = result.CurrentPage;
            ViewBag.TotalPages = result.TotalPages;

            return View(result.Items);
        }
    }
}