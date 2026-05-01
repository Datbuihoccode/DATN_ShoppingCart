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
        [Display(Name = "Đã giao hàng")]
        Delivered = 4,
        [Display(Name = "Hoàn thành")]
        Completed = 5,
        [Display(Name = "Đã hủy")]
        Cancelled = 6,
        [Display(Name = "Đã nhận lại hàng")]
        Returned = 7,
        [Display(Name = "Yêu cầu trả hàng")]
        ReturnRequested = 8,
        [Display(Name = "Duyệt trả hàng")]
        Approved = 9,
        [Display(Name = "Hàng đang về kho")]
        Returning = 10,
        [Display(Name = "Từ chối trả hàng")]
        ReturnRejected = 11,
        [Display(Name = "Giao hàng thất bại")]
        DeliveryFailed = 12
    }

    public enum PaymentStatus
    {
        [Display(Name = "Chưa thanh toán")]
        Unpaid = 0,
        [Display(Name = "Đang chờ thanh toán")]
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
        COD,
        Momo,
        VnPay
    }
}
