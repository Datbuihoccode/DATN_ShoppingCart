namespace ShoppingCard.Models.VNP
{
    public class PaymentInformationModel
    {
        public string OrderType { get; set; }
        public decimal Amount { get; set; }
        public string OrderDescription { get; set; }
        public string Name { get; set; }
        public string OrderId { get; set; }
        public DateTime CreatedDate { get; set; }
    }
}
