using Microsoft.Extensions.DependencyInjection;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using ShoppingCard.Infrastructure.Data;
using ShoppingCard.Infrastructure.Repositories;
using ShoppingCard.Domain.Interfaces;
using ShoppingCard.Application.Interfaces;
using ShoppingCard.Application.Services;
using ShoppingCard.Infrastructure.Services;

namespace ShoppingCard.Infrastructure
{
    public static class DependencyInjection
    {
        public static IServiceCollection AddInfrastructure(this IServiceCollection services, IConfiguration configuration)
        {
            services.AddDbContext<DataContext>(options =>
                options.UseSqlServer(configuration.GetConnectionString("ConnectedDb")));

            services.AddScoped<IProductRepository, ProductRepository>();
            services.AddScoped<ICategoryRepository, CategoryRepository>();
            services.AddScoped<IBrandRepository, BrandRepository>();
            services.AddScoped<IOrderRepository, OrderRepository>();
            services.AddScoped<IUserRepository, UserRepository>();
            services.AddScoped<ICouponRepository, CouponRepository>();
            services.AddScoped<ICartRepository, CartRepository>();
            services.AddScoped<IRatingRepository, RatingRepository>();
            services.AddScoped<ISliderRepository, SliderRepository>();
            services.AddScoped<IFileService, FileService>();
            services.AddScoped<IEmailSender, EmailSender>();
            services.AddScoped<IStatisticalRepository, StatisticalRepository>();
            services.AddScoped<IMomoService, MomoService>();
            services.AddScoped<IVnPayService, VnPayService>();

            services.Configure<ShippingOptions>(configuration.GetSection("ShippingOptions"));

            return services;
        }

        public static IServiceCollection AddApplication(this IServiceCollection services)
        {
            services.AddScoped<IProductService, ProductService>();
            services.AddScoped<ICategoryService, CategoryService>();
            services.AddScoped<IBrandService, BrandService>();
            services.AddScoped<IOrderService, OrderService>();
            services.AddScoped<IShippingService, ShippingService>();
            services.AddScoped<ICouponService, CouponService>();
            services.AddScoped<ICartService, CartService>();
            services.AddScoped<IDashboardService, DashboardService>();
            
            return services;
        }
    }
}
