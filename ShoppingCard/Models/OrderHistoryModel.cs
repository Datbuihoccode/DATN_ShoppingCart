using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace ShoppingCard.Models
{
    public class OrderHistoryModel
    {
        [Key]
        public int Id { get; set; }

        public string OrderCode { get; set; }

        public OrderStatus Status { get; set; }

        public DateTime CreatedDate { get; set; }

        public string Note { get; set; }

        // Navigation property
        [ForeignKey("OrderCode")]
        public virtual OrderModel Order { get; set; }

        [NotMapped]
        public string DisplayStatus => Status.ToAdminDisplay();
    }
}
