using ShoppingCard.Domain.Entities;

namespace ShoppingCard.Domain.Interfaces
{
    public interface ICartRepository
    {
        Task<IEnumerable<Cart>> GetCartByUserIdAsync(string userId);
        Task<Cart> GetCartItemAsync(string userId, int productId);
        Task AddAsync(Cart cart);
        void Update(Cart cart);
        void Remove(Cart cart);
        void RemoveRange(IEnumerable<Cart> carts);
        Task SaveChangesAsync();
    }
}
