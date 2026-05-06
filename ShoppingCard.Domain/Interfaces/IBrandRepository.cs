using ShoppingCard.Domain.Entities;

namespace ShoppingCard.Domain.Interfaces
{
    public interface IBrandRepository
    {
        Task<IEnumerable<Brand>> GetAllAsync();
        Task<Brand> GetByIdAsync(int id);
        Task AddAsync(Brand brand);
        void Update(Brand brand);
        void Delete(Brand brand);
        Task<bool> SlugExistsAsync(string slug, int? excludeId = null);
        Task<Brand> GetBySlugAsync(string slug);
        Task SaveChangesAsync();
    }
}
