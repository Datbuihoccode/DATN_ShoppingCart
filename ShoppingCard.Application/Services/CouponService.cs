using ShoppingCard.Application.Interfaces;
using ShoppingCard.Domain.Entities;
using ShoppingCard.Domain.Interfaces;

namespace ShoppingCard.Application.Services
{
    public class CouponService : ICouponService
    {
        private readonly ICouponRepository _couponRepository;

        public CouponService(ICouponRepository couponRepository)
        {
            _couponRepository = couponRepository;
        }

        public async Task<IEnumerable<Coupon>> GetAllCouponsAsync()
        {
            return await _couponRepository.GetAllAsync();
        }

        public async Task<Coupon> GetCouponByIdAsync(int id)
        {
            return await _couponRepository.GetByIdAsync(id);
        }

        public async Task CreateCouponAsync(Coupon coupon)
        {
            var existing = await _couponRepository.GetByNameAsync(coupon.Name);
            if (existing != null) throw new Exception("Mã coupon đã tồn tại.");

            await _couponRepository.AddAsync(coupon);
            await _couponRepository.SaveChangesAsync();
        }

        public async Task UpdateCouponAsync(Coupon coupon)
        {
            _couponRepository.Update(coupon);
            await _couponRepository.SaveChangesAsync();
        }

        public async Task DeleteCouponAsync(int id)
        {
            var existing = await _couponRepository.GetByIdAsync(id);
            if (existing != null)
            {
                _couponRepository.Delete(existing);
                await _couponRepository.SaveChangesAsync();
            }
        }

        public async Task ToggleStatusAsync(int id)
        {
            var existing = await _couponRepository.GetByIdAsync(id);
            if (existing != null)
            {
                existing.Status = existing.Status == 1 ? 0 : 1;
                _couponRepository.Update(existing);
                await _couponRepository.SaveChangesAsync();
            }
        }
    }
}
