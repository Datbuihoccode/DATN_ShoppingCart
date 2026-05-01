namespace ShoppingCard.Models.Shipping
{
    public class ShippingShipmentResult
    {
        public bool IsSuccess { get; set; }
        public string Message { get; set; } = "";
        public string TrackingCode { get; set; } = "";
        public string RawStatus { get; set; } = "";
    }
}
