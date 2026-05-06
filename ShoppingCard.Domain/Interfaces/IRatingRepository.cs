using ShoppingCard.Domain.Entities;

namespace ShoppingCard.Domain.Interfaces
{
    public interface IRatingRepository
    {
        Task AddAsync(Rating rating);
        Task<bool> HasPurchasedAsync(int productId, string userName);
        Task SaveChangesAsync();
    }
}
