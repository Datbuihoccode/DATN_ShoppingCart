using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using ShoppingCard.Models;
using ShoppingCard.Repository;
using System.Security.Claims;

namespace ShoppingCard.Controllers
{
    public class ProductController : Controller
    {
        private readonly DataContext _dataContext;
        public ProductController(DataContext context)
        {
            _dataContext = context;
        }

        [Route("Product/Search")]
        public async Task<IActionResult> Search(string searchTearm)
        {
            if (string.IsNullOrEmpty(searchTearm))
                return View(new List<ProductModel>());

            var products = await _dataContext.Products
                .Include(p => p.Category)
                .Include(p => p.Brand)
                .Where(p => p.Name.Contains(searchTearm) || p.Description.Contains(searchTearm))
                .ToListAsync();

            ViewBag.Keyword = searchTearm;

            return View(products);
        }

        [Route("/product/{Slug}")]
        public async Task<IActionResult> Details(string Slug)
        {
            if (string.IsNullOrEmpty(Slug))
                return RedirectToAction("Index");

            var productsBySlug = await _dataContext.Products
                .Include(p => p.Ratings)
                .Include(p => p.Category)
                .Include(p => p.Brand)
                .FirstOrDefaultAsync(p => p.Slug == Slug);

            if (productsBySlug == null)
                return RedirectToAction("Index");

            var relatedProducts = await _dataContext.Products
                .Where(p => p.CategoryId == productsBySlug.CategoryId && p.Id != productsBySlug.Id)
                .OrderBy(x => Guid.NewGuid())
                .Take(10)
                .ToListAsync();
            ViewBag.RelatedProducts = relatedProducts;

            // Kiểm tra đã mua hàng chưa
            bool hasPurchased = false;
            if (User.Identity?.IsAuthenticated == true)
            {
                var userEmail = User.FindFirstValue(ClaimTypes.Email) ?? User.Identity.Name;
                hasPurchased = await _dataContext.OrderDetails
                    .AnyAsync(od => od.ProductId == productsBySlug.Id && od.UserName == userEmail);
            }
            ViewBag.HasPurchased = hasPurchased;

            var viewModel = new Models.ViewsModels.ProductDetailViewModel
            {
                ProductDetails = productsBySlug,
            };
            return View(viewModel);
        }
        [Route("comment-product")]
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> CommentProduct(RatingModel rating)
        {
            if (User.Identity?.IsAuthenticated != true)
            {
                TempData["error"] = "Bạn cần đăng nhập để đánh giá.";
                return Redirect(Request.Headers["Referer"]);
            }

            var userEmail = User.FindFirstValue(ClaimTypes.Email) ?? User.Identity.Name;

            // Ghi đè thông tin Email từ User đã đăng nhập để kiểm tra mua hàng
            rating.Email = userEmail;

            // Xóa lỗi ModelState cho Email vì chúng ta đã tự điền
            ModelState.Remove("Email");

            if (ModelState.IsValid)
            {
                // Kiểm tra lại việc mua hàng ở phía Server
                var hasPurchased = await _dataContext.OrderDetails
                    .AnyAsync(od => od.ProductId == rating.ProductId && od.UserName == userEmail);

                if (!hasPurchased)
                {
                    TempData["error"] = "Bạn phải mua sản phẩm này mới được đánh giá.";
                    return Redirect(Request.Headers["Referer"]);
                }

                var ratingEntity = new RatingModel
                {
                    ProductId = rating.ProductId,
                    Name = rating.Name,
                    Email = rating.Email,
                    Comment = rating.Comment,
                    Star = rating.Star
                };
                _dataContext.Ratings.Add(ratingEntity);
                await _dataContext.SaveChangesAsync();

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
