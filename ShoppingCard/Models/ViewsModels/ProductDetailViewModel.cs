using System.ComponentModel.DataAnnotations;

namespace ShoppingCard.Models.ViewsModels
{
    public class ProductDetailViewModel
    {
        public ProductModel ProductDetails { get; set; }
        
        [Required(ErrorMessage = "Mời nhập đánh giá của bạn.")]
        public string Comment { get; set; }
        [Required(ErrorMessage = "Mời nhập tên của bạn.")]
        public string Name { get; set; }
        [Required(ErrorMessage = "Mời nhập Email của bạn.")]
        public string Email { get; set; }
    }
}
