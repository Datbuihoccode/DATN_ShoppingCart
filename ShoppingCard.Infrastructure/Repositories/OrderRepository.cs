using Microsoft.EntityFrameworkCore;
using ShoppingCard.Domain.Entities;
using ShoppingCard.Domain.Interfaces;
using ShoppingCard.Infrastructure.Data;

namespace ShoppingCard.Infrastructure.Repositories
{
    public class OrderRepository : IOrderRepository
    {
        private readonly DataContext _context;

        public OrderRepository(DataContext context)
        {
            _context = context;
        }

        public async Task<IEnumerable<Order>> GetAllAsync()
        {
            return await _context.Orders.OrderByDescending(o => o.Id).ToListAsync();
        }

        public async Task<Order> GetByCodeAsync(string orderCode)
        {
            return await _context.Orders
                .Include(o => o.OrderDetails)
                .ThenInclude(od => od.Product)
                .Include(o => o.OrderHistories)
                .Include(o => o.MomoInfo)
                .Include(o => o.VnpayInfo)
                .FirstOrDefaultAsync(o => o.OrderCode == orderCode);
        }

        public async Task<Order> GetByTrackingCodeAsync(string trackingCode)
        {
            return await _context.Orders.FirstOrDefaultAsync(o => o.ShippingTrackingCode == trackingCode);
        }

        public async Task<int> CountAsync()
        {
            return await _context.Orders.CountAsync();
        }

        public async Task<IEnumerable<Order>> GetRecentOrdersAsync(int count)
        {
            return await _context.Orders
                .OrderByDescending(o => o.CreateDate)
                .Take(count)
                .ToListAsync();
        }

        public async Task AddAsync(Order order)
        {
            await _context.Orders.AddAsync(order);
        }

        public void Update(Order order)
        {
            _context.Orders.Update(order);
        }

        public void Delete(Order order)
        {
            _context.Orders.Remove(order);
        }

        public async Task<IEnumerable<OrderDetail>> GetOrderDetailsAsync(string orderCode)
        {
            return await _context.OrderDetails
                .Include(od => od.Product)
                .Where(od => od.OrderCode == orderCode)
                .ToListAsync();
        }

        public async Task AddOrderDetailAsync(OrderDetail detail)
        {
            await _context.OrderDetails.AddAsync(detail);
        }

        public async Task AddHistoryAsync(OrderHistory history)
        {
            await _context.OrderHistories.AddAsync(history);
        }

        public async Task<IEnumerable<OrderHistory>> GetHistoryAsync(string orderCode)
        {
            return await _context.OrderHistories
                .Where(oh => oh.OrderCode == orderCode)
                .OrderByDescending(oh => oh.CreatedDate)
                .ToListAsync();
        }

        public async Task SaveChangesAsync()
        {
            await _context.SaveChangesAsync();
        }
    }
}
