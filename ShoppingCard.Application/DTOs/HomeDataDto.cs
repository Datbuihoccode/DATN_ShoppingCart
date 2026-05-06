namespace ShoppingCard.Application.DTOs
{
    public class HomeSectionDto
    {
        public long CategoryId { get; set; }
        public string CategoryName { get; set; }
        public string CategorySlug { get; set; }
        public List<ProductDto> Products { get; set; } = new();
    }

    public class HomeDataDto
    {
        public List<HomeSectionDto> Sections { get; set; } = new();
        public List<SliderDto> Sliders { get; set; } = new();
    }

}
