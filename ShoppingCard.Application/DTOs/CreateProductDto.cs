using Microsoft.AspNetCore.Http;

namespace ShoppingCard.Application.DTOs
{
    public class CreateProductDto
    {
        public long Id { get; set; }
        public string Name { get; set; }
        public string Slug { get; set; }
        public string Description { get; set; }
        public decimal Price { get; set; }
        public int BrandId { get; set; }
        public string Condition { get; set; }
        public int? WeightGram { get; set; }
        public List<long> CategoryIds { get; set; }
        public IFormFile ImageUpload { get; set; }
    }
}
