using ShoppingCard.Application.DTOs;
using ShoppingCard.Application.Interfaces;
using ShoppingCard.Domain.Entities;
using ShoppingCard.Domain.Interfaces;

namespace ShoppingCard.Application.Services
{
    public class CategoryService : ICategoryService
    {
        private readonly ICategoryRepository _categoryRepository;

        public CategoryService(ICategoryRepository categoryRepository)
        {
            _categoryRepository = categoryRepository;
        }

        public async Task<IEnumerable<CategoryDto>> GetAllCategoriesAsync()
        {
            var categories = await _categoryRepository.GetAllAsync();
            return categories.Select(c => new CategoryDto
            {
                Id = c.Id,
                Name = c.Name,
                Description = c.Description,
                Slug = c.Slug,
                Status = c.Status
            });
        }

        public async Task<CategoryDto> GetCategoryByIdAsync(int id)
        {
            var c = await _categoryRepository.GetByIdAsync(id);
            if (c == null) return null;

            return new CategoryDto
            {
                Id = c.Id,
                Name = c.Name,
                Description = c.Description,
                Slug = c.Slug,
                Status = c.Status
            };
        }

        public async Task CreateCategoryAsync(CategoryDto dto)
        {
            if (string.IsNullOrEmpty(dto.Slug))
            {
                dto.Slug = dto.Name.Replace(" ", "-").ToLower();
            }

            if (await _categoryRepository.SlugExistsAsync(dto.Slug))
            {
                throw new Exception("Danh mục với slug này đã tồn tại.");
            }

            var category = new Category
            {
                Name = dto.Name,
                Description = dto.Description,
                Slug = dto.Slug,
                Status = dto.Status
            };

            await _categoryRepository.AddAsync(category);
            await _categoryRepository.SaveChangesAsync();
        }

        public async Task UpdateCategoryAsync(int id, CategoryDto dto)
        {
            var existing = await _categoryRepository.GetByIdAsync(id);
            if (existing == null) throw new Exception("Không tìm thấy danh mục.");

            if (string.IsNullOrEmpty(dto.Slug))
            {
                dto.Slug = dto.Name.Replace(" ", "-").ToLower();
            }

            if (await _categoryRepository.SlugExistsAsync(dto.Slug, id))
            {
                throw new Exception("Danh mục với slug này đã tồn tại.");
            }

            existing.Name = dto.Name;
            existing.Description = dto.Description;
            existing.Slug = dto.Slug;
            existing.Status = dto.Status;

            _categoryRepository.Update(existing);
            await _categoryRepository.SaveChangesAsync();
        }

        public async Task DeleteCategoryAsync(int id)
        {
            var existing = await _categoryRepository.GetByIdAsync(id);
            if (existing != null)
            {
                _categoryRepository.Delete(existing);
                await _categoryRepository.SaveChangesAsync();
            }
        }

        public async Task<bool> SlugExistsAsync(string slug, int? excludeId = null)
        {
            return await _categoryRepository.SlugExistsAsync(slug, excludeId);
        }

        public async Task<CategoryDto> GetCategoryBySlugAsync(string slug)
        {
            var c = await _categoryRepository.GetBySlugAsync(slug);
            if (c == null) return null;

            return new CategoryDto
            {
                Id = c.Id,
                Name = c.Name,
                Description = c.Description,
                Slug = c.Slug,
                Status = c.Status
            };
        }
    }
}
