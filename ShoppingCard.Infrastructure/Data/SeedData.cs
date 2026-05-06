using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.DependencyInjection;
using ShoppingCard.Domain.Entities;
using ShoppingCard.Infrastructure.Data;

namespace ShoppingCard.Infrastructure.Data
{
    public class SeedData
    {
        public static async Task SeedingData(DataContext context, IServiceProvider serviceProvider)
        {
            context.Database.Migrate();

            // Seed Roles & Admin User (Identity)
            try
            {
                var roleManager = serviceProvider.GetRequiredService<RoleManager<IdentityRole>>();
                var userManager = serviceProvider.GetRequiredService<UserManager<AppUser>>();

                string[] roleNames = { "Admin", "Staff", "Customer" };
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
                    var adminUser = new AppUser
                    {
                        UserName = "admin",
                        Email = "admin@gmail.com",
                        EmailConfirmed = true
                    };

                    var createResult = await userManager.CreateAsync(adminUser, "12345a");
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
