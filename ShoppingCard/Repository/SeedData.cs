using Microsoft.EntityFrameworkCore;
using ShoppingCard.Models;

namespace ShoppingCard.Repository
{
    public class SeedData
    {
        public static void SeedingData(DataContext _context)
        {
            _context.Database.Migrate();
            if (!_context.Products.Any()) 
            {
                CategoryModel macbook = new CategoryModel 
                { 
                    Name = "Macbook", 
                    Description = "Macbook is a large brand in the world", 
                    Slug = "macbook", 
                    Status = 1 
                };
                CategoryModel pc = new CategoryModel 
                { 
                    Name = "PC", 
                    Description = "PC is a large brand in the world", 
                    Slug = "pc", 
                    Status = 1 
                };

                BrandModel apple = new BrandModel 

                {
                    Name = "Apple",
                    Description = "Apple is a large brand in the world",
                    Slug = "apple",
                    Status = 1
                };
                BrandModel samsung = new BrandModel
                {
                    Name = "SamSung",
                    Description = "SamSung is a large brand in the world",
                    Slug = "samsung",
                    Status = 1
                };

                _context.Products.AddRange(
                    new ProductModel
                    {
                        Name = "Macbook",
                        Slug = "macbook",
                        Description = "Macbook is the product of Apple",
                        Price = 30000000,
                        Brand = apple,
                        Category = macbook,
                        Image = "1.jpg"
                    },
                    new ProductModel
                    {
                        Name = "PC",
                        Slug = "pc",
                        Description = "PC is the best of performance",
                        Price = 28000000,
                        Brand = samsung,
                        Category = pc,
                        Image = "1.jpg"
                    }
                );
                _context.SaveChanges();
            }
        }
    }
}
