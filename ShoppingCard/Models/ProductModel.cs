using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace ShoppingCard.Models
{
    public class ProductModel
    {
        [Key]
        public int Id { get; set; }

        [Required( ErrorMessage = "Yêu cầu nhập Tên sản phẩm.")]
        public string Name { get; set; }

        public string Slug { get; set; }

        
        [Required(ErrorMessage = "Yêu cầu nhập Mô tả sản phẩm.")]
        public string Description { get; set; }

        [Required ( ErrorMessage = "Yêu cầu nhập Giá sản phẩm.")]
        [Range(0.01, double.MaxValue)]
        [Column(TypeName = "decimal(18,2)")]
        public decimal Price { get; set; }

        [Required(ErrorMessage = "Yêu cầu chọn Thương hiệu.")]
        public int BrandId { get; set; }

        [Required(ErrorMessage = "Yêu cầu chọn Danh mục.")]
        public int CategoryId { get; set; }

        public CategoryModel Category { get; set; }

        public BrandModel Brand { get; set; }

        [Required(ErrorMessage = "Yêu cầu chọn hình ảnh.")]
        public string Image { get; set; }

        [NotMapped]
        [FileExtensions]
        public IFormFile ImageUpload { get; set; }

    }
}
