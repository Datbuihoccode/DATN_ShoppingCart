namespace ShoppingCard.Models.Shipping
{
    public class ShippingLocationModel
    {
        public string Code { get; set; } = "";
        public string Name { get; set; } = "";
        public string ParentId { get; set; } = ""; // Added to store ProvinceId or DistrictId relationship
    }
}
