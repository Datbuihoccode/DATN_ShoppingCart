using ShoppingCard.Application.DTOs;
using ShoppingCard.Application.Interfaces;
using ShoppingCard.Domain.Entities;
using ShoppingCard.Domain.Interfaces;

namespace ShoppingCard.Application.Services
{
    public class ProductService : IProductService
    {
        private readonly IProductRepository _productRepository;
        private readonly IRatingRepository _ratingRepository;
        private readonly ICategoryRepository _categoryRepository;
        private readonly ISliderRepository _sliderRepository;
        private readonly IFileService _fileService;

        public ProductService(
            IProductRepository productRepository, 
            IRatingRepository ratingRepository, 
            ICategoryRepository categoryRepository,
            ISliderRepository sliderRepository,
            IFileService fileService)
        {
            _productRepository = productRepository;
            _ratingRepository = ratingRepository;
            _categoryRepository = categoryRepository;
            _sliderRepository = sliderRepository;
            _fileService = fileService;
        }

        public async Task<IEnumerable<ProductDto>> GetProductsAsync()
        {
            var products = await _productRepository.GetAllAsync();
            return products.Select(p => new ProductDto
            {
                Id = p.Id,
                Name = p.Name,
                Slug = p.Slug,
                Description = p.Description,
                Price = p.Price,
                BrandId = p.BrandId,
                BrandName = p.Brand?.Name,
                Condition = p.Condition,
                Image = p.Image,
                Quantity = p.Quantity,
                Sold = p.Sold,
                WeightGram = p.WeightGram,
                CategoryIds = p.ProductCategories.Select(pc => pc.CategoryId).ToList(),
                CategoryNames = p.ProductCategories.Select(pc => pc.Category?.Name).ToList()
            });
        }

        public async Task<ProductDto> GetProductByIdAsync(int id)
        {
            var p = await _productRepository.GetByIdAsync(id);
            if (p == null) return null;

            return new ProductDto
            {
                Id = p.Id,
                Name = p.Name,
                Slug = p.Slug,
                Description = p.Description,
                Price = p.Price,
                BrandId = p.BrandId,
                BrandName = p.Brand?.Name,
                Condition = p.Condition,
                Image = p.Image,
                Quantity = p.Quantity,
                Sold = p.Sold,
                WeightGram = p.WeightGram,
                CategoryIds = p.ProductCategories.Select(pc => pc.CategoryId).ToList(),
                CategoryNames = p.ProductCategories.Select(pc => pc.Category?.Name).ToList()
            };
        }

        public async Task<int> CreateProductAsync(CreateProductDto dto)
        {
            // Business logic: generate slug if empty
            if (string.IsNullOrEmpty(dto.Slug))
            {
                dto.Slug = dto.Name.Replace(" ", "-").ToLower();
            }

            // Validation: check slug uniqueness
            if (await _productRepository.SlugExistsAsync(dto.Slug))
            {
                throw new Exception("Sản phẩm với slug này đã tồn tại.");
            }

            // Handle image upload
            string imageName = await _fileService.UploadImageAsync(dto.ImageUpload, "media/products");

            var product = new Product
            {
                Name = dto.Name,
                Slug = dto.Slug,
                Description = dto.Description,
                Price = dto.Price,
                BrandId = dto.BrandId,
                Condition = dto.Condition,
                WeightGram = dto.WeightGram,
                Image = imageName,
                ProductCategories = dto.CategoryIds.Select(catId => new ProductCategory { CategoryId = catId }).ToList()
            };

            await _productRepository.AddAsync(product);
            await _productRepository.SaveChangesAsync();

            return product.Id;
        }

        public async Task UpdateProductAsync(int id, CreateProductDto dto)
        {
            var existingProduct = await _productRepository.GetByIdAsync(id);
            if (existingProduct == null) throw new Exception("Không tìm thấy sản phẩm.");

            if (string.IsNullOrEmpty(dto.Slug))
            {
                dto.Slug = dto.Name.Replace(" ", "-").ToLower();
            }

            if (await _productRepository.SlugExistsAsync(dto.Slug, id))
            {
                throw new Exception("Sản phẩm với slug này đã tồn tại.");
            }

            // Handle image upload
            if (dto.ImageUpload != null)
            {
                _fileService.DeleteImage(existingProduct.Image, "media/products");
                existingProduct.Image = await _fileService.UploadImageAsync(dto.ImageUpload, "media/products");
            }

            existingProduct.Name = dto.Name;
            existingProduct.Slug = dto.Slug;
            existingProduct.Description = dto.Description;
            existingProduct.Price = dto.Price;
            existingProduct.BrandId = dto.BrandId;
            existingProduct.Condition = dto.Condition;
            existingProduct.WeightGram = dto.WeightGram;

            // Update categories
            existingProduct.ProductCategories.Clear();
            foreach (var catId in dto.CategoryIds)
            {
                existingProduct.ProductCategories.Add(new ProductCategory { ProductId = id, CategoryId = catId });
            }

            _productRepository.Update(existingProduct);
            await _productRepository.SaveChangesAsync();
        }

        public async Task DeleteProductAsync(int id)
        {
            var product = await _productRepository.GetByIdAsync(id);
            if (product != null)
            {
                _fileService.DeleteImage(product.Image, "media/products");
                _productRepository.Delete(product);
                await _productRepository.SaveChangesAsync();
            }
        }

        public async Task<ProductDto> GetProductBySlugAsync(string slug)
        {
            var p = await _productRepository.GetBySlugAsync(slug);
            if (p == null) return null;

            return new ProductDto
            {
                Id = p.Id,
                Name = p.Name,
                Slug = p.Slug,
                Description = p.Description,
                Price = p.Price,
                BrandId = p.BrandId,
                BrandName = p.Brand?.Name,
                Condition = p.Condition,
                Image = p.Image,
                Quantity = p.Quantity,
                Sold = p.Sold,
                WeightGram = p.WeightGram,
                CategoryIds = p.ProductCategories.Select(pc => pc.CategoryId).ToList(),
                CategoryNames = p.ProductCategories.Select(pc => pc.Category?.Name).ToList()
            };
        }

        public async Task<IEnumerable<ProductDto>> SearchProductsAsync(string searchTerm)
        {
            var products = await _productRepository.SearchAsync(searchTerm);
            return products.Select(p => new ProductDto
            {
                Id = p.Id,
                Name = p.Name,
                Slug = p.Slug,
                Description = p.Description,
                Price = p.Price,
                BrandId = p.BrandId,
                BrandName = p.Brand?.Name,
                Condition = p.Condition,
                Image = p.Image,
                Quantity = p.Quantity,
                Sold = p.Sold,
                WeightGram = p.WeightGram,
                CategoryIds = p.ProductCategories.Select(pc => pc.CategoryId).ToList(),
                CategoryNames = p.ProductCategories.Select(pc => pc.Category?.Name).ToList()
            });
        }

        public async Task<IEnumerable<ProductDto>> GetRelatedProductsAsync(int productId, IEnumerable<int> categoryIds)
        {
            var products = await _productRepository.GetRelatedProductsAsync(productId, categoryIds);
            return products.Select(p => new ProductDto
            {
                Id = p.Id,
                Name = p.Name,
                Slug = p.Slug,
                Description = p.Description,
                Price = p.Price,
                BrandId = p.BrandId,
                BrandName = p.Brand?.Name,
                Condition = p.Condition,
                Image = p.Image,
                Quantity = p.Quantity,
                Sold = p.Sold,
                WeightGram = p.WeightGram,
                CategoryIds = p.ProductCategories.Select(pc => pc.CategoryId).ToList(),
                CategoryNames = p.ProductCategories.Select(pc => pc.Category?.Name).ToList()
            });
        }

        public async Task AddRatingAsync(RatingDto ratingDto)
        {
            var rating = new Rating
            {
                ProductId = ratingDto.ProductId,
                Name = ratingDto.Name,
                Email = ratingDto.Email,
                Comment = ratingDto.Comment,
                Star = ratingDto.Star.ToString()
            };

            await _ratingRepository.AddAsync(rating);
            await _ratingRepository.SaveChangesAsync();
        }

        public async Task<bool> HasUserPurchasedProductAsync(int productId, string userName)
        {
            return await _ratingRepository.HasPurchasedAsync(productId, userName);
        }

        public async Task<PaginatedListDto<ProductDto>> GetFilteredProductsAsync(ProductFilterDto filter)
        {
            var result = await _productRepository.GetFilteredAsync(
                filter.CategorySlug, 
                filter.BrandSlug, 
                filter.SortBy, 
                filter.StartPrice, 
                filter.EndPrice, 
                filter.Page, 
                filter.PageSize);

            return new PaginatedListDto<ProductDto>
            {
                Items = result.Items.Select(p => new ProductDto
                {
                    Id = p.Id,
                    Name = p.Name,
                    Slug = p.Slug,
                    Description = p.Description,
                    Price = p.Price,
                    BrandId = p.BrandId,
                    BrandName = p.Brand?.Name,
                    Condition = p.Condition,
                    Image = p.Image,
                    Quantity = p.Quantity,
                    Sold = p.Sold,
                    WeightGram = p.WeightGram,
                    CategoryIds = p.ProductCategories.Select(pc => pc.CategoryId).ToList(),
                    CategoryNames = p.ProductCategories.Select(pc => pc.Category?.Name).ToList()
                }).ToList(),
                CurrentPage = filter.Page,
                TotalItems = result.TotalCount,
                TotalPages = (int)Math.Ceiling(result.TotalCount / (double)filter.PageSize)
            };
        }
        public async Task<HomeDataDto> GetHomeDataAsync()
        {
            var categories = await _categoryRepository.GetAllAsync();
            var sliders = await _sliderRepository.GetActiveSlidersAsync();

            var sections = new List<HomeSectionDto>();
            foreach (var cat in categories)
            {
                var filter = new ProductFilterDto
                {
                    CategorySlug = cat.Slug,
                    PageSize = 15
                };
                var result = await GetFilteredProductsAsync(filter);
                
                if (result.Items.Count > 0)
                {
                    sections.Add(new HomeSectionDto
                    {
                        CategoryId = cat.Id,
                        CategoryName = cat.Name,
                        CategorySlug = cat.Slug,
                        Products = result.Items
                    });
                }
            }

            return new HomeDataDto
            {
                Sliders = sliders.Select(s => new SliderDto
                {
                    Id = s.Id,
                    Name = s.Name,
                    Description = s.Description,
                    Image = s.Image,
                    Status = s.Status ?? 0
                }).ToList(),
                Sections = sections
            };
        }
        public async Task<IEnumerable<ProductQuantity>> GetProductQuantitiesAsync(int productId)
        {
            return await _productRepository.GetQuantitiesAsync(productId);
        }

        public async Task AddProductQuantityAsync(int productId, int quantity)
        {
            var product = await _productRepository.GetByIdAsync(productId);
            if (product == null) throw new Exception("Không tìm thấy sản phẩm.");

            var productQuantity = new ProductQuantity
            {
                ProductId = productId,
                Quantity = quantity,
                CreatedDate = DateTime.Now
            };

            product.Quantity += quantity;
            await _productRepository.AddQuantityAsync(productQuantity);
            await _productRepository.SaveChangesAsync();
        }
    }
}
