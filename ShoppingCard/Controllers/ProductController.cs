using ShoppingCard.Application.Interfaces;
using ShoppingCard.Application.DTOs;
using System.Security.Claims;
using ShoppingCard.Models.ViewModels;
using ShoppingCard.Domain.Entities;

namespace ShoppingCard.Controllers
{
    public class ProductController : Controller
    {
        private readonly IProductService _productService;

        public ProductController(IProductService productService)
        {
            _productService = productService;
        }

        [Route("Product/Search")]
        public async Task<IActionResult> Search(string searchTerm)
        {
            if (string.IsNullOrEmpty(searchTerm))
                return View(new List<ProductDto>());

            var products = await _productService.SearchProductsAsync(searchTerm);
            ViewBag.Keyword = searchTerm;

            return View(products);
        }

        [Route("/product/{Slug}")]
        public async Task<IActionResult> Details(string Slug)
        {
            if (string.IsNullOrEmpty(Slug))
                return RedirectToAction("Index");

            var productDto = await _productService.GetProductBySlugAsync(Slug);
            if (productDto == null)
                return RedirectToAction("Index");

            var relatedProducts = await _productService.GetRelatedProductsAsync(productDto.Id, productDto.CategoryIds);
            ViewBag.RelatedProducts = relatedProducts;

            bool hasPurchased = false;
            if (User.Identity?.IsAuthenticated == true)
            {
                var userEmail = User.FindFirstValue(ClaimTypes.Email) ?? User.Identity.Name;
                hasPurchased = await _productService.HasUserPurchasedProductAsync(productDto.Id, userEmail);
            }
            ViewBag.HasPurchased = hasPurchased;

            var viewModel = new ProductDetailViewModel
            {
                ProductDetails = new Product 
                {
                    Id = productDto.Id,
                    Name = productDto.Name,
                    Slug = productDto.Slug,
                    Description = productDto.Description,
                    Price = productDto.Price,
                    Image = productDto.Image,
                    Condition = productDto.Condition,
                    Quantity = productDto.Quantity,
                    Sold = productDto.Sold
                },
            };
            return View(viewModel);
        }
        [Route("comment-product")]
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> CommentProduct(RatingDto ratingDto)
        {
            if (User.Identity?.IsAuthenticated != true)
            {
                TempData["error"] = "Bạn cần đăng nhập để đánh giá.";
                return Redirect(Request.Headers["Referer"]);
            }

            var userEmail = User.FindFirstValue(ClaimTypes.Email) ?? User.Identity.Name;
            ratingDto.Email = userEmail;
            ModelState.Remove("Email");

            if (ModelState.IsValid)
            {
                var hasPurchased = await _productService.HasUserPurchasedProductAsync(ratingDto.ProductId, userEmail);

                if (!hasPurchased)
                {
                    TempData["error"] = "Bạn phải mua sản phẩm này mới được đánh giá.";
                    return Redirect(Request.Headers["Referer"]);
                }

                await _productService.AddRatingAsync(ratingDto);

                TempData["success"] = "Cảm ơn bạn đã gửi đánh giá!";
                return Redirect(Request.Headers["Referer"]);
            }
            else
            {
                TempData["error"] = "Vui lòng nhập đầy đủ nội dung đánh giá.";
                return Redirect(Request.Headers["Referer"]);
            }
        }
    }
}
