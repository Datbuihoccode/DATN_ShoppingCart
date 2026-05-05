namespace ShoppingCard.Models.ViewsModels
{
    public class HomeCategorySectionViewModel
    {
        public int CategoryId { get; set; }
        public string CategoryName { get; set; } = string.Empty;
        public string CategorySlug { get; set; } = string.Empty;
        public List<ProductModel> Products { get; set; } = new();
    }
}
