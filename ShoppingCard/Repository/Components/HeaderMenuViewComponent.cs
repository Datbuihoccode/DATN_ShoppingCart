using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using ShoppingCard.Models;
using ShoppingCard.Repository;

namespace ShoppingCard.Repository.Components
{
    public class HeaderMenuViewComponent : ViewComponent
    {
        private readonly DataContext _dataContext;
        public HeaderMenuViewComponent(DataContext context)
        {
            _dataContext = context;
        }

        public async Task<IViewComponentResult> InvokeAsync()
        {
            var categories = await _dataContext.Categories.ToListAsync();
            var brands = await _dataContext.Brands.ToListAsync();

            var model = new HeaderMenuViewModel
            {
                Categories = categories,
                Brands = brands
            };

            return View(model);
        }
    }

    public class HeaderMenuViewModel
    {
        public List<CategoryModel> Categories { get; set; }
        public List<BrandModel> Brands { get; set; }
    }
}
