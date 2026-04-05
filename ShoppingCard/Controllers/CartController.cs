using Microsoft.AspNetCore.Mvc;
using ShoppingCard.Repository;
using ShoppingCard.Models;
using ShoppingCard.Models.ViewsModels;
using Microsoft.EntityFrameworkCore;

namespace ShoppingCard.Controllers
{
    public class CartController : Controller
    {
        private readonly DataContext _dataContext;
        public CartController(DataContext _context)
        {
            _dataContext = _context;
        }

        public IActionResult Index()
        {
            List<CartItemModel> cartItems = HttpContext.Session.GetJson<List<CartItemModel>>("Cart") ?? new List<CartItemModel>();
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
            ProductModel product = await _dataContext.Products.FindAsync(Id);
            List<CartItemModel> cart = HttpContext.Session.GetJson<List<CartItemModel>>("Cart") ?? new List<CartItemModel>();
            CartItemModel cartItems = cart.Where(c => c.ProductId == Id).FirstOrDefault();
            if (cartItems == null)
            {
                cart.Add(new CartItemModel(product));
            }
            else
            {
                cartItems.Quantity += 1;
            }

            HttpContext.Session.SetJson("Cart", cart);

            TempData["success"] = "Product added to cart successfully!";

            return Redirect(Request.Headers["Referer"].ToString());
        }

        public async Task<IActionResult> Decrease(long Id)
        {
            List<CartItemModel> cart = HttpContext.Session.GetJson<List<CartItemModel>>("Cart");

            CartItemModel cartItem = cart.Where(c => c.ProductId == Id).FirstOrDefault();

            if (cartItem.Quantity > 1)
            {
                --cartItem.Quantity;
            }
            else
            {
                cart.RemoveAll(p => p.ProductId == Id);
            }
            if (cart.Count == 0)
            {
                HttpContext.Session.Remove("Cart");
            }
            else
            {
                HttpContext.Session.SetJson("Cart", cart);
            }
            TempData["success"] = "Product quantity updated successfully!";
            return RedirectToAction("Index");
        }

        public async Task<IActionResult> Increase(long Id)
        {
            ProductModel product = await _dataContext.Products.Where(p => p.Id == Id).FirstOrDefaultAsync();
            List<CartItemModel> cart = HttpContext.Session.GetJson<List<CartItemModel>>("Cart");

            CartItemModel cartItem = cart.Where(c => c.ProductId == Id).FirstOrDefault();

            if (cartItem.Quantity >= 1 && product.Quantity > cartItem.Quantity)
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
            {
                HttpContext.Session.Remove("Cart");
            }
            else
            {
                HttpContext.Session.SetJson("Cart", cart);
            }
            return RedirectToAction("Index");
        }

        public async Task<IActionResult> Remove(long Id)
        {
            List<CartItemModel> cart = HttpContext.Session.GetJson<List<CartItemModel>>("Cart");
            cart.RemoveAll(p => p.ProductId == Id);

            if (cart.Count == 0)
            {
                HttpContext.Session.Remove("Cart");
            }
            else
            {
                HttpContext.Session.SetJson("Cart", cart);
            }
            TempData["success"] = "Product removed from cart successfully!";
            return RedirectToAction("Index");
        }

        public async Task<IActionResult> Clear()
        {
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
