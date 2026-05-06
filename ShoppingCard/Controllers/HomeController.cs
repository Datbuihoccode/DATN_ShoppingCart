using ShoppingCard.Application.Interfaces;
using ShoppingCard.Application.DTOs;
using System.Diagnostics;
using Microsoft.Data.SqlClient;

namespace ShoppingCard.Controllers
{
    public class HomeController : Controller
    {
        private readonly IProductService _productService;
        private readonly ILogger<HomeController> _logger;
        private readonly UserManager<AppUser> _userManager;
        private readonly DataContext _dataContext;

        public HomeController(
            IProductService productService,
            ILogger<HomeController> logger,
            UserManager<AppUser> userManager,
            DataContext dataContext)
        {
            _productService = productService;
            _logger = logger;
            _userManager = userManager;
            _dataContext = dataContext;
        }

        public async Task<IActionResult> Index()
        {
            var homeData = await _productService.GetHomeDataAsync();
            return View(homeData);
        }

        public IActionResult Privacy()
        {
            return View();
        }

        public async Task<IActionResult> Wishlist()
        {
            var userId = _userManager.GetUserId(User);
            if (string.IsNullOrEmpty(userId))
            {
                return RedirectToAction("Login", "Account");
            }

            var wishlistProducts = await _dataContext.Wishlists
                .Include(w => w.Product)
                    .ThenInclude(p => p.ProductCategories)
                        .ThenInclude(pc => pc.Category)
                .Where(w => w.UserId == userId)
                .OrderByDescending(w => w.Id)
                .ToListAsync();

            return View(wishlistProducts);
        }

        [HttpPost]
        public async Task<IActionResult> AddWishList(long Id)
        {
            if (Id <= 0)
            {
                return BadRequest(new { success = false, message = "ID sản phẩm không hợp lệ." });
            }

            var userId = _userManager.GetUserId(User);
            if (string.IsNullOrEmpty(userId))
            {
                return Unauthorized(new { success = false, message = "Vui lòng đăng nhập để thêm wishlist." });
            }

            if (!await _dataContext.Products.AnyAsync(p => p.Id == Id))
            {
                return NotFound(new { success = false, message = "Sản phẩm không tồn tại." });
            }

            var existed = await _dataContext.Wishlists.AnyAsync(w => w.ProductId == Id && w.UserId == userId);
            if (existed)
            {
                return Ok(new { success = true, message = "Sản phẩm đã có trong wishlist." });
            }

            _dataContext.Wishlists.Add(new Wishlist
            {
                ProductId = Id,
                UserId = userId
            });

            try
            {
                await _dataContext.SaveChangesAsync();
                return Ok(new { success = true, message = "Đã thêm sản phẩm vào wishlist." });
            }
            catch (DbUpdateException ex) when (ex.InnerException is SqlException sqlEx &&
                                               (sqlEx.Number == 2601 || sqlEx.Number == 2627))
            {
                return Ok(new { success = true, message = "Sản phẩm đã có trong wishlist." });
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Add wishlist failed. ProductId: {ProductId}, UserId: {UserId}", Id, userId);
                return StatusCode(500, new { success = false, message = "Có lỗi xảy ra khi thêm wishlist." });
            }
        }

        [HttpPost]
        public async Task<IActionResult> RemoveWishList(long Id)
        {
            if (Id <= 0)
            {
                return BadRequest(new { success = false, message = "ID sản phẩm không hợp lệ." });
            }

            var userId = _userManager.GetUserId(User);
            if (string.IsNullOrEmpty(userId))
            {
                return Unauthorized(new { success = false, message = "Vui lòng đăng nhập để thao tác." });
            }

            var items = await _dataContext.Wishlists
                .Where(w => w.ProductId == Id && w.UserId == userId)
                .ToListAsync();

            if (items.Count == 0)
            {
                return NotFound(new { success = false, message = "Không tìm thấy sản phẩm trong wishlist." });
            }

            _dataContext.Wishlists.RemoveRange(items);
            await _dataContext.SaveChangesAsync();
            return Ok(new { success = true, message = "Đã xóa sản phẩm khỏi wishlist." });
        }

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error(int statuscode)
        {
            if (statuscode == 404)
            {
                return View("NotFound");
            }

            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }
    }
}
