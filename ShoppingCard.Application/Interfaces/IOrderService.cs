using ShoppingCard.Application.DTOs.Shipping;
using ShoppingCard.Domain.Entities;
using ShoppingCard.Domain.Enums;

namespace ShoppingCard.Application.Interfaces
{
    public interface IOrderService
    {
        Task<Order> CreateOrderAsync(
            string? userId,
            string userEmail,
            PaymentMethod paymentMethod,
            string couponCode = null,
            CheckoutShippingInput shippingInput = null);

        Task<bool> CompleteOrderAsync(string orderCode);
        Task<bool> UpdateStatusAsync(string orderCode, OrderStatus newStatus, string note = null);
        Task CreateShipmentIfReadyAsync(string orderCode);
        Task RestockOrderItemsAsync(string orderCode);
        Task<Order> GetOrderByCodeAsync(string orderCode);
        Task ProcessAutoCompletedOrdersAsync();
        Task<bool> DeleteOrderAsync(string orderCode);
    }
}
