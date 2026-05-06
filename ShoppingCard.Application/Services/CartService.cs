using ShoppingCard.Application.Interfaces;
using ShoppingCard.Domain.Entities;
using ShoppingCard.Domain.Interfaces;

namespace ShoppingCard.Application.Services
{
    public class CartService : ICartService
    {
        private readonly ICartRepository _cartRepository;
        private readonly IProductRepository _productRepository;

        public CartService(ICartRepository cartRepository, IProductRepository productRepository)
        {
            _cartRepository = cartRepository;
            _productRepository = productRepository;
        }

        public async Task<IEnumerable<Cart>> GetCartItemsAsync(string userId)
        {
            return await _cartRepository.GetCartByUserIdAsync(userId);
        }

        public async Task AddToCartAsync(string userId, int productId, int quantity)
        {
            var cartItem = await _cartRepository.GetCartItemAsync(userId, productId);
            if (cartItem == null)
            {
                await _cartRepository.AddAsync(new Cart
                {
                    UserId = userId,
                    ProductId = productId,
                    Quantity = quantity
                });
            }
            else
            {
                cartItem.Quantity += quantity;
                _cartRepository.Update(cartItem);
            }
            await _cartRepository.SaveChangesAsync();
        }

        public async Task IncreaseQuantityAsync(string userId, int productId)
        {
            var product = await _productRepository.GetByIdAsync(productId);
            var cartItem = await _cartRepository.GetCartItemAsync(userId, productId);

            if (cartItem != null && product != null)
            {
                if (product.Quantity > cartItem.Quantity)
                {
                    cartItem.Quantity += 1;
                    _cartRepository.Update(cartItem);
                    await _cartRepository.SaveChangesAsync();
                }
            }
        }

        public async Task DecreaseQuantityAsync(string userId, int productId)
        {
            var cartItem = await _cartRepository.GetCartItemAsync(userId, productId);
            if (cartItem != null)
            {
                if (cartItem.Quantity > 1)
                {
                    cartItem.Quantity -= 1;
                    _cartRepository.Update(cartItem);
                }
                else
                {
                    _cartRepository.Remove(cartItem);
                }
                await _cartRepository.SaveChangesAsync();
            }
        }

        public async Task RemoveFromCartAsync(string userId, int productId)
        {
            var cartItem = await _cartRepository.GetCartItemAsync(userId, productId);
            if (cartItem != null)
            {
                _cartRepository.Remove(cartItem);
                await _cartRepository.SaveChangesAsync();
            }
        }

        public async Task ClearCartAsync(string userId)
        {
            var items = await _cartRepository.GetCartByUserIdAsync(userId);
            _cartRepository.RemoveRange(items);
            await _cartRepository.SaveChangesAsync();
        }

        public async Task<decimal> CalculateGrandTotalAsync(string userId)
        {
            var items = await _cartRepository.GetCartByUserIdAsync(userId);
            return items.Sum(x => x.Quantity * (x.Product?.Price ?? 0));
        }
    }
}
