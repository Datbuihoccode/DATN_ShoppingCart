using Microsoft.EntityFrameworkCore;
using ShoppingCard.Domain.Entities;
using ShoppingCard.Domain.Interfaces;
using ShoppingCard.Infrastructure.Data;

namespace ShoppingCard.Infrastructure.Repositories
{
    public class CartRepository : ICartRepository
    {
        private readonly DataContext _context;

        public CartRepository(DataContext context)
        {
            _context = context;
        }

        public async Task<IEnumerable<Cart>> GetCartByUserIdAsync(string userId)
        {
            return await _context.Carts
                .Include(c => c.Product)
                .Where(c => c.UserId == userId)
                .ToListAsync();
        }

        public async Task<Cart> GetCartItemAsync(string userId, int productId)
        {
            return await _context.Carts.FirstOrDefaultAsync(c => c.UserId == userId && c.ProductId == productId);
        }

        public async Task AddAsync(Cart cart)
        {
            await _context.Carts.AddAsync(cart);
        }

        public void Update(Cart cart)
        {
            _context.Carts.Update(cart);
        }

        public void Remove(Cart cart)
        {
            _context.Carts.Remove(cart);
        }

        public void RemoveRange(IEnumerable<Cart> carts)
        {
            _context.Carts.RemoveRange(carts);
        }

        public async Task SaveChangesAsync()
        {
            await _context.SaveChangesAsync();
        }
    }
}
