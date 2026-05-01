using System.ComponentModel.DataAnnotations;

namespace ShoppingCard.Models.Shipping
{
    public class ShippingQuoteRequest
    {
        [Range(0, int.MaxValue)]
        public int ToDistrictId { get; set; }

        [MaxLength(20)]
        public string? ToWardCode { get; set; }

        [Range(0, int.MaxValue)]
        public int ToProvinceId { get; set; }

        [Range(0, int.MaxValue)]
        public int ToWardIdV2 { get; set; }

        [MaxLength(300)]
        public string? ToAddressV2 { get; set; }
    }
}
