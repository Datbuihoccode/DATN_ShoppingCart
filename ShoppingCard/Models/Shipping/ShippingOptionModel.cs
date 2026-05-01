namespace ShoppingCard.Models.Shipping
{
    public class ShippingOptionModel
    {
        public bool Enabled { get; set; }
        public string Provider { get; set; } = string.Empty;
        public string BaseUrl { get; set; } = string.Empty;
        public string Token { get; set; } = string.Empty;
        public int ShopId { get; set; }
        public int FromDistrictId { get; set; }
        public string FromWardCode { get; set; } = string.Empty;
        public string FromName { get; set; } = string.Empty;
        public string FromPhone { get; set; } = string.Empty;
        public string FromAddress { get; set; } = string.Empty;
        public string FromWardName { get; set; } = string.Empty;
        public string FromDistrictName { get; set; } = string.Empty;
        public string FromProvinceName { get; set; } = string.Empty;
        public int FromProvinceId { get; set; }
        public bool IsNewFromAddress { get; set; }
        public int ServiceTypeId { get; set; }
        public int DefaultItemWeightGram { get; set; }
    }
}
