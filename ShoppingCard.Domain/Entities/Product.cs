using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace ShoppingCard.Domain.Entities
{
    public class Product
    {
        [Key]
        public int Id { get; set; }

        [Required(ErrorMessage = "Yêu cầu nhập Tên sản phẩm.")]
        public string Name { get; set; }

        public string? Slug { get; set; }

        [Required(ErrorMessage = "Yêu cầu nhập Mô tả sản phẩm.")]
        public string? Description { get; set; }

        [Required(ErrorMessage = "Yêu cầu nhập Giá sản phẩm.")]
        [Range(0.01, double.MaxValue)]
        [Column(TypeName = "decimal(18,2)")]
        public decimal Price { get; set; }

        [Required(ErrorMessage = "Yêu cầu chọn Thương hiệu.")]
        public int BrandId { get; set; }

        public virtual Brand? Brand { get; set; }

        /// <summary>
        /// Tình trạng sản phẩm: "Mới 100%" hoặc "Like New"
        /// </summary>
        [Required(ErrorMessage = "Yêu cầu chọn tình trạng sản phẩm.")]
        public string? Condition { get; set; } = "Mới 100%";

        public string? Image { get; set; }

        public int Quantity { get; set; }

        public int Sold { get; set; }

        [Range(1, 1000000, ErrorMessage = "Khối lượng sản phẩm phải lớn hơn 0")]
        public int? WeightGram { get; set; }

        public virtual ICollection<Rating>? Ratings { get; set; }
        public virtual ICollection<ProductQuantity>? ProductQuantities { get; set; }

        /// <summary>
        /// Quan hệ nhiều-nhiều với Category (qua bảng ProductCategories)
        /// </summary>
        public virtual ICollection<ProductCategory> ProductCategories { get; set; } = new List<ProductCategory>();
    }
}
