using ShoppingCard.Domain.Entities;

namespace ShoppingCard.Domain.Interfaces
{
    public interface ICategoryRepository
    {
        Task<IEnumerable<Category>> GetAllAsync();
        Task<Category> GetByIdAsync(int id);
        Task AddAsync(Category category);
        void Update(Category category);
        void Delete(Category category);
        Task<bool> SlugExistsAsync(string slug, int? excludeId = null);
        Task<Category> GetBySlugAsync(string slug);
        Task<int> CountAsync();
        Task SaveChangesAsync();
    }
}
