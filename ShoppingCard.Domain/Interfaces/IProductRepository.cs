using ShoppingCard.Domain.Entities;

namespace ShoppingCard.Domain.Interfaces
{
    public interface IProductRepository
    {
        Task<IEnumerable<Product>> GetAllAsync();
        Task<Product> GetByIdAsync(int id);
        Task<Product> GetBySlugAsync(string slug);
        Task AddAsync(Product product);
        void Update(Product product);
        void Delete(Product product);
        Task<bool> ExistsAsync(int id);
        Task<bool> SlugExistsAsync(string slug, int? excludeId = null);
        Task<IEnumerable<Product>> SearchAsync(string searchTerm);
        Task<IEnumerable<Product>> GetRelatedProductsAsync(int productId, IEnumerable<int> categoryIds, int count = 10);
        Task<int> CountAsync();
        Task<IEnumerable<Product>> GetTopProductsAsync(int count);
        Task<IEnumerable<Product>> GetLowStockProductsAsync(int threshold);
        Task<(IEnumerable<Product> Items, int TotalCount)> GetFilteredAsync(string categorySlug, string brandSlug, string sortBy, decimal? startPrice, decimal? endPrice, int page, int pageSize);
        
        Task<IEnumerable<ProductQuantity>> GetQuantitiesAsync(int productId);
        Task AddQuantityAsync(ProductQuantity productQuantity);

        Task SaveChangesAsync();
    }
}
