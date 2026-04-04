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

        public async Task<IActionResult> Index(string slug = "", string sort_by = "", string startprice = "", string endprice = "")
        {
            CategoryModel category = await _dataContext.Categories.Where(c => c.Slug == slug).FirstOrDefaultAsync();
            if (category == null)
                return RedirectToAction("Index");

            IQueryable<ProductModel> products = _dataContext.Products.Where(p => p.CategoryId == category.Id);

            if (products.Count() > 0)
            {
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
                else if (startprice != "" && endprice != "") 
                {
                    decimal startPriceValue;
                    decimal endPriceValue;

                    // Ép kiểu (TryParse) từ chuỗi string nhận được trên URL sang kiểu decimal để so sánh
                    if (decimal.TryParse(startprice, out startPriceValue) && decimal.TryParse(endprice, out endPriceValue))
                    {
                        // Tiến hành Query lọc điều kiện giá
                        products = products.Where(p => p.Price >= startPriceValue && p.Price <= endPriceValue);
                    }
                    else
                    {
                        // Lấy mặc định nếu ép kiểu lỗi
                        products = products.OrderByDescending(p => p.Id);
                    }
                }
                else
                {
                    products = products.OrderByDescending(p => p.Id);
                }
            }
            return View(await products.ToListAsync());
        }
    }
}