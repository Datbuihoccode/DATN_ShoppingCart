using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.DependencyInjection;
using ShoppingCard.Models;

namespace ShoppingCard.Repository
{
    public class SeedData
    {
        public static async Task SeedingData(DataContext context, IServiceProvider serviceProvider)
        {
            context.Database.Migrate();

            // 1) Seed Products & Categories
            if (!context.Products.Any())
            {
                CategoryModel macbook = new CategoryModel
                {
                    Name = "Macbook",
                    Slug = "macbook",
                    Description = "Macbook is brand in the world",
                    Status = 1
                };
                CategoryModel pc = new CategoryModel
                {
                    Name = "PC",
                    Slug = "pc",
                    Description = "pc is brand in the world",
                    Status = 1
                };

                BrandModel apple = new BrandModel
                {
                    Name = "Apple",
                    Slug = "apple",
                    Description = "apple is brand in the world",
                    Status = 1
                };
                BrandModel samsung = new BrandModel
                {
                    Name = "Samsung",
                    Slug = "samsung",
                    Description = "samsung is brand in the world",
                    Status = 1
                };

                context.Products.AddRange(
                    new ProductModel
                    {
                        Name = "Macbook",
                        Slug = "macbook",
                        Description = "Macbook is the best",
                        Image = "1.jpg",
                        Category = macbook,
                        Brand = apple,
                        Price = 20000,
                        CapitalPrice = 2900,
                        Quantity = 100
                    },
                    new ProductModel
                    {
                        Name = "pc",
                        Slug = "pc",
                        Description = "pc is the best",
                        Image = "1.jpg",
                        Category = pc,
                        Brand = samsung,
                        Price = 30000,
                        CapitalPrice = 2900,
                        Quantity = 200
                    }
                );

                await context.SaveChangesAsync();
            }

            // 2) Seed Contact
            if (!context.Contacts.Any())
            {
                ContactModel contact = new ContactModel
                {
                    Name = "Shop Bán Hàng Asp.net",
                    Description = "Mô tả dành cho Shop Bán Hàng Asp.Net",
                    Phone = "123456789",
                    Email = "admin@gmail.com",
                    Map = "Map Embeb Iframe Here",
                    LogoImg = "logo.jpg",
                    Status = 1
                };
                context.Contacts.Add(contact);
                await context.SaveChangesAsync();
            }

            // 3) Seed Roles & Admin User (Identity)
            try
            {
                var roleManager = serviceProvider.GetRequiredService<RoleManager<IdentityRole>>();
                var userManager = serviceProvider.GetRequiredService<UserManager<AppUserModel>>();

                string[] roleNames = { "Admin", "Author", "Publisher", "User" };
                foreach (var roleName in roleNames)
                {
                    if (!await roleManager.RoleExistsAsync(roleName))
                    {
                        await roleManager.CreateAsync(new IdentityRole(roleName));
                    }
                }

                var existingAdmin = await userManager.FindByNameAsync("admin");
                existingAdmin ??= await userManager.FindByEmailAsync("admin@gmail.com");

                if (existingAdmin == null)
                {
                    var adminUser = new AppUserModel
                    {
                        UserName = "admin",
                        Email = "admin@gmail.com",
                        EmailConfirmed = true
                    };

                    var createResult = await userManager.CreateAsync(adminUser, "Ta!123");
                    if (createResult.Succeeded)
                    {
                        await userManager.AddToRoleAsync(adminUser, "Admin");
                    }
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine("Lỗi khi seed User/Role: " + ex.Message);
            }
        }
    }
}
