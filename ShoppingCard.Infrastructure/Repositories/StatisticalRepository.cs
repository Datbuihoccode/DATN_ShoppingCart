using Microsoft.EntityFrameworkCore;
using ShoppingCard.Domain.Entities;
using ShoppingCard.Domain.Interfaces;
using ShoppingCard.Infrastructure.Data;

namespace ShoppingCard.Infrastructure.Repositories
{
    public class StatisticalRepository : IStatisticalRepository
    {
        private readonly DataContext _context;

        public StatisticalRepository(DataContext context)
        {
            _context = context;
        }

        public async Task<Statistical?> GetByDateAsync(DateTime date)
        {
            var targetDate = date.Date;
            return await _context.Statisticals.FirstOrDefaultAsync(s => s.DateCreated.Date == targetDate);
        }

        public async Task<decimal> GetTotalRevenueAsync()
        {
            return await _context.Statisticals.SumAsync(s => s.Revenue);
        }

        public async Task<IEnumerable<Statistical>> GetByDateRangeAsync(DateTime startDate, DateTime endDate)
        {
            return await _context.Statisticals
                .Where(s => s.DateCreated >= startDate && s.DateCreated <= endDate)
                .OrderBy(s => s.DateCreated)
                .ToListAsync();
        }

        public async Task AddAsync(Statistical statistical)
        {
            await _context.Statisticals.AddAsync(statistical);
        }

        public void Update(Statistical statistical)
        {
            _context.Statisticals.Update(statistical);
        }

        public async Task SaveChangesAsync()
        {
            await _context.SaveChangesAsync();
        }
    }
}
