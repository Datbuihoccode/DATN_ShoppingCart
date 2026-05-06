using ShoppingCard.Domain.Entities;

namespace ShoppingCard.Domain.Interfaces
{
    public interface IOrderRepository
    {
        Task<IEnumerable<Order>> GetAllAsync();
        Task<Order> GetByCodeAsync(string orderCode);
        Task<Order> GetByTrackingCodeAsync(string trackingCode);
        Task<int> CountAsync();
        Task<IEnumerable<Order>> GetRecentOrdersAsync(int count);
        Task AddAsync(Order order);
        void Update(Order order);
        void Delete(Order order);
        
        Task<IEnumerable<OrderDetail>> GetOrderDetailsAsync(string orderCode);
        Task AddOrderDetailAsync(OrderDetail detail);
        
        Task AddHistoryAsync(OrderHistory history);
        Task<IEnumerable<OrderHistory>> GetHistoryAsync(string orderCode);

        Task SaveChangesAsync();
    }
}
