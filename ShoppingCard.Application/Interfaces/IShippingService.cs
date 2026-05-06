using ShoppingCard.Application.DTOs.Shipping;
using ShoppingCard.Domain.Enums;

namespace ShoppingCard.Application.Interfaces
{
    public interface IShippingService
    {
        Task<ShippingQuoteResult> GetShippingQuoteAsync(string userId, ShippingQuoteRequest request);
        Task<ShippingShipmentResult> CreateShipmentAsync(string orderCode);
        Task<List<ShippingLocationModel>> GetProvincesAsync();
        Task<List<ShippingLocationModel>> GetWardsAsync(string provinceId);
        bool TryMapWebhookStatus(string externalStatus, out OrderStatus orderStatus);
    }
}
