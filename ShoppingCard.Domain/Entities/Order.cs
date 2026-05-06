using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using ShoppingCard.Domain.Enums;

namespace ShoppingCard.Domain.Entities
{
    public class Order
    {
        [Key]
        public int Id { get; set; }
        public string? OrderCode { get; set; }
        public string? UserName { get; set; }
        public DateTime CreateDate { get; set; }

        public OrderStatus Status { get; set; }
        public PaymentStatus PaymentStatus { get; set; }
        public string? PaymentMethod { get; set; }
        public string? ShippingPhone { get; set; }
        public string? ShippingAddress { get; set; }
        public int? ShippingDistrictId { get; set; }
        public string? ShippingWardCode { get; set; }
        public string? ShippingProvinceName { get; set; }
        public string? ShippingWardName { get; set; }
        
        [Column(TypeName = "decimal(18,2)")]
        public decimal ShippingFee { get; set; }
        public string? ShippingProvider { get; set; }
        public string? ShippingTrackingCode { get; set; }
        public string? ShippingStatus { get; set; }
        public string? CouponCode { get; set; }
        
        [Column(TypeName = "decimal(18,2)")]
        public decimal DiscountAmount { get; set; }

        // Navigation property
        public virtual ICollection<OrderDetail>? OrderDetails { get; set; }
        public virtual MomoInfo? MomoInfo { get; set; }
        public virtual VnpayInfo? VnpayInfo { get; set; }
        public virtual ICollection<OrderHistory>? OrderHistories { get; set; }

        // Logic moves to Application or stayed if it's purely domain
        public bool CanCancel => Status == OrderStatus.New;
        public bool CanRepay => Status == OrderStatus.New && PaymentStatus != PaymentStatus.Paid && PaymentMethod != "COD";
        public bool CanRequestReturn => Status == OrderStatus.Completed;
        public bool CanComplete => Status == OrderStatus.Delivered;

        // Helper for UI display using Extensions
        [NotMapped]
        public string DisplayStatus => Status.ToAdminDisplay();

        [NotMapped]
        public string DisplayStatusForUser => Status.ToUserDisplay(PaymentStatus);
    }
}
