using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace ShoppingCard.Models
{
    [Table("Carts")]
    public class CartModel
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int Id { get; set; }

        public string UserId { get; set; }
        
        public long ProductId { get; set; }
        
        public int Quantity { get; set; }

        [ForeignKey("ProductId")]
        public ProductModel? Product { get; set; }
    }
}
