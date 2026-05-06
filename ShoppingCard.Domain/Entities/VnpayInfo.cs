using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace ShoppingCard.Domain.Entities
{
    public class VnpayInfo
    {
        [Key]
        public int Id { get; set; }
        public string? OrderDescription { get; set; }
        public string? TransactionId { get; set; }
        public string? OrderId { get; set; }
        public string? PaymentMethod { get; set; }
        public string? PaymentId { get; set; }
        public DateTime DateCreated { get; set; }

        [ForeignKey("PaymentId")]
        public virtual Order? Order { get; set; }
    }
}
