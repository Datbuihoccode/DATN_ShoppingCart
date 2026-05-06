using ShoppingCard.Domain.Entities;

namespace ShoppingCard.Domain.Interfaces
{
    public interface IStatisticalRepository
    {
        Task<Statistical?> GetByDateAsync(DateTime date);
        Task<decimal> GetTotalRevenueAsync();
        Task<IEnumerable<Statistical>> GetByDateRangeAsync(DateTime startDate, DateTime endDate);
        Task AddAsync(Statistical statistical);
        void Update(Statistical statistical);
        Task SaveChangesAsync();
    }
}
