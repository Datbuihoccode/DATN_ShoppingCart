using System;
using System.Collections.Generic;

namespace ShoppingCard.Application.DTOs.Dashboard
{
    public class DashboardDto
    {
        public int CountProduct { get; set; }
        public int CountOrder { get; set; }
        public int CountCategory { get; set; }
        public int CountUser { get; set; }
        public decimal TotalRevenue { get; set; }

        public IEnumerable<RecentOrderDto> RecentOrders { get; set; }
        public IEnumerable<TopProductDto> TopProducts { get; set; }
        public IEnumerable<LowStockProductDto> LowStockProducts { get; set; }
    }

    public class RecentOrderDto
    {
        public string OrderCode { get; set; }
        public string UserName { get; set; }
        public DateTime CreateDate { get; set; }
        public string Status { get; set; }
        public string PaymentStatus { get; set; }
        public decimal TotalAmount { get; set; }
    }

    public class TopProductDto
    {
        public long Id { get; set; }
        public string Name { get; set; }
        public string Image { get; set; }
        public int Sold { get; set; }
        public decimal Price { get; set; }
        public int Quantity { get; set; }
        public decimal Revenue { get; set; }
    }

    public class LowStockProductDto
    {
        public long Id { get; set; }
        public string Name { get; set; }
        public int Quantity { get; set; }
    }

    public class ChartDataDto
    {
        public string Date { get; set; }
        public int Sold { get; set; }
        public int Quantity { get; set; }
        public decimal Revenue { get; set; }
    }
}
