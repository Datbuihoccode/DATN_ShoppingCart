using ShoppingCard.Application.DTOs;

namespace ShoppingCard.Application.Interfaces
{
    public interface IProductService
    {
        Task<IEnumerable<ProductDto>> GetProductsAsync();
        Task<ProductDto> GetProductByIdAsync(int id);
        Task<int> CreateProductAsync(CreateProductDto productDto);
        Task UpdateProductAsync(int id, CreateProductDto productDto);
        Task DeleteProductAsync(int id);

        // Client methods
        Task<ProductDto> GetProductBySlugAsync(string slug);
        Task<IEnumerable<ProductDto>> SearchProductsAsync(string searchTerm);
        Task<IEnumerable<ProductDto>> GetRelatedProductsAsync(int productId, IEnumerable<int> categoryIds);
        Task AddRatingAsync(RatingDto ratingDto);
        Task<bool> HasUserPurchasedProductAsync(int productId, string userName);
        Task<PaginatedListDto<ProductDto>> GetFilteredProductsAsync(ProductFilterDto filter);
        Task<HomeDataDto> GetHomeDataAsync();

        Task<IEnumerable<ShoppingCard.Domain.Entities.ProductQuantity>> GetProductQuantitiesAsync(int productId);
        Task AddProductQuantityAsync(int productId, int quantity);
    }
}
