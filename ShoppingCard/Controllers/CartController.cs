using ShoppingCard.Application.Interfaces;
using ShoppingCard.Domain.Entities;
using ShoppingCard.Application.DTOs.Cart;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Http;

namespace ShoppingCard.Controllers
{
    public class CartController : Controller
    {
        private readonly ICartService _cartService;
        private readonly ICouponService _couponService;
        private readonly UserManager<AppUser> _userManager;

        public CartController(ICartService cartService, ICouponService couponService, UserManager<AppUser> userManager)
        {
            _cartService = cartService;
            _couponService = couponService;
            _userManager = userManager;
        }

        private string GetUserId()
        {
            return ShoppingCard.Library.CartHelper.GetUserId(HttpContext);
        }

        public async Task<IActionResult> Index()
        {
            var userId = GetUserId();
            var items = await _cartService.GetCartItemsAsync(userId);
            
            var cartItems = items.Select(c => new CartItemDto
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
                // This logic should probably be in CouponService or CartService
                // For now, I'll use the service to get coupon info
                var coupons = await _couponService.GetAllCouponsAsync();
                var validCoupon = coupons.FirstOrDefault(x => x.Name == coupon_code && x.Status == 1 && x.Quantity > 0 && x.DateExpired >= DateTime.Today);

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

            CartViewModelDto cartVM = new()
            {
                CartItems = cartItems,
                GrandTotal = cartItems.Sum(x => x.Quantity * x.Price),
                CouponCode = coupon_code,
                DiscountAmount = discount,
                CouponMessage = couponMessage
            };

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
            var items = await _cartService.GetCartItemsAsync(userId);
            
            if (!items.Any())
            {
                return RedirectToAction("Index");
            }

            var cartItems = items.Select(c => new CartItemDto
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
                var coupons = await _couponService.GetAllCouponsAsync();
                var validCoupon = coupons.FirstOrDefault(x => x.Name == coupon_code && x.Status == 1 && x.Quantity > 0 && x.DateExpired >= DateTime.Today);

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

            CartViewModelDto cartVM = new()
            {
                CartItems = cartItems,
                GrandTotal = cartItems.Sum(x => x.Quantity * x.Price),
                CouponCode = coupon_code,
                DiscountAmount = discount,
                CouponMessage = couponMessage
            };

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
            var userId = GetUserId();
            await _cartService.AddToCartAsync(userId, Id, quantity);

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
            await _cartService.DecreaseQuantityAsync(userId, Id);
            return Redirect(Request.Headers["Referer"].ToString());
        }

        public async Task<IActionResult> Increase(long Id)
        {
            var userId = GetUserId();
            await _cartService.IncreaseQuantityAsync(userId, Id);
            return Redirect(Request.Headers["Referer"].ToString());
        }

        public async Task<IActionResult> Remove(long Id)
        {
            var userId = GetUserId();
            await _cartService.RemoveFromCartAsync(userId, Id);
            TempData["success"] = "Đã xóa sản phẩm khỏi giỏ hàng!";
            return Redirect(Request.Headers["Referer"].ToString());
        }

        public async Task<IActionResult> Clear()
        {
            var userId = GetUserId();
            await _cartService.ClearCartAsync(userId);
            
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

            var coupons = await _couponService.GetAllCouponsAsync();
            var validCoupon = coupons.FirstOrDefault(x => x.Name == coupon_value && x.Status == 1 && x.Quantity > 0 && x.DateExpired >= DateTime.Today);

            if (validCoupon == null)
            {
                return Json(new { success = false, message = "Mã giảm giá không tồn tại, đã hết lượt dùng hoặc hết hạn." });
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
