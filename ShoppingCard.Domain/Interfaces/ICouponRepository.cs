using ShoppingCard.Domain.Entities;

namespace ShoppingCard.Domain.Interfaces
{
    public interface ICouponRepository
    {
        Task<IEnumerable<Coupon>> GetAllAsync();
        Task<Coupon> GetByIdAsync(int id);
        Task<Coupon> GetByNameAsync(string name);
        Task AddAsync(Coupon coupon);
        void Update(Coupon coupon);
        void Delete(Coupon coupon);
        Task SaveChangesAsync();
    }
}
