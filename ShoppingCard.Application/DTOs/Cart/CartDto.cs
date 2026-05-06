namespace ShoppingCard.Application.DTOs.Cart
{
    public class CartItemDto
    {
        public int ProductId { get; set; }
        public string ProductName { get; set; }
        public int Quantity { get; set; }
        public decimal Price { get; set; }
        public string Image { get; set; }
        public decimal Total => Price * Quantity;
    }

    public class CartViewModelDto
    {
        public List<CartItemDto> CartItems { get; set; } = new();
        public decimal GrandTotal { get; set; }
        public string CouponCode { get; set; }
        public decimal DiscountAmount { get; set; }
        public string CouponMessage { get; set; }
    }
}
