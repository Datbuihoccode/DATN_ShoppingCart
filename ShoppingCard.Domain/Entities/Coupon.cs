using System;
using System.ComponentModel.DataAnnotations;

namespace ShoppingCard.Domain.Entities
{
    public class Coupon
    {
        [Key]
        public int Id { get; set; }

        [Required(ErrorMessage = "Yêu cầu nhập tên coupon")]
        public string Name { get; set; }

        [Required(ErrorMessage = "Yêu cầu nhập mô tả coupon")]
        public string Description { get; set; }

        public DateTime DateStart { get; set; }

        public DateTime DateExpired { get; set; }

        [Required(ErrorMessage = "Yêu cầu nhập số lượng coupon")]
        public int Quantity { get; set; }

        [Required(ErrorMessage = "Yêu cầu chọn loại giảm giá")]
        public int Type { get; set; } // 0: Fixed Amount, 1: Percentage

        [Required(ErrorMessage = "Yêu cầu nhập giá trị giảm")]
        public decimal DiscountValue { get; set; }

        public decimal MaxDiscountAmount { get; set; } // Max amount for % type

        public decimal MinAmount { get; set; } // Minimum spend to apply

        public int Status { get; set; }
    }
}
