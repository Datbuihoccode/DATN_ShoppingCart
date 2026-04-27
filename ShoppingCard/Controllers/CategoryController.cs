using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using ShoppingCard.Models;
using ShoppingCard.Repository;

namespace ShoppingCard.Controllers
{
    public class CategoryController : Controller
    {
        private readonly DataContext _dataContext;
        public CategoryController(DataContext context)
        {
            _dataContext = context;
        }

        [Route("Category/{slug?}")]
        public async Task<IActionResult> Index(string slug = "", string sort_by = "", string startprice = "", string endprice = "", string brand = "", int pg = 1)
        {
            CategoryModel category = await _dataContext.Categories.Where(c => c.Slug == slug).FirstOrDefaultAsync();
            if (category == null)
                return RedirectToAction("Index", "Home");

            IQueryable<ProductModel> products = _dataContext.Products
                .Include(p => p.ProductCategories)
                .Where(p => p.ProductCategories.Any(pc => pc.CategoryId == category.Id));

            if (!string.IsNullOrEmpty(brand))
            {
                var brandModel = await _dataContext.Brands.FirstOrDefaultAsync(b => b.Slug == brand);
                if (brandModel != null)
                {
                    products = products.Where(p => p.BrandId == brandModel.Id);
                }
            }

            // Apply price filtering independently
            if (!string.IsNullOrEmpty(startprice) && !string.IsNullOrEmpty(endprice))
            {
                decimal startPriceValue;
                decimal endPriceValue;

                if (decimal.TryParse(startprice, out startPriceValue) && decimal.TryParse(endprice, out endPriceValue))
                {
                    products = products.Where(p => p.Price >= startPriceValue && p.Price <= endPriceValue);
                }
            }

            // Apply sorting independently
            if (sort_by == "price_increase")
            {
                products = products.OrderBy(p => p.Price);
            }
            else if (sort_by == "price_decrease")
            {
                products = products.OrderByDescending(p => p.Price);
            }
            else if (sort_by == "price_newest")
            {
                products = products.OrderByDescending(p => p.Id);
            }
            else if (sort_by == "price_oldest")
            {
                products = products.OrderBy(p => p.Id);
            }
            else
            {
                products = products.OrderByDescending(p => p.Id);
            }

            int pageSize = 40;
            if (pg < 1) pg = 1;

            int totalProducts = await products.CountAsync();
            int totalPages = (int)Math.Ceiling(totalProducts / (double)pageSize);

            var data = await products.Include(p => p.Brand)
                                     .Skip((pg - 1) * pageSize).Take(pageSize).ToListAsync();

            ViewBag.CurrentPage = pg;
            ViewBag.TotalPages = totalPages;

            return View(data);
        }
    }
}