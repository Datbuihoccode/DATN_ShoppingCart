using ShoppingCard.Application.DTOs.Dashboard;

namespace ShoppingCard.Application.Interfaces
{
    public interface IDashboardService
    {
        Task<DashboardDto> GetDashboardStatsAsync();
        Task<IEnumerable<ChartDataDto>> GetChartDataAsync(int days);
        Task<IEnumerable<ChartDataDto>> GetFilteredChartDataAsync(DateTime? fromDate, DateTime? toDate);
    }
}
