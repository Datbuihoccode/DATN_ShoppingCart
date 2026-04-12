using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace ShoppingCard.Models
{
    public class StatisticalModel
    {
        [Key]
        public int Id { get; set; }

        public int Quantity { get; set; } // Số lượng đơn hàng

        public int Sold { get; set; } // So luong ban ra

        [Column(TypeName = "decimal(18,2)")]
        public decimal Revenue { get; set; } // Doanh thu

        [Column(TypeName = "decimal(18,2)")]
        public decimal Profit { get; set; } // Lợi nhuận

        public DateTime DateCreated { get; set; } // Ngay dat hang
    }
}

