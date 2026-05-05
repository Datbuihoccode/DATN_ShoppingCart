using Microsoft.AspNetCore.Mvc;
using ShoppingCard.Repository;
using ShoppingCard.Models;
using ShoppingCard.Models.ViewsModels;
using Microsoft.EntityFrameworkCore;
using System.Security.Claims;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;

namespace ShoppingCard.Controllers
{
    public class CartController : Controller
    {
        private readonly DataContext _dataContext;
        private readonly UserManager<AppUserModel> _userManager;

        public CartController(DataContext context, UserManager<AppUserModel> userManager)
        {
            _dataContext = context;
            _userManager = userManager;
        }

        private string GetUserId()
        {
            return ShoppingCard.Library.CartHelper.GetUserId(HttpContext);
        }

        public async Task<IActionResult> Index()
        {
            var userId = GetUserId();
            var dbCarts = await _dataContext.Carts
                .Include(c => c.Product)
                .Where(c => c.UserId == userId)
                .ToListAsync();

            List<CartItemModel> cartItems = dbCarts.Select(c => new CartItemModel
            {
                ProductId = c.ProductId,
                ProductName = c.Product?.Name,
                Price = c.Product?.Price ?? 0,
                Quantity = c.Quantity,
                Image = c.Product?.Image
            }).ToList();

            decimal discount = 0;
            string couponMessage = "";
            var coupon_code = Request.Cookies["CouponTitle"];

            if (!string.IsNullOrEmpty(coupon_code))
            {
                var validCoupon = await _dataContext.Coupons
                    .FirstOrDefaultAsync(x => x.Name == coupon_code && x.Status == 1 && x.Quantity > 0 && x.DateExpired >= DateTime.Today);

                if (validCoupon != null)
                {
                    decimal grandTotal = cartItems.Sum(x => x.Quantity * x.Price);
                    if (grandTotal >= validCoupon.MinAmount)
                    {
                        if (validCoupon.Type == 1) // Percentage
                        {
                            discount = (grandTotal * validCoupon.DiscountValue) / 100;
                            if (validCoupon.MaxDiscountAmount > 0 && discount > validCoupon.MaxDiscountAmount)
                            {
                                discount = validCoupon.MaxDiscountAmount;
                            }
                        }
                        else // Fixed
                        {
                            discount = validCoupon.DiscountValue;
                        }
                        couponMessage = $"Áp dụng thành công: {validCoupon.Description}";
                    }
                    else
                    {
                        couponMessage = $"Đơn hàng tối thiểu {validCoupon.MinAmount.ToString("#,##0")} đ để sử dụng mã này.";
                        discount = 0;
                    }
                }
            }

            CartItemViewModel cartVM = new()
            {
                CartItems = cartItems,
                GrandTotal = cartItems.Sum(x => x.Quantity * x.Price),
                CouponCode = coupon_code,
                DiscountAmount = discount,
                CouponMessage = couponMessage
            };

            // Fetch user info for checkout pre-fill
            var user = await _userManager.FindByIdAsync(userId);
            if (user != null)
            {
                ViewBag.UserPhone = user.PhoneNumber;
                ViewBag.UserAddress = user.Address;
                ViewBag.UserFullName = user.FullName;
                ViewBag.UserProvinceId = user.ProvinceId;
                ViewBag.UserWardId = user.WardId;
            }

            return View(cartVM);
        }

        public async Task<IActionResult> Checkout()
        {
            var userId = GetUserId();
            var dbCarts = await _dataContext.Carts
                .Include(c => c.Product)
                .Where(c => c.UserId == userId)
                .ToListAsync();

            if (!dbCarts.Any())
            {
                return RedirectToAction("Index");
            }

            List<CartItemModel> cartItems = dbCarts.Select(c => new CartItemModel
            {
                ProductId = c.ProductId,
                ProductName = c.Product?.Name,
                Price = c.Product?.Price ?? 0,
                Quantity = c.Quantity,
                Image = c.Product?.Image
            }).ToList();

            decimal discount = 0;
            string couponMessage = "";
            var coupon_code = Request.Cookies["CouponTitle"];

            if (!string.IsNullOrEmpty(coupon_code))
            {
                var validCoupon = await _dataContext.Coupons
                    .FirstOrDefaultAsync(x => x.Name == coupon_code && x.Status == 1 && x.Quantity > 0 && x.DateExpired >= DateTime.Today);

                if (validCoupon != null)
                {
                    decimal grandTotal = cartItems.Sum(x => x.Quantity * x.Price);
                    if (grandTotal >= validCoupon.MinAmount)
                    {
                        if (validCoupon.Type == 1) // Percentage
                        {
                            discount = (grandTotal * validCoupon.DiscountValue) / 100;
                            if (validCoupon.MaxDiscountAmount > 0 && discount > validCoupon.MaxDiscountAmount)
                            {
                                discount = validCoupon.MaxDiscountAmount;
                            }
                        }
                        else // Fixed
                        {
                            discount = validCoupon.DiscountValue;
                        }
                        couponMessage = $"Áp dụng thành công: {validCoupon.Description}";
                    }
                    else
                    {
                        couponMessage = $"Đơn hàng tối thiểu {validCoupon.MinAmount.ToString("#,##0")} đ để sử dụng mã này.";
                        discount = 0;
                    }
                }
            }

            CartItemViewModel cartVM = new()
            {
                CartItems = cartItems,
                GrandTotal = cartItems.Sum(x => x.Quantity * x.Price),
                CouponCode = coupon_code,
                DiscountAmount = discount,
                CouponMessage = couponMessage
            };

            // Fetch user info for checkout pre-fill
            var user = await _userManager.FindByIdAsync(userId);
            if (user != null)
            {
                ViewBag.UserPhone = user.PhoneNumber;
                ViewBag.UserAddress = user.Address;
                ViewBag.UserFullName = user.FullName;
                ViewBag.UserProvinceId = user.ProvinceId;
                ViewBag.UserWardId = user.WardId;
            }

            return View("~/Views/Checkout/Index.cshtml", cartVM);
        }

        [HttpPost]
        [IgnoreAntiforgeryToken]
        public async Task<IActionResult> Add(long Id, int quantity = 1)
        {
            if (quantity < 1) quantity = 1;
            var product = await _dataContext.Products.FindAsync(Id);
            if (product == null) return NotFound();

            var userId = GetUserId();
            var cartItem = await _dataContext.Carts.FirstOrDefaultAsync(c => c.ProductId == Id && c.UserId == userId);
            
            if (cartItem == null)
            {
                _dataContext.Carts.Add(new CartModel
                {
                    UserId = userId,
                    ProductId = Id,
                    Quantity = quantity
                });
            }
            else
            {
                cartItem.Quantity += quantity;
            }
            
            await _dataContext.SaveChangesAsync();

            if (Request.Headers["X-Requested-With"] == "XMLHttpRequest")
            {
                return Json(new { success = true, message = "Sản phẩm đã được thêm vào giỏ hàng!" });
            }
            
            TempData["success"] = "Sản phẩm đã được thêm vào giỏ hàng thành công!";
            return Redirect(Request.Headers["Referer"].ToString());
        }

        public async Task<IActionResult> Decrease(long Id)
        {
            var userId = GetUserId();
            var cartItem = await _dataContext.Carts.FirstOrDefaultAsync(c => c.ProductId == Id && c.UserId == userId);
            
            if (cartItem != null)
            {
                if (cartItem.Quantity > 1)
                {
                    cartItem.Quantity -= 1;
                }
                else
                {
                    _dataContext.Carts.Remove(cartItem);
                }
                await _dataContext.SaveChangesAsync();
            }

            return Redirect(Request.Headers["Referer"].ToString());
        }

        public async Task<IActionResult> Increase(long Id)
        {
            var product = await _dataContext.Products.FindAsync(Id);
            if (product == null) return NotFound();

            var userId = GetUserId();
            var cartItem = await _dataContext.Carts.FirstOrDefaultAsync(c => c.ProductId == Id && c.UserId == userId);
            
            if (cartItem != null)
            {
                if (product.Quantity > cartItem.Quantity)
                {
                    cartItem.Quantity += 1;
                }
                else
                {
                    cartItem.Quantity = product.Quantity;
                    TempData["error"] = "Đã đạt số lượng tối đa trong kho!";
                }
                await _dataContext.SaveChangesAsync();
            }
            return Redirect(Request.Headers["Referer"].ToString());
        }

        public async Task<IActionResult> Remove(long Id)
        {
            var userId = GetUserId();
            var cartItem = await _dataContext.Carts.FirstOrDefaultAsync(c => c.ProductId == Id && c.UserId == userId);
            
            if (cartItem != null)
            {
                _dataContext.Carts.Remove(cartItem);
                await _dataContext.SaveChangesAsync();
            }

            TempData["success"] = "Đã xóa sản phẩm khỏi giỏ hàng!";
            return Redirect(Request.Headers["Referer"].ToString());
        }

        public async Task<IActionResult> Clear()
        {
            var userId = GetUserId();
            var userCarts = await _dataContext.Carts.Where(c => c.UserId == userId).ToListAsync();
            
            if (userCarts.Any())
            {
                _dataContext.Carts.RemoveRange(userCarts);
                await _dataContext.SaveChangesAsync();
            }
            
            Response.Cookies.Delete("CouponTitle");
            TempData["success"] = "Đã làm trống giỏ hàng!";
            return RedirectToAction("Index");
        }

        [HttpPost]
        [Route("Cart/GetCoupon")]
        public async Task<IActionResult> GetCoupon(string coupon_value)
        {
            var existingCoupon = Request.Cookies["CouponTitle"];
            if (!string.IsNullOrEmpty(existingCoupon))
            {
                return Json(new { success = false, message = "Bạn đã áp dụng mã giảm giá. Hãy xóa mã cũ trước khi thêm mã mới." });
            }

            var validCoupon = await _dataContext.Coupons
                .FirstOrDefaultAsync(x => x.Name == coupon_value && x.Status == 1 && x.Quantity > 0);

            if (validCoupon == null)
            {
                return Json(new { success = false, message = "Mã giảm giá không tồn tại hoặc đã hết lượt dùng." });
            }

            if (validCoupon.DateExpired < DateTime.Today)
            {
                return Json(new { success = false, message = "Mã giảm giá đã hết hạn sử dụng." });
            }

            CookieOptions cookieOptions = new CookieOptions
            {
                HttpOnly = true,
                Expires = DateTimeOffset.UtcNow.AddMinutes(60),
                Secure = Request.IsHttps,
                SameSite = SameSiteMode.Strict
            };

            Response.Cookies.Append("CouponTitle", validCoupon.Name, cookieOptions);
            return Json(new { success = true, message = "Đã lưu mã giảm giá thành công. Vui lòng làm mới giỏ hàng." });
        }

        public IActionResult RemoveCoupon()
        {
            Response.Cookies.Delete("CouponTitle");
            return RedirectToAction("Index");
        }
    }
}
