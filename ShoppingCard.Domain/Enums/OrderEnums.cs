using System.ComponentModel.DataAnnotations;

namespace ShoppingCard.Domain.Enums
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

    public static class OrderStatusExtensions
    {
        public static string ToAdminDisplay(this OrderStatus status)
        {
            return status switch
            {
                OrderStatus.New => "Đơn hàng mới",
                OrderStatus.Confirmed => "Đã xác nhận",
                OrderStatus.Processing => "Chuẩn bị đơn hàng",
                OrderStatus.Shipping => "Đang giao hàng",
                OrderStatus.Delivered => "Đã giao hàng",
                OrderStatus.Completed => "Hoàn thành",
                OrderStatus.Cancelled => "Đã hủy",
                OrderStatus.Returned => "Đã nhận lại hàng",
                OrderStatus.ReturnRequested => "Yêu cầu trả hàng",
                OrderStatus.Approved => "Duyệt trả hàng",
                OrderStatus.Returning => "Hàng đang về kho",
                OrderStatus.ReturnRejected => "Từ chối trả hàng",
                OrderStatus.DeliveryFailed => "Giao hàng thất bại",
                _ => "Không xác định"
            };
        }

        public static string ToUserDisplay(this OrderStatus status, PaymentStatus paymentStatus = PaymentStatus.Unpaid)
        {
            if (paymentStatus == PaymentStatus.Pending)
                return "Chờ thanh toán";

            return status switch
            {
                OrderStatus.New => "Chờ xác nhận",
                OrderStatus.Confirmed => "Đã xác nhận",
                OrderStatus.Processing => "Đang chuẩn bị hàng",
                OrderStatus.Shipping => "Đang giao hàng",
                OrderStatus.Delivered => "Đã giao hàng (Chờ xác nhận)",
                OrderStatus.Completed => "Hoàn tất",
                OrderStatus.Cancelled => "Đã hủy",
                OrderStatus.Returned => "Đã hoàn trả hàng",
                OrderStatus.ReturnRequested => "Đang yêu cầu trả hàng",
                OrderStatus.Approved => "Chờ gửi hàng về",
                OrderStatus.Returning => "Hàng đang chuyển hoàn",
                OrderStatus.ReturnRejected => "Yêu cầu bị từ chối",
                OrderStatus.DeliveryFailed => "Giao hàng không thành công",
                _ => "Không xác định"
            };
        }
    }
}
