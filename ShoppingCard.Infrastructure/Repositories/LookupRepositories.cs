using Microsoft.EntityFrameworkCore;
using ShoppingCard.Domain.Entities;
using ShoppingCard.Domain.Interfaces;
using ShoppingCard.Infrastructure.Data;

namespace ShoppingCard.Infrastructure.Repositories
{
    public class CategoryRepository : ICategoryRepository
    {
        private readonly DataContext _context;

        public CategoryRepository(DataContext context)
        {
            _context = context;
        }

        public async Task<IEnumerable<Category>> GetAllAsync()
        {
            return await _context.Categories.ToListAsync();
        }

        public async Task<Category> GetByIdAsync(int id)
        {
            return await _context.Categories.FindAsync(id);
        }

        public async Task AddAsync(Category category)
        {
            await _context.Categories.AddAsync(category);
        }

        public void Update(Category category)
        {
            _context.Categories.Update(category);
        }

        public void Delete(Category category)
        {
            _context.Categories.Remove(category);
        }

        public async Task<bool> SlugExistsAsync(string slug, int? excludeId = null)
        {
            return await _context.Categories.AnyAsync(c => c.Slug == slug && c.Id != (excludeId ?? 0));
        }

        public async Task<Category> GetBySlugAsync(string slug)
        {
            return await _context.Categories.FirstOrDefaultAsync(c => c.Slug == slug);
        }

        public async Task<int> CountAsync()
        {
            return await _context.Categories.CountAsync();
        }

        public async Task SaveChangesAsync()
        {
            await _context.SaveChangesAsync();
        }
    }

    public class BrandRepository : IBrandRepository
    {
        private readonly DataContext _context;

        public BrandRepository(DataContext context)
        {
            _context = context;
        }

        public async Task<IEnumerable<Brand>> GetAllAsync()
        {
            return await _context.Brands.ToListAsync();
        }

        public async Task<Brand> GetByIdAsync(int id)
        {
            return await _context.Brands.FindAsync(id);
        }

        public async Task AddAsync(Brand brand)
        {
            await _context.Brands.AddAsync(brand);
        }

        public void Update(Brand brand)
        {
            _context.Brands.Update(brand);
        }

        public void Delete(Brand brand)
        {
            _context.Brands.Remove(brand);
        }

        public async Task<bool> SlugExistsAsync(string slug, int? excludeId = null)
        {
            return await _context.Brands.AnyAsync(b => b.Slug == slug && b.Id != (excludeId ?? 0));
        }

        public async Task<Brand> GetBySlugAsync(string slug)
        {
            return await _context.Brands.FirstOrDefaultAsync(b => b.Slug == slug);
        }

        public async Task SaveChangesAsync()
        {
            await _context.SaveChangesAsync();
        }
    }
}
