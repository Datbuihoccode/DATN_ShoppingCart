using ShoppingCard.Application.DTOs.Dashboard;
using ShoppingCard.Application.Interfaces;
using ShoppingCard.Domain.Interfaces;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ShoppingCard.Application.Services
{
    public class DashboardService : IDashboardService
    {
        private readonly IOrderRepository _orderRepository;
        private readonly IProductRepository _productRepository;
        private readonly ICategoryRepository _categoryRepository;
        private readonly IUserRepository _userRepository;
        private readonly IStatisticalRepository _statisticalRepository;

        public DashboardService(
            IOrderRepository orderRepository,
            IProductRepository productRepository,
            ICategoryRepository categoryRepository,
            IUserRepository userRepository,
            IStatisticalRepository statisticalRepository)
        {
            _orderRepository = orderRepository;
            _productRepository = productRepository;
            _categoryRepository = categoryRepository;
            _userRepository = userRepository;
            _statisticalRepository = statisticalRepository;
        }

        public async Task<DashboardDto> GetDashboardStatsAsync()
        {
            var countProduct = await _productRepository.CountAsync();
            var countOrder = await _orderRepository.CountAsync();
            var countCategory = await _categoryRepository.CountAsync();
            var countUser = await _userRepository.CountAsync();
            var totalRevenue = await _statisticalRepository.GetTotalRevenueAsync();

            var recentOrders = await _orderRepository.GetRecentOrdersAsync(5);
            var topProducts = await _productRepository.GetTopProductsAsync(5);
            var lowStock = await _productRepository.GetLowStockProductsAsync(10);

            return new DashboardDto
            {
                CountProduct = countProduct,
                CountOrder = countOrder,
                CountCategory = countCategory,
                CountUser = countUser,
                TotalRevenue = totalRevenue,
                RecentOrders = recentOrders.Select(o => new RecentOrderDto
                {
                    OrderCode = o.OrderCode,
                    UserName = o.UserName,
                    CreateDate = o.CreateDate,
                    Status = o.Status.ToString(),
                    PaymentStatus = o.PaymentStatus.ToString(),
                    TotalAmount = o.OrderDetails?.Sum(od => od.Price * od.Quantity) ?? 0
                }),
                TopProducts = topProducts.Select(p => new TopProductDto
                {
                    Id = p.Id,
                    Name = p.Name,
                    Image = p.Image,
                    Sold = p.Sold,
                    Price = p.Price,
                    Quantity = p.Quantity
                }),
                LowStockProducts = lowStock.Select(p => new LowStockProductDto
                {
                    Id = p.Id,
                    Name = p.Name,
                    Quantity = p.Quantity
                })
            };
        }

        public async Task<IEnumerable<ChartDataDto>> GetChartDataAsync(int days)
        {
            var endDate = DateTime.Today;
            var startDate = endDate.AddDays(-days);
            var stats = await _statisticalRepository.GetByDateRangeAsync(startDate, endDate);

            return stats.Select(s => new ChartDataDto
            {
                Date = s.DateCreated.ToString("yyyy-MM-dd"),
                Sold = s.Sold,
                Quantity = s.Quantity,
                Revenue = s.Revenue
            });
        }

        public async Task<IEnumerable<ChartDataDto>> GetFilteredChartDataAsync(DateTime? fromDate, DateTime? toDate)
        {
            var startDate = fromDate ?? DateTime.Today.AddDays(-30);
            var endDate = toDate ?? DateTime.Today;
            var stats = await _statisticalRepository.GetByDateRangeAsync(startDate, endDate);

            return stats.Select(s => new ChartDataDto
            {
                Date = s.DateCreated.ToString("yyyy-MM-dd"),
                Sold = s.Sold,
                Quantity = s.Quantity,
                Revenue = s.Revenue
            });
        }
    }
}
