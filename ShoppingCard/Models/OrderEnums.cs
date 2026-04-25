namespace ShoppingCard.Models
{
    public enum OrderStatus
    {
        New = 0,        // Đơn hàng mới tạo
        Confirmed = 1,  // Đã xác nhận
        Processing = 2, // Đang xử lý (đóng gói)
        Shipping = 3,    // Đang giao hàng
        Completed = 4,   // Đã hoàn thành
        Cancelled = 5    // Đã hủy
    }

    public enum PaymentStatus
    {
        Unpaid = 0,    // Chưa thanh toán (dùng cho COD)
        Pending = 1,   // Đang chờ thanh toán (chỉ dùng cho Online)
        Paid = 2,      // Đã thanh toán
        Failed = 3,    // Thanh toán thất bại
        Refunded = 4   // Đã hoàn tiền
    }

    public enum PaymentMethod
    {
        COD = 0,
        VnPay = 1,
        Momo = 2
    }
}
