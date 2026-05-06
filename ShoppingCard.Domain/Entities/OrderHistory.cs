using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using ShoppingCard.Domain.Enums;

namespace ShoppingCard.Domain.Entities
{
    public class OrderHistory
    {
        [Key]
        public int Id { get; set; }

        public string? OrderCode { get; set; }

        public OrderStatus Status { get; set; }
        
        [NotMapped]
        public string DisplayStatus => Status.ToAdminDisplay();

        public DateTime CreatedDate { get; set; }

        public string? Note { get; set; }

        // Navigation property
        [ForeignKey("OrderCode")]
        public virtual Order? Order { get; set; }
    }
}
