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

        public string CouponCode { get; set; }
        public decimal DiscountAmount { get; set; }

        // Helper for UI display as per user's logic
        public string DisplayStatus
        {
            get
            {
                // Pending = user hasn't paid yet (within 1 hour window)
                if (PaymentStatus == PaymentStatus.Pending)
                    return "Chờ thanh toán";

                // Failed or Cancelled = order is effectively dead
                if (PaymentStatus == PaymentStatus.Failed || Status == OrderStatus.Cancelled)
                    return "Đã hủy";

                if (PaymentStatus == PaymentStatus.Refunded)
                    return "Đã hoàn tiền";

                return Status switch
                {
                    OrderStatus.New => "Đơn hàng mới",
                    OrderStatus.Confirmed => "Đã xác nhận",
                    OrderStatus.Processing => "Đang xử lý",
                    OrderStatus.Shipping => "Đang giao hàng",
                    OrderStatus.Completed => "Hoàn thành",
                    _ => "Không xác định"
                };
            }
        }

        // Dành cho phía khách hàng: đơn Completed = "Đã nhận hàng"
        public string DisplayStatusForUser
        {
            get
            {
                if (PaymentStatus == PaymentStatus.Pending)
                    return "Chờ thanh toán";

                if (PaymentStatus == PaymentStatus.Failed || Status == OrderStatus.Cancelled)
                    return "Đã hủy";

                if (PaymentStatus == PaymentStatus.Refunded)
                    return "Đã hoàn tiền";

                return Status switch
                {
                    OrderStatus.New => "Đơn hàng mới",
                    OrderStatus.Confirmed => "Đã xác nhận",
                    OrderStatus.Processing => "Đang xử lý",
                    OrderStatus.Shipping => "Đang giao hàng",
                    OrderStatus.Completed => "Đã nhận hàng",
                    _ => "Không xác định"
                };
            }
        }
    }
}
