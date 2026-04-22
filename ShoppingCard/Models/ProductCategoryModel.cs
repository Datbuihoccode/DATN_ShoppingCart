using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace ShoppingCard.Models
{
    /// <summary>
    /// Bảng trung gian: 1 sản phẩm có thể thuộc nhiều danh mục (many-to-many)
    /// </summary>
    public class ProductCategoryModel
    {
        [Key]
        public long Id { get; set; }

        [Required]
        public long ProductId { get; set; }

        [Required]
        public int CategoryId { get; set; }

        [ForeignKey("ProductId")]
        public ProductModel Product { get; set; }

        [ForeignKey("CategoryId")]
        public CategoryModel Category { get; set; }
    }
}
