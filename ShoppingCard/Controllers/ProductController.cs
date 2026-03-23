using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using ShoppingCard.Models;
using ShoppingCard.Repository;

namespace ShoppingCard.Controllers
{
    public class ProductController : Controller
    {
        private readonly DataContext _dataContext;
        public ProductController(DataContext context)
        {
            _dataContext = context;
        }

        public async Task<IActionResult> Search( string searchTearm)
        {
            var products = await _dataContext.Products
                .Where(p => p.Name.Contains(searchTearm) || p.Description.Contains(searchTearm))
                .ToListAsync();

            ViewBag.Keyword = searchTearm;

            return View(products);
        }

        public async Task<IActionResult> Details(int Id)
        {
            if (Id == null)
                return RedirectToAction("Index");
            var productsById = _dataContext.Products
                .Include(p=>p.Ratings)
                .Where(p => p.Id == Id).FirstOrDefault();

            var relatedProducts = await _dataContext.Products
                .Where(p => p.CategoryId == productsById.CategoryId && p.Id != productsById.Id)
                .Take(4)
                .ToListAsync();
            ViewBag.RelatedProducts = relatedProducts;

            var viewModel = new Models.ViewsModels.ProductDetailViewModel
            {
                ProductDetails = productsById,
                
            };
            return View(viewModel);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> CommentProduct(RatingModel rating)
        {
            if (ModelState.IsValid)
            {
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

                TempData["SuccessMessage"] = "Your comment has been submitted successfully.";
                return Redirect(Request.Headers["Referer"]);
            }
            else
            {
                List<string> errors = new List<string>();

                foreach (var value in ModelState.Values)
                {
                    foreach (var error in value.Errors)
                    {
                        errors.Add(error.ErrorMessage);
                    }
                }
                string errorMessages = string.Join("\n", errors);
                TempData["error"] = errorMessages;
                
                return RedirectToAction("Details", new { id = rating.ProductId});
            }
            return RedirectToAction(Request.Headers["Referer"]);
        }
    }
}
