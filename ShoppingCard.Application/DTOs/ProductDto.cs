namespace ShoppingCard.Application.DTOs
{
    public class ProductDto
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string Slug { get; set; }
        public string Description { get; set; }
        public decimal Price { get; set; }
        public int BrandId { get; set; }
        public string BrandName { get; set; }
        public string Condition { get; set; }
        public string Image { get; set; }
        public int Quantity { get; set; }
        public int Sold { get; set; }
        public int? WeightGram { get; set; }
        public List<int> CategoryIds { get; set; }
        public List<string> CategoryNames { get; set; }
    }
}
