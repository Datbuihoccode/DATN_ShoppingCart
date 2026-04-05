using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using ShoppingCard.Areas.Admin.Repository;
using ShoppingCard.Models;
using ShoppingCard.Repository;
using System.Security.Claims;

namespace ShoppingCard.Controllers
{
    public class CheckoutController : Controller
    {
        private readonly DataContext _dataContext;
        private readonly IEmailSender _emailSender;

        public CheckoutController(DataContext dataContext, IEmailSender emailSender)
        {
            _dataContext = dataContext;
            _emailSender = emailSender;
        }

        public async Task<IActionResult> Checkout()
        {
            var userEmail = User.FindFirstValue(ClaimTypes.Email);
            if (userEmail == null)
            {
                return RedirectToAction("Login", "Account");
            }

            List<CartItemModel> cartItems = HttpContext.Session.GetJson<List<CartItemModel>>("Cart") ?? new List<CartItemModel>();
            if (cartItems.Count == 0)
            {
                TempData["error"] = "Giỏ hàng đang trống.";
                return RedirectToAction("Index", "Cart");
            }

            var coupon_code = Request.Cookies["CouponTitle"];

            var orderCode = Guid.NewGuid().ToString();
            var orderItem = new OrderModel
            {
                OrderCode = orderCode,
                UserName = userEmail,
                Status = 1,
                CreateDate = DateTime.Now,
                CouponCode = coupon_code
            };

            _dataContext.Orders.Add(orderItem);

            foreach (var cart in cartItems)
            {
                var orderDetails = new OrderDetailsModel
                {
                    UserName = userEmail,
                    OrderCode = orderCode,
                    ProductId = cart.ProductId,
                    Price = cart.Price,
                    Quantity = cart.Quantity
                };

                var product = await _dataContext.Products.FirstOrDefaultAsync(p => p.Id == cart.ProductId);
                if (product != null)
                {
                    product.Quantity -= cart.Quantity;
                    product.Sold += cart.Quantity;
                    _dataContext.Update(product);
                }

                _dataContext.Add(orderDetails);
            }

            await _dataContext.SaveChangesAsync();

            HttpContext.Session.Remove("Cart");
            Response.Cookies.Delete("CouponTitle");

            var receiver = "1977datbui@gmail.com";
            var subject = "Đặt hàng thành công.";
            var message = "Đơn hàng đang được xử lý.";
            await _emailSender.SendEmailAsync(receiver, subject, message);

            TempData["Success"] = "Thanh toán thành công, vui lòng chờ duyệt đơn hàng.";
            return RedirectToAction("History", "Account");
        }
    }
}
