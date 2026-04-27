using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
namespace ShoppingCard.Models
{
    public class ProductQuantityModel
    {
        public int Id { get; set; }
        public long ProductId { get; set; }
        [Required(ErrorMessage = "Yêu cầu nhập số lượng sản phẩm")]
        public int Quantity { get; set; }
        public DateTime CreatedDate { get; set; }

        [ForeignKey("ProductId")]
        public virtual ProductModel Product { get; set; }
    }
}
