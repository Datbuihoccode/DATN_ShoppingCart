using System.ComponentModel.DataAnnotations.Schema;

namespace ShoppingCard.Models
{
    public class OrderDetailsModel
    {

        public int Id { get; set; }
        public string UserName { get; set; }
        public string OrderCode { get; set; }
        public long ProductId { get; set; }

        [Column(TypeName = "decimal(18,2)")]
        public decimal Price { get; set; }
        public int Quantity { get; set; }

        [ForeignKey("OrderCode")]
        public virtual OrderModel Order { get; set; }

        [ForeignKey("ProductId")]
        public virtual ProductModel Product { get; set; }
    }
}
