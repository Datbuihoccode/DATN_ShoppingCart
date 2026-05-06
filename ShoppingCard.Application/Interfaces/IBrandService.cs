using ShoppingCard.Application.DTOs;

namespace ShoppingCard.Application.Interfaces
{
    public interface IBrandService
    {
        Task<IEnumerable<BrandDto>> GetAllBrandsAsync();
        Task<BrandDto> GetBrandByIdAsync(int id);
        Task CreateBrandAsync(BrandDto brandDto);
        Task UpdateBrandAsync(int id, BrandDto brandDto);
        Task DeleteBrandAsync(int id);
        Task<BrandDto> GetBrandBySlugAsync(string slug);
    }
}
