using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;
using ShoppingCard.Models;

namespace ShoppingCard.Repository
{
    public class DataContext : IdentityDbContext<AppUserModel>
    {
        public DataContext(DbContextOptions<DataContext> options) : base(options)
        {
        }
        public DbSet<BrandModel> Brands { get; set; }
        public DbSet<SliderModel> Sliders { get; set; }
        public DbSet<CategoryModel> Categories { get; set; }
        public DbSet<ProductModel> Products { get; set; }
        public DbSet<ProductCategoryModel> ProductCategories { get; set; }
        public DbSet<OrderModel> Orders { get; set; }
        public DbSet<OrderDetailsModel> OrderDetails { get; set; }
        public DbSet<MomoInfoModel> MomoInfos { get; set; }
        public DbSet<VnpayModel> VnpayInfos { get; set; }
        public DbSet<RatingModel> Ratings { get; set; }
        public DbSet<WishlistModel> Wishlists { get; set; }
        public DbSet<ProductQuantityModel> ProductQuantities { get; set; }
        public DbSet<CouponModel> Coupons { get; set; }
        public DbSet<StatisticalModel> Statisticals { get; set; }
        public DbSet<CartModel> Carts { get; set; }
        public DbSet<OrderHistoryModel> OrderHistories { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);

            modelBuilder.Entity<WishlistModel>()
                .HasIndex(w => new { w.UserId, w.ProductId })
                .IsUnique();

            modelBuilder.Entity<ProductCategoryModel>()
                .HasIndex(pc => new { pc.ProductId, pc.CategoryId })
                .IsUnique();

            // Cấu hình liên kết giữa Order và OrderDetails qua OrderCode
            modelBuilder.Entity<OrderModel>()
                .HasMany(o => o.OrderDetails)
                .WithOne(od => od.Order)
                .HasPrincipalKey(o => o.OrderCode)
                .HasForeignKey(od => od.OrderCode);

            // Cấu hình liên kết giữa Product và ProductQuantity
            modelBuilder.Entity<ProductModel>()
                .HasMany(p => p.ProductQuantities)
                .WithOne(pq => pq.Product)
                .HasForeignKey(pq => pq.ProductId);

            // Cấu hình liên kết MomoInfo qua OrderCode
            modelBuilder.Entity<OrderModel>()
                .HasOne(o => o.MomoInfo)
                .WithOne(m => m.Order)
                .HasPrincipalKey<OrderModel>(o => o.OrderCode)
                .HasForeignKey<MomoInfoModel>(m => m.OrderId);

            // Cấu hình liên kết VnpayInfo qua OrderCode
            modelBuilder.Entity<OrderModel>()
                .HasOne(o => o.VnpayInfo)
                .WithOne(v => v.Order)
                .HasPrincipalKey<OrderModel>(o => o.OrderCode)
                .HasForeignKey<VnpayModel>(v => v.PaymentId);

            // Cấu hình liên kết OrderHistory qua OrderCode
            modelBuilder.Entity<OrderHistoryModel>()
                .HasOne(oh => oh.Order)
                .WithMany(o => o.OrderHistories)
                .HasPrincipalKey(o => o.OrderCode)
                .HasForeignKey(oh => oh.OrderCode);
        }
    }
}
