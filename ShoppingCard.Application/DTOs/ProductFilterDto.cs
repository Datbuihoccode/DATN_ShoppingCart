namespace ShoppingCard.Application.DTOs
{
    public class ProductFilterDto
    {
        public string CategorySlug { get; set; }
        public string BrandSlug { get; set; }
        public string SortBy { get; set; }
        public decimal? StartPrice { get; set; }
        public decimal? EndPrice { get; set; }
        public int Page { get; set; } = 1;
        public int PageSize { get; set; } = 40;
    }

    public class PaginatedListDto<T>
    {
        public List<T> Items { get; set; } = new();
        public int CurrentPage { get; set; }
        public int TotalPages { get; set; }
        public int TotalItems { get; set; }
    }
}
