namespace ShoppingCard.Models.ViewsModels
{
    public class CartItemViewModel
    {
        public List<CartItemModel> CartItems { get; set; }
        public decimal GrandTotal { get; set; }
        
        // Add coupon tracking
        public string CouponCode { get; set; }
        public decimal DiscountAmount { get; set; }
        public string CouponMessage { get; set; }
    }
}
