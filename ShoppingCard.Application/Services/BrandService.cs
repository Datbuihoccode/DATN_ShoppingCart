using ShoppingCard.Application.DTOs;
using ShoppingCard.Application.Interfaces;
using ShoppingCard.Domain.Entities;
using ShoppingCard.Domain.Interfaces;

namespace ShoppingCard.Application.Services
{
    public class BrandService : IBrandService
    {
        private readonly IBrandRepository _brandRepository;

        public BrandService(IBrandRepository brandRepository)
        {
            _brandRepository = brandRepository;
        }

        public async Task<IEnumerable<BrandDto>> GetAllBrandsAsync()
        {
            var brands = await _brandRepository.GetAllAsync();
            return brands.Select(b => new BrandDto
            {
                Id = b.Id,
                Name = b.Name,
                Description = b.Description,
                Slug = b.Slug,
                Status = b.Status
            });
        }

        public async Task<BrandDto> GetBrandByIdAsync(int id)
        {
            var b = await _brandRepository.GetByIdAsync(id);
            if (b == null) return null;

            return new BrandDto
            {
                Id = b.Id,
                Name = b.Name,
                Description = b.Description,
                Slug = b.Slug,
                Status = b.Status
            };
        }

        public async Task CreateBrandAsync(BrandDto dto)
        {
            if (string.IsNullOrEmpty(dto.Slug))
            {
                dto.Slug = dto.Name.Replace(" ", "-").ToLower();
            }

            if (await _brandRepository.SlugExistsAsync(dto.Slug))
            {
                throw new Exception("Thương hiệu với slug này đã tồn tại.");
            }

            var brand = new Brand
            {
                Name = dto.Name,
                Description = dto.Description,
                Slug = dto.Slug,
                Status = dto.Status
            };

            await _brandRepository.AddAsync(brand);
            await _brandRepository.SaveChangesAsync();
        }

        public async Task UpdateBrandAsync(int id, BrandDto dto)
        {
            var existing = await _brandRepository.GetByIdAsync(id);
            if (existing == null) throw new Exception("Không tìm thấy thương hiệu.");

            if (string.IsNullOrEmpty(dto.Slug))
            {
                dto.Slug = dto.Name.Replace(" ", "-").ToLower();
            }

            if (await _brandRepository.SlugExistsAsync(dto.Slug, id))
            {
                throw new Exception("Thương hiệu với slug này đã tồn tại.");
            }

            existing.Name = dto.Name;
            existing.Description = dto.Description;
            existing.Slug = dto.Slug;
            existing.Status = dto.Status;

            _brandRepository.Update(existing);
            await _brandRepository.SaveChangesAsync();
        }

        public async Task DeleteBrandAsync(int id)
        {
            var existing = await _brandRepository.GetByIdAsync(id);
            if (existing != null)
            {
                _brandRepository.Delete(existing);
                await _brandRepository.SaveChangesAsync();
            }
        }

        public async Task<BrandDto> GetBrandBySlugAsync(string slug)
        {
            var b = await _brandRepository.GetBySlugAsync(slug);
            if (b == null) return null;

            return new BrandDto
            {
                Id = b.Id,
                Name = b.Name,
                Description = b.Description,
                Slug = b.Slug,
                Status = b.Status
            };
        }
    }
}
