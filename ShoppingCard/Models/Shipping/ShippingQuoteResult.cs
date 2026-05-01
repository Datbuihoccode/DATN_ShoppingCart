namespace ShoppingCard.Models.Shipping
{
    public class ShippingQuoteResult
    {
        public bool IsSuccess { get; set; }
        public string Message { get; set; } = "";
        public decimal Fee { get; set; }
    }
}
