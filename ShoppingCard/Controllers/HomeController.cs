using System.Diagnostics;
using Microsoft.AspNetCore.Identity;
using Microsoft.Data.SqlClient;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using ShoppingCard.Models;
using ShoppingCard.Repository;

namespace ShoppingCard.Controllers
{
    public class HomeController : Controller
    {
        private readonly DataContext _dataContext;
        private readonly ILogger<HomeController> _logger;
        private readonly UserManager<AppUserModel> _userManager;

        public HomeController(
            DataContext dataContext,
            ILogger<HomeController> logger,
            UserManager<AppUserModel> userManager)
        {
            _dataContext = dataContext;
            _logger = logger;
            _userManager = userManager;
        }

        public IActionResult Index()
        {
            var products = _dataContext.Products
                .Include("Category")
                .Include("Brand")
                .ToList();

            ViewBag.Sliders = _dataContext.Sliders.Where(s => s.Status == 1).ToList();
            return View(products);
        }

        public IActionResult Privacy()
        {
            return View();
        }

        public async Task<IActionResult> Contact()
        {
            var contact = await _dataContext.Contacts.FirstAsync();
            return View(contact);
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
                return BadRequest(new { success = false, message = "ID san pham khong hop le." });
            }

            var userId = _userManager.GetUserId(User);
            if (string.IsNullOrEmpty(userId))
            {
                return Unauthorized(new { success = false, message = "Vui long dang nhap de them wishlist." });
            }

            if (!await _dataContext.Products.AnyAsync(p => p.Id == Id))
            {
                return NotFound(new { success = false, message = "San pham khong ton tai." });
            }

            var existed = await _dataContext.Wishlists.AnyAsync(w => w.ProductId == Id && w.UserId == userId);
            if (existed)
            {
                return Ok(new { success = true, message = "San pham da co trong wishlist." });
            }

            _dataContext.Wishlists.Add(new WishlistModel
            {
                ProductId = Id,
                UserId = userId
            });

            try
            {
                await _dataContext.SaveChangesAsync();
                return Ok(new { success = true, message = "Da them san pham vao wishlist." });
            }
            catch (DbUpdateException ex) when (ex.InnerException is SqlException sqlEx &&
                                              (sqlEx.Number == 2601 || sqlEx.Number == 2627))
            {
                return Ok(new { success = true, message = "San pham da co trong wishlist." });
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Add wishlist failed. ProductId: {ProductId}, UserId: {UserId}", Id, userId);
                return StatusCode(500, new { success = false, message = "Co loi xay ra khi them wishlist." });
            }
        }

        [HttpPost]
        public async Task<IActionResult> RemoveWishList(long Id)
        {
            if (Id <= 0)
            {
                return BadRequest(new { success = false, message = "ID san pham khong hop le." });
            }

            var userId = _userManager.GetUserId(User);
            if (string.IsNullOrEmpty(userId))
            {
                return Unauthorized(new { success = false, message = "Vui long dang nhap de thao tac." });
            }

            var items = await _dataContext.Wishlists
                .Where(w => w.ProductId == Id && w.UserId == userId)
                .ToListAsync();

            if (items.Count == 0)
            {
                return NotFound(new { success = false, message = "Khong tim thay san pham trong wishlist." });
            }

            _dataContext.Wishlists.RemoveRange(items);
            await _dataContext.SaveChangesAsync();
            return Ok(new { success = true, message = "Da xoa san pham khoi wishlist." });
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
