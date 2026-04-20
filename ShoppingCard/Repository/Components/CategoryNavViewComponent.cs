using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using ShoppingCard.Repository;

namespace ShoppingCard.Repository.Components
{
    public class CategoryNavViewComponent : ViewComponent
    {
        private readonly DataContext _dataContext;
        public CategoryNavViewComponent(DataContext context)
        {
            _dataContext = context;
        }

        public async Task<IViewComponentResult> InvokeAsync()
        {
            var categories = await _dataContext.Categories.Where(c => c.Status == 1).ToListAsync();
            return View(categories);
        }
    }
}
