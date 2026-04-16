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

            decimal shippingPrice = 0;
            var coupon_code = Request.Cookies["CouponTitle"];

            CartItemViewModel cartVM = new()
            {
                CartItems = cartItems,
                GrandTotal = cartItems.Sum(x => x.Quantity * x.Price),
                ShippingCost = shippingPrice,
                CouponCode = coupon_code
            };
            return View(cartVM);
        }

        public IActionResult Checkout()
        {
            return View("~/Views/Checkout/Index.cshtml");
        }

        public async Task<IActionResult> Add(long Id)
        {
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
                        Quantity = 1
                    });
                }
                else
                {
                    cartItem.Quantity += 1;
                }
                await _dataContext.SaveChangesAsync();
            }
            else
            {
                List<CartItemModel> cart = HttpContext.Session.GetJson<List<CartItemModel>>("Cart") ?? new List<CartItemModel>();
                CartItemModel cartItemSession = cart.FirstOrDefault(c => c.ProductId == Id);
                if (cartItemSession == null)
                {
                    cart.Add(new CartItemModel(product));
                }
                else
                {
                    cartItemSession.Quantity += 1;
                }
                HttpContext.Session.SetJson("Cart", cart);
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

        public IActionResult DeleteShipping()
        {
            TempData["success"] = "Shipping deleted successfully!";
            return RedirectToAction("Index");
        }

        [HttpPost]
        [Route("Cart/GetCoupon")]
        public async Task<IActionResult> GetCoupon(CouponModel couponModel, string coupon_value)
        {
            var validCoupon = await _dataContext.Coupons.FirstOrDefaultAsync(x => x.Name == coupon_value);
            if (validCoupon == null)
            {
                return Json(new { success = false, message = "Coupon not existed" });
            }

            string couponTitle = validCoupon.Name + " | " + validCoupon.Description;

            TimeSpan remainingTime = validCoupon.DateExpired - DateTime.Now;
            int daysRemaining = remainingTime.Days;

            if (daysRemaining >= 0)
            {
                try
                {
                    CookieOptions cookieOptions = new CookieOptions
                    {
                        HttpOnly = true,
                        Expires = DateTimeOffset.UtcNow.AddMinutes(30),
                        Secure = Request.IsHttps,
                        SameSite = SameSiteMode.Strict
                    };

                    Response.Cookies.Append("CouponTitle", couponTitle, cookieOptions);
                    return Json(new { success = true, message = "Coupon applied successfully" });
                }
                catch (Exception)
                {
                    return Json(new { success = false, message = "Coupon applied failed" });
                }
            }
            else
            {
                return Json(new { success = false, message = "Coupon has expired" });
            }
        }
    }
}
