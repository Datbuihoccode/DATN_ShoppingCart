using ShoppingCard.Models;

namespace ShoppingCard.Services
{
    public interface IOrderService
    {
        Task<OrderModel> CreateOrderAsync(string userId, string userEmail, PaymentMethod method, string couponCode = null, string shippingPhone = null);
        Task<bool> CompleteOrderAsync(string orderCode);
    }
}
