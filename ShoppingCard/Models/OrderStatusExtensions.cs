using System.ComponentModel.DataAnnotations;
namespace ShoppingCard.Models
{
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
