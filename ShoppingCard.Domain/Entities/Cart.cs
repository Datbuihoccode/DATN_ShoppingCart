using System;
using System.ComponentModel.DataAnnotations;

namespace ShoppingCard.Domain.Entities
{
    public class Cart
    {
        [Key]
        public int Id { get; set; }
        
        [Required]
        public string UserId { get; set; } // Can be GUID for Guest or Identity User ID
        
        public int ProductId { get; set; }
        
        [Range(1, int.MaxValue)]
        public int Quantity { get; set; }
        

        // Navigation property
        public virtual Product Product { get; set; }
    }
}
