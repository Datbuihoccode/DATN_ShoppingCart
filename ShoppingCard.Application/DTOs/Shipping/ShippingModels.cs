using System.ComponentModel.DataAnnotations;

namespace ShoppingCard.Application.DTOs.Shipping
{
    public class CheckoutShippingInput
    {
        [Required(ErrorMessage = "Vui lòng nhập Email")]
        [EmailAddress(ErrorMessage = "Email không hợp lệ")]
        public string ShippingEmail { get; set; }

        [Required(ErrorMessage = "Vui lòng nhập họ tên người nhận")]
        public string ShippingName { get; set; }

        [Required(ErrorMessage = "Vui lòng nhập số điện thoại")]
        [Phone(ErrorMessage = "Số điện thoại không hợp lệ")]
        public string ShippingPhone { get; set; }

        [Required(ErrorMessage = "Vui lòng chọn Tỉnh/Thành")]
        public string ShippingProvince { get; set; }

        [Required(ErrorMessage = "Vui lòng chọn Quận/Huyện")]
        public int ShippingDistrictId { get; set; }

        [Required(ErrorMessage = "Vui lòng chọn Phường/Xã")]
        public string ShippingWardCode { get; set; }

        [Required(ErrorMessage = "Vui lòng nhập địa chỉ cụ thể")]
        public string ShippingAddress { get; set; }

        public string ShippingProvinceName { get; set; }
        public string ShippingDistrictName { get; set; }
        public string ShippingWardName { get; set; }

        public string OrderNote { get; set; }
    }

    public class ShippingLocationModel
    {
        public string Code { get; set; }
        public string Name { get; set; }
    }

    public class ShippingQuoteRequest
    {
        public int DistrictId { get; set; }
        public string WardCode { get; set; }
        public int TotalWeight { get; set; }
    }

    public class ShippingQuoteResult
    {
        public bool IsSuccess { get; set; }
        public decimal Fee { get; set; }
        public string Message { get; set; }
    }

    public class ShippingShipmentResult
    {
        public bool IsSuccess { get; set; }
        public string TrackingCode { get; set; }
        public string Message { get; set; }
    }
}
