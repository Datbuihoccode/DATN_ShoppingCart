using ShoppingCard.Domain.Entities;

namespace ShoppingCard.Application.Interfaces
{
    public interface ICartService
    {
        Task<IEnumerable<Cart>> GetCartItemsAsync(string userId);
        Task AddToCartAsync(string userId, int productId, int quantity);
        Task IncreaseQuantityAsync(string userId, int productId);
        Task DecreaseQuantityAsync(string userId, int productId);
        Task RemoveFromCartAsync(string userId, int productId);
        Task ClearCartAsync(string userId);
        Task<decimal> CalculateGrandTotalAsync(string userId);
    }
}
