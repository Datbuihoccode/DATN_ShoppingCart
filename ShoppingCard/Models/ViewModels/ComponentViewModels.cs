using System.Collections.Generic;
using ShoppingCard.Domain.Entities;

namespace ShoppingCard.Models.ViewModels
{
    public class HeaderMenuViewModel
    {
        public IEnumerable<Category> Categories { get; set; } = new List<Category>();
        public IEnumerable<Brand> Brands { get; set; } = new List<Brand>();
    }

    public class ProductDetailViewModel
    {
        public Product ProductDetails { get; set; }
        public IEnumerable<Rating> Ratings { get; set; } = new List<Rating>();
        public IEnumerable<Product> RelatedProducts { get; set; } = new List<Product>();
        public string Name { get; set; }
        public string Email { get; set; }
        public string Comment { get; set; }
    }

    public class WishlistModel
    {
        public long ProductId { get; set; }
        public Product Product { get; set; }
    }
}
