using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;
using ShoppingCard.Domain.Entities;

namespace ShoppingCard.Infrastructure.Data
{
    public class DataContext : IdentityDbContext<AppUser>
    {
        public DataContext(DbContextOptions<DataContext> options) : base(options)
        {
        }

        public DbSet<Brand> Brands { get; set; }
        public DbSet<Slider> Sliders { get; set; }
        public DbSet<Category> Categories { get; set; }
        public DbSet<Product> Products { get; set; }
        public DbSet<ProductCategory> ProductCategories { get; set; }
        public DbSet<Order> Orders { get; set; }
        public DbSet<OrderDetail> OrderDetails { get; set; }
        public DbSet<MomoInfo> MomoInfos { get; set; }
        public DbSet<VnpayInfo> VnpayInfos { get; set; }
        public DbSet<Rating> Ratings { get; set; }
        public DbSet<Wishlist> Wishlists { get; set; }
        public DbSet<ProductQuantity> ProductQuantities { get; set; }
        public DbSet<Coupon> Coupons { get; set; }
        public DbSet<Statistical> Statisticals { get; set; }
        public DbSet<Cart> Carts { get; set; }
        public DbSet<OrderHistory> OrderHistories { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);

            modelBuilder.Entity<Wishlist>()
                .HasIndex(w => new { w.UserId, w.ProductId })
                .IsUnique();

            modelBuilder.Entity<ProductCategory>()
                .HasIndex(pc => new { pc.ProductId, pc.CategoryId })
                .IsUnique();

            // Cấu hình liên kết giữa Order và OrderDetails qua OrderCode
            modelBuilder.Entity<Order>()
                .HasMany(o => o.OrderDetails)
                .WithOne(od => od.Order)
                .HasPrincipalKey(o => o.OrderCode)
                .HasForeignKey(od => od.OrderCode);

            // Cấu hình liên kết giữa Product và ProductQuantity
            modelBuilder.Entity<Product>()
                .HasMany(p => p.ProductQuantities)
                .WithOne(pq => pq.Product)
                .HasForeignKey(pq => pq.ProductId);

            // Cấu hình liên kết MomoInfo qua OrderCode
            modelBuilder.Entity<Order>()
                .HasOne(o => o.MomoInfo)
                .WithOne(m => m.Order)
                .HasPrincipalKey<Order>(o => o.OrderCode)
                .HasForeignKey<MomoInfo>(m => m.OrderId);

            // Cấu hình liên kết VnpayInfo qua OrderCode
            modelBuilder.Entity<Order>()
                .HasOne(o => o.VnpayInfo)
                .WithOne(v => v.Order)
                .HasPrincipalKey<Order>(o => o.OrderCode)
                .HasForeignKey<VnpayInfo>(v => v.PaymentId);

            // Cấu hình liên kết OrderHistory qua OrderCode
            modelBuilder.Entity<OrderHistory>()
                .HasOne(oh => oh.Order)
                .WithMany(o => o.OrderHistories)
                .HasPrincipalKey(o => o.OrderCode)
                .HasForeignKey(oh => oh.OrderCode);

            // Cấu hình precision cho decimal properties
            modelBuilder.Entity<Coupon>(entity =>
            {
                entity.Property(e => e.DiscountValue).HasColumnType("decimal(18,2)");
                entity.Property(e => e.MaxDiscountAmount).HasColumnType("decimal(18,2)");
                entity.Property(e => e.MinAmount).HasColumnType("decimal(18,2)");
            });

            modelBuilder.Entity<Order>(entity =>
            {
                entity.Property(e => e.DiscountAmount).HasColumnType("decimal(18,2)");
            });
        }
    }
}
