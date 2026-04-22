using System.ComponentModel.DataAnnotations;

namespace ShoppingCard.Models
{
    public class CategoryModel
    {
        [Key]
        public int Id { get; set; }

        [Required(ErrorMessage = "Yêu cầu nhập Tên danh mục.")]
        public string Name { get; set; }

        [Required(ErrorMessage = "Yêu cầu nhập Mô tả danh mục.")]
        public string Description { get; set; }

        public string Slug { get; set; }

        public int Status { get; set; }

        /// <summary>
        /// Navigation ngược: Danh mục này thuộc về những sản phẩm nào
        /// </summary>
        public ICollection<ProductCategoryModel> ProductCategories { get; set; } = new List<ProductCategoryModel>();
    }
}
