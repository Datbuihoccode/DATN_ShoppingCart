using System.Globalization;

namespace ShoppingCard.Models
{
    public class OrderModel
    {
        public int Id { get; set; }
        public string OrderCode { get; set; }
        public string UserName { get; set; }
        public DateTime CreateDate { get; set; }

        public OrderStatus Status { get; set; }
        public PaymentStatus PaymentStatus { get; set; }
        public string PaymentMethod { get; set; } // Keeps string for details like "VNPAY 123456"
        public string ShippingPhone { get; set; }  // Phone number entered at checkout
        public string ShippingAddress { get; set; }
        public int? ShippingDistrictId { get; set; }  // Lưu province_id trong luồng địa chỉ mới
        public string ShippingWardCode { get; set; }  // Lưu ward_id_v2 (string) trong luồng địa chỉ mới
        public string ShippingProvinceName { get; set; }  // Tên tỉnh/thành mới (cho GHN tạo đơn)
        public string ShippingWardName { get; set; }  // Tên phường/xã mới (cho GHN tạo đơn)
        [System.ComponentModel.DataAnnotations.Schema.Column(TypeName = "decimal(18,2)")]
        public decimal ShippingFee { get; set; }
        public string ShippingProvider { get; set; }
        public string ShippingTrackingCode { get; set; }
        public string ShippingStatus { get; set; }
        public string CouponCode { get; set; }
        public decimal DiscountAmount { get; set; }

        // Navigation property
        public virtual ICollection<OrderDetailsModel> OrderDetails { get; set; }
        public virtual MomoInfoModel MomoInfo { get; set; }
        public virtual VnpayModel VnpayInfo { get; set; }
        public virtual ICollection<OrderHistoryModel> OrderHistories { get; set; }

        // Helper for UI display using Extensions
        public string DisplayStatus => Status.ToAdminDisplay();

        // Dành cho phía khách hàng
        public string DisplayStatusForUser => Status.ToUserDisplay(PaymentStatus);

        public bool CanCancel => Status == OrderStatus.New;
        public bool CanRepay => Status == OrderStatus.New && PaymentStatus != PaymentStatus.Paid && PaymentMethod != "COD";
        public bool CanRequestReturn => Status == OrderStatus.Completed;
        public bool CanComplete => Status == OrderStatus.Delivered; // Khách hàng hoặc admin xác nhận đã nhận hàng

    }
}
