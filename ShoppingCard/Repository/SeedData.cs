using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.DependencyInjection;
using ShoppingCard.Models;

namespace ShoppingCard.Repository
{
    public class SeedData
    {
        public static async Task SeedingData(DataContext _context, IServiceProvider serviceProvider)
        {
            _context.Database.Migrate();

            try
            {
                var roleManager = serviceProvider.GetRequiredService<RoleManager<IdentityRole>>();
                var userManager = serviceProvider.GetRequiredService<UserManager<AppUserModel>>();

                // Tạo các Roles nếu chưa có
                string[] roleNames = { "Admin", "Publisher", "Author", "User" };
                foreach (var roleName in roleNames)
                {
                    if (!await roleManager.RoleExistsAsync(roleName))
                    {
                        await roleManager.CreateAsync(new IdentityRole(roleName));
                    }
                }

                // Tạo User Admin nếu chưa có
                if (!userManager.Users.Any(u => u.UserName == "Admin"))
                {
                    var adminUser = new AppUserModel
                    {
                        UserName = "Admin",
                        Email = "admin@gmail.com",
                        PhoneNumber = "0123456789",
                        EmailConfirmed = true
                    };

                    
                    var result = await userManager.CreateAsync(adminUser, "Admin@123");

                    if (result.Succeeded)
                    {
                        await userManager.AddToRoleAsync(adminUser, "Admin");
                    }
                }
            }
            catch (Exception ex)
            {
                // Log lỗi nếu cần, hoặc bỏ qua nếu chỉ là lỗi trùng lặp khi chạy lại
                Console.WriteLine("Lỗi khi seed User/Role: " + ex.Message);
            }

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
                        Image = "2.jpg"
                    }
                );
            }

            if (!_context.Contacts.Any())
            {
                _context.Contacts.Add(new ContactModel
                {
                    Name = "Shopping Card",
                    Map = "<iframe src=\"https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3724.096!2d105.78!3d21.028!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3135ab86!2sHanoi!5e0!3m2!1sen!2svn!4v1700000000000!5m2!1sen!2svn\" width=\"600\" height=\"450\" style=\"border:0;\" allowfullscreen=\"\" loading=\"lazy\" referrerpolicy=\"no-referrer-when-downgrade\"></iframe>",
                    Phone = "0123 456 789",
                    Email = "contact@shoppingcard.com",
                    Description = "Cửa hàng mua sắm trực tuyến uy tín và chất lượng hàng đầu.",
                    Status = 1,
                    LogoImg = "logo.png"
                });
                _context.SaveChanges();
            }
        }
    }
}
