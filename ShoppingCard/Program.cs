using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Authentication.Google;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using ShoppingCard.Infrastructure;
using ShoppingCard.Infrastructure.Data;
using ShoppingCard.Domain.Entities;
using ShoppingCard.Application.Interfaces;
using ShoppingCard.Application.DTOs.Momo;
using ShoppingCard.Library;

var builder = WebApplication.CreateBuilder(args);

// Connect MoMo API
builder.Services.Configure<MomoOptionModel>(builder.Configuration.GetSection("MomoApi"));

builder.Services.AddHttpClient("ghn", client =>
{
    client.Timeout = TimeSpan.FromSeconds(15);
});

// Add services to the container.
builder.Services.AddControllersWithViews(options =>
{
    options.Filters.Add<PreventAdminAccessClientAttribute>();
});
builder.Services.AddRouting(options => options.LowercaseUrls = true);


// Add Infrastructure and Application layers (Clean Architecture)
builder.Services.AddInfrastructure(builder.Configuration);
builder.Services.AddApplication();

builder.Services.AddIdentity<AppUser, IdentityRole>()
    .AddEntityFrameworkStores<DataContext>()
    .AddDefaultTokenProviders()
    .AddErrorDescriber<VietnameseIdentityErrorDescriber>();

// External login by Google (kept after Identity configuration)
builder.Services
    .AddAuthentication(options =>
    {
        // Scheme mặc định cho Client (Customer)
        options.DefaultScheme = IdentityConstants.ApplicationScheme;
    })
    .AddCookie("AdminScheme", options =>
    {
        // Scheme riêng cho Admin/Staff
        options.Cookie.Name = ".ShoppingCard.Admin";
        options.LoginPath = "/Admin/Account/Login";
        options.AccessDeniedPath = "/Admin/Account/AccessDenied";
        options.ExpireTimeSpan = TimeSpan.FromHours(24);
    })
    .AddCookie() // Giữ lại mặc định nếu cần cho các middleware khác
    .AddGoogle(GoogleDefaults.AuthenticationScheme, options =>
    {
        options.ClientId = builder.Configuration.GetSection("GoogleKeys:ClientId").Value;
        options.ClientSecret = builder.Configuration.GetSection("GoogleKeys:ClientSecret").Value;
    });

builder.Services.ConfigureApplicationCookie(options =>
{
    // Đổi tên cookie mặc định cho Client để tránh trùng lặp
    options.Cookie.Name = ".ShoppingCard.Client";
    options.LoginPath = "/Account/Login";
    options.Events.OnRedirectToLogin = context =>
    {
        // Nếu request vào /Admin mà chưa login scheme Admin thì redirect (logic này sẽ được xử lý chủ yếu qua [Authorize(AuthenticationSchemes = "AdminScheme")])
        if (context.Request.Path.StartsWithSegments("/Admin"))
        {
            context.Response.Redirect("/Admin/Account/Login?ReturnUrl=" + context.Request.Path);
        }
        else
        {
            context.Response.Redirect(options.LoginPath + "?ReturnUrl=" + context.Request.Path);
        }
        return Task.CompletedTask;
    };
});

builder.Services.Configure<IdentityOptions>(options =>
{
    // Password settings.
    options.Password.RequireDigit = true;
    options.Password.RequireLowercase = true;
    options.Password.RequireNonAlphanumeric = false;
    options.Password.RequireUppercase = false;
    options.Password.RequiredLength = 4;
    options.Password.RequiredUniqueChars = 1;

    options.User.RequireUniqueEmail = true;
});

var app = builder.Build();

// Seed data on startup
using (var scope = app.Services.CreateScope())
{
    var services = scope.ServiceProvider;
    var context = services.GetRequiredService<DataContext>();
    await ShoppingCard.Infrastructure.Data.SeedData.SeedingData(context, services);
}

app.UseStatusCodePagesWithRedirects("/Home/Error?statuscode={0}");



// Configure the HTTP request pipeline.
if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Home/Error");
    app.UseHsts();
    app.UseHttpsRedirection();
}
app.UseRouting();

app.UseAuthentication();
app.UseAuthorization();

app.MapStaticAssets();

app.MapControllerRoute(
    name: "Areas",
    pattern: "{area:exists}/{controller=Dashboard}/{action=Index}/{id?}");



app.MapControllerRoute(
    name: "default",
    pattern: "{controller=Home}/{action=Index}/{id?}");

app.Run();
