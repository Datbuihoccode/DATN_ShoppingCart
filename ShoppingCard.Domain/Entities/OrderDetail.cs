using System.ComponentModel.DataAnnotations.Schema;

namespace ShoppingCard.Domain.Entities
{
    public class OrderDetail
    {
        public int Id { get; set; }
        public string? UserName { get; set; }
        public string? OrderCode { get; set; }
        public int ProductId { get; set; }

        [Column(TypeName = "decimal(18,2)")]
        public decimal Price { get; set; }
        public int Quantity { get; set; }

        [ForeignKey("OrderCode")]
        public virtual Order? Order { get; set; }

        [ForeignKey("ProductId")]
        public virtual Product? Product { get; set; }
    }
}
