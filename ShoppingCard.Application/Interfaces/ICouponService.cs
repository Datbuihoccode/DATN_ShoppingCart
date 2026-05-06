using ShoppingCard.Domain.Entities;

namespace ShoppingCard.Application.Interfaces
{
    public interface ICouponService
    {
        Task<IEnumerable<Coupon>> GetAllCouponsAsync();
        Task<Coupon> GetCouponByIdAsync(int id);
        Task CreateCouponAsync(Coupon coupon);
        Task UpdateCouponAsync(Coupon coupon);
        Task DeleteCouponAsync(int id);
        Task ToggleStatusAsync(int id);
    }
}
