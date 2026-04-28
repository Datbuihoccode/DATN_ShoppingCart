using System.ComponentModel.DataAnnotations;

namespace ShoppingCard.Models
{
    public enum OrderStatus
    {
        [Display(Name = "Đơn hàng mới")]
        New = 0,
        [Display(Name = "Đã xác nhận")]
        Confirmed = 1,
        [Display(Name = "Đang xử lý")]
        Processing = 2,
        [Display(Name = "Đang giao hàng")]
        Shipping = 3,
        [Display(Name = "Đã hoàn thành")]
        Completed = 4,
        [Display(Name = "Đã hủy")]
        Cancelled = 5
    }

    public enum PaymentStatus
    {
        [Display(Name = "Chưa thanh toán")]
        Unpaid = 0,
        [Display(Name = "Chờ thanh toán")]
        Pending = 1,
        [Display(Name = "Đã thanh toán")]
        Paid = 2,
        [Display(Name = "Thanh toán thất bại")]
        Failed = 3,
        [Display(Name = "Đã hoàn tiền")]
        Refunded = 4
    }

    public enum PaymentMethod
    {
        [Display(Name = "Tiền mặt (COD)")]
        COD = 0,
        [Display(Name = "VNPAY")]
        VnPay = 1,
        [Display(Name = "MOMO")]
        Momo = 2
    }
}
