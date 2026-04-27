using ShoppingCard.Repository.Validation;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace ShoppingCard.Models
{
    public class ProductModel
    {
        [Key]
        public long Id { get; set; }

        [Required(ErrorMessage = "Yêu cầu nhập Tên sản phẩm.")]
        public string Name { get; set; }

        public string Slug { get; set; }

        [Required(ErrorMessage = "Yêu cầu nhập Mô tả sản phẩm.")]
        public string Description { get; set; }

        [Required(ErrorMessage = "Yêu cầu nhập Giá sản phẩm.")]
        [Range(0.01, double.MaxValue)]
        [Column(TypeName = "decimal(18,2)")]
        public decimal Price { get; set; }

        [Required(ErrorMessage = "Yêu cầu chọn Thương hiệu.")]
        public int BrandId { get; set; }


        public BrandModel Brand { get; set; }

        /// <summary>
        /// Tình trạng sản phẩm: "Mới 100%" hoặc "Like New"
        /// </summary>
        [Required(ErrorMessage = "Yêu cầu chọn tình trạng sản phẩm.")]
        public string Condition { get; set; } = "Mới 100%";

        public string Image { get; set; }

        public int Quantity { get; set; }

        public int Sold { get; set; }
        public ICollection<RatingModel> Ratings { get; set; }
        public virtual ICollection<ProductQuantityModel> ProductQuantities { get; set; }

        /// <summary>
        /// Quan hệ nhiều-nhiều với Category (qua bảng ProductCategories)
        /// </summary>
        public ICollection<ProductCategoryModel> ProductCategories { get; set; } = new List<ProductCategoryModel>();

        [NotMapped]
        [FileExtension]
        public IFormFile? ImageUpload { get; set; }

        /// <summary>
        /// Danh sách Id danh mục được chọn khi submit form (không lưu vào DB)
        /// </summary>
        [NotMapped]
        public List<int> SelectedCategoryIds { get; set; } = new List<int>();
    }
}
