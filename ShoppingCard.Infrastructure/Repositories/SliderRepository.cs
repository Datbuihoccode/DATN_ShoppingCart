using Microsoft.EntityFrameworkCore;
using ShoppingCard.Domain.Entities;
using ShoppingCard.Domain.Interfaces;
using ShoppingCard.Infrastructure.Data;

namespace ShoppingCard.Infrastructure.Repositories
{
    public class SliderRepository : ISliderRepository
    {
        private readonly DataContext _context;

        public SliderRepository(DataContext context)
        {
            _context = context;
        }

        public async Task<IEnumerable<Slider>> GetActiveSlidersAsync()
        {
            return await _context.Sliders
                .Where(s => s.Status == 1)
                .AsNoTracking()
                .ToListAsync();
        }

        public async Task SaveChangesAsync()
        {
            await _context.SaveChangesAsync();
        }
    }
}
