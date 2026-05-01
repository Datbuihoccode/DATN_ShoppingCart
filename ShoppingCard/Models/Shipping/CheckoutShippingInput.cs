using System.ComponentModel.DataAnnotations;

namespace ShoppingCard.Models.Shipping
{
    public class CheckoutShippingInput
    {
        [Required]
        [RegularExpression(@"^(0|\+84)[3-9]\d{8}$")]
        public string ShippingPhone { get; set; }
        public string ShippingFullName { get; set; }

        [Required]
        [MaxLength(300)]
        public string ShippingAddress { get; set; }

        // --- Địa chỉ cũ (3 cấp: tỉnh/huyện/xã) ---
        [Range(1, int.MaxValue)]
        public int ShippingDistrictId { get; set; }

        [MaxLength(20)]
        public string? ShippingWardCode { get; set; }

        // --- Địa chỉ mới sau sáp nhập (2 cấp: tỉnh/xã theo GHN v3) ---
        [Range(0, int.MaxValue)]
        public int ShippingProvinceId { get; set; }   // province_id từ API v3

        [Range(0, int.MaxValue)]
        public int ShippingWardIdV2 { get; set; }     // ward_id từ API v3

        [MaxLength(200)]
        public string? ShippingProvinceName { get; set; }  // Tên tỉnh (to_province_name)

        [MaxLength(200)]
        public string? ShippingWardName { get; set; }      // Tên phường/xã (to_ward_name)

        [Range(0, double.MaxValue)]
        public decimal ShippingFee { get; set; }
    }
}
