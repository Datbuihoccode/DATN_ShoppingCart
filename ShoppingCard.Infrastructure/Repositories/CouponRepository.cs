using Microsoft.EntityFrameworkCore;
using ShoppingCard.Domain.Entities;
using ShoppingCard.Domain.Interfaces;
using ShoppingCard.Infrastructure.Data;

namespace ShoppingCard.Infrastructure.Repositories
{
    public class CouponRepository : ICouponRepository
    {
        private readonly DataContext _context;

        public CouponRepository(DataContext context)
        {
            _context = context;
        }

        public async Task<IEnumerable<Coupon>> GetAllAsync()
        {
            return await _context.Coupons.OrderByDescending(c => c.Id).ToListAsync();
        }

        public async Task<Coupon> GetByIdAsync(int id)
        {
            return await _context.Coupons.FindAsync(id);
        }

        public async Task<Coupon> GetByNameAsync(string name)
        {
            return await _context.Coupons.FirstOrDefaultAsync(c => c.Name == name);
        }

        public async Task AddAsync(Coupon coupon)
        {
            await _context.Coupons.AddAsync(coupon);
        }

        public void Update(Coupon coupon)
        {
            _context.Coupons.Update(coupon);
        }

        public void Delete(Coupon coupon)
        {
            _context.Coupons.Remove(coupon);
        }

        public async Task SaveChangesAsync()
        {
            await _context.SaveChangesAsync();
        }
    }
}
