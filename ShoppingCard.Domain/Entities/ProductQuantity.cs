using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace ShoppingCard.Domain.Entities
{
    public class ProductQuantity
    {
        public int Id { get; set; }
        public int ProductId { get; set; }
        [Required(ErrorMessage = "Yêu cầu nhập số lượng sản phẩm")]
        public int Quantity { get; set; }
        public DateTime CreatedDate { get; set; }

        [ForeignKey("ProductId")]
        public virtual Product Product { get; set; }
    }
}
