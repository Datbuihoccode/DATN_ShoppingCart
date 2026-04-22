using Microsoft.AspNetCore.Mvc;
using ShoppingCard.Repository;
using ShoppingCard.Models;
using ShoppingCard.Models.ViewsModels;
using Microsoft.EntityFrameworkCore;
using System.Security.Claims;

namespace ShoppingCard.Controllers
{
    public class CartController : Controller
    {
        private readonly DataContext _dataContext;

        public CartController(DataContext context)
        {
            _dataContext = context;
        }

        private string GetUserId()
        {
            return User.FindFirstValue(ClaimTypes.NameIdentifier);
        }

        public async Task<IActionResult> Index()
        {
            var userId = GetUserId();
            List<CartItemModel> cartItems = new List<CartItemModel>();

            if (userId != null)
            {
                var dbCarts = await _dataContext.Carts
                    .Include(c => c.Product)
                    .Where(c => c.UserId == userId)
                    .ToListAsync();
                    
                cartItems = dbCarts.Select(c => new CartItemModel
                {
                    ProductId = c.ProductId,
                    ProductName = c.Product?.Name,
                    Price = c.Product?.Price ?? 0,
                    Quantity = c.Quantity,
                    Image = c.Product?.Image
                }).ToList();
            }
            else
            {
                cartItems = HttpContext.Session.GetJson<List<CartItemModel>>("Cart") ?? new List<CartItemModel>();
            }

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
                            // Apply Max Discount Case
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
                        couponMessage = $"Đơn hàng tối thiểu {validCoupon.MinAmount.ToString("#,##0")} VNĐ để sử dụng mã này.";
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
            return View(cartVM);
        }

        public IActionResult Checkout()
        {
            return View("~/Views/Checkout/Index.cshtml");
        }

        [HttpPost]
        [IgnoreAntiforgeryToken]
        public async Task<IActionResult> Add(long Id, int quantity = 1)
        {
            if (quantity < 1) quantity = 1;
            var product = await _dataContext.Products.FindAsync(Id);
            if (product == null) return NotFound();

            var userId = GetUserId();

            if (userId != null)
            {
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
            }
            else
            {
                List<CartItemModel> cart = HttpContext.Session.GetJson<List<CartItemModel>>("Cart") ?? new List<CartItemModel>();
                CartItemModel cartItemSession = cart.FirstOrDefault(c => c.ProductId == Id);
                if (cartItemSession == null)
                {
                    var newItem = new CartItemModel(product);
                    newItem.Quantity = quantity;
                    cart.Add(newItem);
                }
                else
                {
                    cartItemSession.Quantity += quantity;
                }
                HttpContext.Session.SetJson("Cart", cart);
            }

            if (Request.Headers["X-Requested-With"] == "XMLHttpRequest")
            {
                return Json(new { success = true, message = "Sản phẩm đã được thêm vào giỏ hàng!" });
            }
            
            TempData["success"] = "Product added to cart successfully!";
            return Redirect(Request.Headers["Referer"].ToString());
        }

        public async Task<IActionResult> Decrease(long Id)
        {
            var userId = GetUserId();

            if (userId != null)
            {
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
            }
            else
            {
                List<CartItemModel> cart = HttpContext.Session.GetJson<List<CartItemModel>>("Cart");
                if (cart != null)
                {
                    CartItemModel cartItem = cart.FirstOrDefault(c => c.ProductId == Id);
                    if (cartItem != null)
                    {
                        if (cartItem.Quantity > 1)
                        {
                            --cartItem.Quantity;
                        }
                        else
                        {
                            cart.RemoveAll(p => p.ProductId == Id);
                        }
                        
                        if (cart.Count == 0)
                            HttpContext.Session.Remove("Cart");
                        else
                            HttpContext.Session.SetJson("Cart", cart);
                    }
                }
            }

            TempData["success"] = "Product quantity updated successfully!";
            return RedirectToAction("Index");
        }

        public async Task<IActionResult> Increase(long Id)
        {
            var product = await _dataContext.Products.FindAsync(Id);
            if (product == null) return NotFound();

            var userId = GetUserId();

            if (userId != null)
            {
                var cartItem = await _dataContext.Carts.FirstOrDefaultAsync(c => c.ProductId == Id && c.UserId == userId);
                if (cartItem != null)
                {
                    if (product.Quantity > cartItem.Quantity)
                    {
                        cartItem.Quantity += 1;
                        TempData["success"] = "Product quantity updated successfully!";
                    }
                    else
                    {
                        cartItem.Quantity = product.Quantity;
                        TempData["error"] = "Maximum quantity reached!";
                    }
                    await _dataContext.SaveChangesAsync();
                }
            }
            else
            {
                List<CartItemModel> cart = HttpContext.Session.GetJson<List<CartItemModel>>("Cart");
                if (cart != null)
                {
                    CartItemModel cartItem = cart.FirstOrDefault(c => c.ProductId == Id);
                    if (cartItem != null)
                    {
                        if (product.Quantity > cartItem.Quantity)
                        {
                            ++cartItem.Quantity;
                            TempData["success"] = "Product quantity updated successfully!";
                        }
                        else
                        {
                            cartItem.Quantity = product.Quantity;
                            TempData["error"] = "Maximum quantity reached!";
                        }

                        if (cart.Count == 0)
                            HttpContext.Session.Remove("Cart");
                        else
                            HttpContext.Session.SetJson("Cart", cart);
                    }
                }
            }
            return RedirectToAction("Index");
        }

        public async Task<IActionResult> Remove(long Id)
        {
            var userId = GetUserId();

            if (userId != null)
            {
                var cartItem = await _dataContext.Carts.FirstOrDefaultAsync(c => c.ProductId == Id && c.UserId == userId);
                if (cartItem != null)
                {
                    _dataContext.Carts.Remove(cartItem);
                    await _dataContext.SaveChangesAsync();
                }
            }
            else
            {
                List<CartItemModel> cart = HttpContext.Session.GetJson<List<CartItemModel>>("Cart");
                if (cart != null)
                {
                    cart.RemoveAll(p => p.ProductId == Id);
                    if (cart.Count == 0)
                        HttpContext.Session.Remove("Cart");
                    else
                        HttpContext.Session.SetJson("Cart", cart);
                }
            }

            TempData["success"] = "Product removed from cart successfully!";
            return RedirectToAction("Index");
        }

        public async Task<IActionResult> Clear()
        {
            var userId = GetUserId();

            if (userId != null)
            {
                var userCarts = await _dataContext.Carts.Where(c => c.UserId == userId).ToListAsync();
                if (userCarts.Any())
                {
                    _dataContext.Carts.RemoveRange(userCarts);
                    await _dataContext.SaveChangesAsync();
                }
            }
            
            HttpContext.Session.Remove("Cart");
            Response.Cookies.Delete("CouponTitle");

            TempData["success"] = "Cart cleared successfully!";
            return RedirectToAction("Index");
        }



        [HttpPost]
        [Route("Cart/GetCoupon")]
        public async Task<IActionResult> GetCoupon(string coupon_value)
        {
            // Check if coupon already applied
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
