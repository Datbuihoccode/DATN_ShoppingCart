namespace ShoppingCard.Models
{
    public class OrderInfo
    {
        public string FullName { get; set; }
        public string OrderId { get; set; }
        public string OrderInformation { get; set; }
        public decimal Amount { get; set; }
        public string RequestType { get; set; }
        public string ReturnUrl { get; set; }
        public string NotifyUrl { get; set; }
    }
}
