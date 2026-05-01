using ShoppingCard.Models.Shipping;
using ShoppingCard.Models;

namespace ShoppingCard.Services
{
    public interface IShippingService
    {
        Task<ShippingQuoteResult> GetShippingQuoteAsync(string userId, ShippingQuoteRequest request);
        Task<ShippingShipmentResult> CreateShipmentAsync(string orderCode);
        /// <summary>Lấy danh sách Tỉnh/Thành mới theo GHN API v3 (sau sáp nhập hành chính)</summary>
        Task<List<ShippingLocationModel>> GetProvincesAsync();
        /// <summary>Lấy danh sách Phường/Xã mới theo GHN API v3, truyền province_id từ GetProvincesAsync</summary>
        Task<List<ShippingLocationModel>> GetWardsAsync(string provinceId);
        bool TryMapWebhookStatus(string externalStatus, out OrderStatus orderStatus);
    }
}
