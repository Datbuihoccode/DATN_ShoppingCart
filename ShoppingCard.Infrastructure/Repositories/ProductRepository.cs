using Microsoft.EntityFrameworkCore;
using ShoppingCard.Domain.Entities;
using ShoppingCard.Domain.Interfaces;
using ShoppingCard.Infrastructure.Data;

namespace ShoppingCard.Infrastructure.Repositories
{
    public class ProductRepository : IProductRepository
    {
        private readonly DataContext _context;

        public ProductRepository(DataContext context)
        {
            _context = context;
        }

        public async Task<IEnumerable<Product>> GetAllAsync()
        {
            return await _context.Products
                .Include(p => p.Brand)
                .Include(p => p.ProductCategories)
                    .ThenInclude(pc => pc.Category)
                .OrderByDescending(p => p.Id)
                .ToListAsync();
        }

        public async Task<Product> GetByIdAsync(int id)
        {
            return await _context.Products
                .Include(p => p.Brand)
                .Include(p => p.ProductCategories)
                    .ThenInclude(pc => pc.Category)
                .FirstOrDefaultAsync(p => p.Id == id);
        }

        public async Task<Product> GetBySlugAsync(string slug)
        {
            return await _context.Products
                .Include(p => p.Brand)
                .Include(p => p.ProductCategories)
                    .ThenInclude(pc => pc.Category)
                .FirstOrDefaultAsync(p => p.Slug == slug);
        }

        public async Task AddAsync(Product product)
        {
            await _context.Products.AddAsync(product);
        }

        public void Update(Product product)
        {
            _context.Products.Update(product);
        }

        public void Delete(Product product)
        {
            _context.Products.Remove(product);
        }

        public async Task<bool> ExistsAsync(int id)
        {
            return await _context.Products.AnyAsync(p => p.Id == id);
        }

        public async Task<bool> SlugExistsAsync(string slug, int? excludeId = null)
        {
            return await _context.Products.AnyAsync(p => p.Slug == slug && p.Id != (excludeId ?? 0));
        }

        public async Task<IEnumerable<Product>> SearchAsync(string searchTerm)
        {
            return await _context.Products
                .Include(p => p.Brand)
                .Include(p => p.ProductCategories)
                    .ThenInclude(pc => pc.Category)
                .Where(p => p.Name.Contains(searchTerm) || p.Description.Contains(searchTerm))
                .ToListAsync();
        }

        public async Task<IEnumerable<Product>> GetRelatedProductsAsync(int productId, IEnumerable<int> categoryIds, int count = 10)
        {
            return await _context.Products
                .Include(p => p.ProductCategories)
                .Where(p => p.ProductCategories.Any(pc => categoryIds.Contains(pc.CategoryId)) && p.Id != productId)
                .OrderBy(x => Guid.NewGuid())
                .Take(count)
                .ToListAsync();
        }

        public async Task<int> CountAsync()
        {
            return await _context.Products.CountAsync();
        }

        public async Task<IEnumerable<Product>> GetTopProductsAsync(int count)
        {
            return await _context.Products
                .OrderByDescending(p => p.Sold)
                .Take(count)
                .ToListAsync();
        }

        public async Task<IEnumerable<Product>> GetLowStockProductsAsync(int threshold)
        {
            return await _context.Products
                .Where(p => p.Quantity < threshold)
                .OrderBy(p => p.Quantity)
                .ToListAsync();
        }

        public async Task<(IEnumerable<Product> Items, int TotalCount)> GetFilteredAsync(string categorySlug, string brandSlug, string sortBy, decimal? startPrice, decimal? endPrice, int page, int pageSize)
        {
            var query = _context.Products.AsQueryable();

            if (!string.IsNullOrEmpty(categorySlug))
            {
                query = query.Where(p => p.ProductCategories.Any(pc => pc.Category.Slug == categorySlug));
            }

            if (!string.IsNullOrEmpty(brandSlug))
            {
                query = query.Where(p => p.Brand.Slug == brandSlug);
            }

            if (startPrice.HasValue && endPrice.HasValue)
            {
                query = query.Where(p => p.Price >= startPrice.Value && p.Price <= endPrice.Value);
            }

            // Sorting
            switch (sortBy)
            {
                case "price_increase": query = query.OrderBy(p => p.Price); break;
                case "price_decrease": query = query.OrderByDescending(p => p.Price); break;
                case "price_newest": query = query.OrderByDescending(p => p.Id); break;
                case "price_oldest": query = query.OrderBy(p => p.Id); break;
                default: query = query.OrderByDescending(p => p.Id); break;
            }

            int totalCount = await query.CountAsync();
            var items = await query
                .Include(p => p.Brand)
                .Include(p => p.ProductCategories)
                    .ThenInclude(pc => pc.Category)
                .Skip((page - 1) * pageSize)
                .Take(pageSize)
                .ToListAsync();

            return (items, totalCount);
        }

        public async Task<IEnumerable<ProductQuantity>> GetQuantitiesAsync(int productId)
        {
            return await _context.ProductQuantities
                .Where(pq => pq.ProductId == productId)
                .ToListAsync();
        }

        public async Task AddQuantityAsync(ProductQuantity productQuantity)
        {
            await _context.ProductQuantities.AddAsync(productQuantity);
        }

        public async Task SaveChangesAsync()
        {
            await _context.SaveChangesAsync();
        }
    }
}
