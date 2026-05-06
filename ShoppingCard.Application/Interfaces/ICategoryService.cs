using ShoppingCard.Application.DTOs;

namespace ShoppingCard.Application.Interfaces
{
    public interface ICategoryService
    {
        Task<IEnumerable<CategoryDto>> GetAllCategoriesAsync();
        Task<CategoryDto> GetCategoryByIdAsync(int id);
        Task CreateCategoryAsync(CategoryDto categoryDto);
        Task UpdateCategoryAsync(int id, CategoryDto categoryDto);
        Task DeleteCategoryAsync(int id);
        Task<bool> SlugExistsAsync(string slug, int? excludeId = null);
        Task<CategoryDto> GetCategoryBySlugAsync(string slug);
    }
}
