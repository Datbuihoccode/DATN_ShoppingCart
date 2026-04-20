using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using ShoppingCard.Models;
using ShoppingCard.Repository;

namespace ShoppingCard.Controllers
{
    public class BrandController : Controller
    {
        private readonly  DataContext _dataContext;
        public BrandController(DataContext dataContext)
        {
            _dataContext = dataContext;
        }
        public async Task<IActionResult> Index(string Slug = "")
        {
            BrandModel brand = await _dataContext.Brands.Where(c => c.Slug == Slug).FirstOrDefaultAsync();
            if (brand == null)
                return RedirectToAction("Index", "Home");
            var productsByBrand = _dataContext.Products.Where(p => p.BrandId == brand.Id);
            return View(await productsByBrand.OrderByDescending(p => p.Id).Include(p => p.Category).Include(p => p.Brand).ToListAsync());
        }
    }
}
