using ShoppingCard.Models;
using ShoppingCard.Models.Shipping;

namespace ShoppingCard.Services
{
    public interface IOrderService
    {
        Task<OrderModel> CreateOrderAsync(
            string userId,
            string userEmail,
            PaymentMethod method,
            string couponCode = null,
            CheckoutShippingInput shippingInput = null);
        Task<bool> CompleteOrderAsync(string orderCode);
        Task CreateShipmentIfReadyAsync(string orderCode);
        Task RestockOrderItemsAsync(string orderCode);
        Task<bool> UpdateStatusAsync(string orderCode, OrderStatus newStatus, string note = null);
        Task ProcessAutoCompletedOrdersAsync();
    }
}
