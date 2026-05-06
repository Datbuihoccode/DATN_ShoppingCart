using Microsoft.EntityFrameworkCore;
using ShoppingCard.Domain.Entities;
using ShoppingCard.Domain.Interfaces;
using ShoppingCard.Infrastructure.Data;

namespace ShoppingCard.Infrastructure.Repositories
{
    public class RatingRepository : IRatingRepository
    {
        private readonly DataContext _context;

        public RatingRepository(DataContext context)
        {
            _context = context;
        }

        public async Task AddAsync(Rating rating)
        {
            await _context.Ratings.AddAsync(rating);
        }

        public async Task<bool> HasPurchasedAsync(int productId, string userName)
        {
            return await _context.OrderDetails.AnyAsync(od => od.ProductId == productId && od.UserName == userName);
        }

        public async Task SaveChangesAsync()
        {
            await _context.SaveChangesAsync();
        }
    }
}
