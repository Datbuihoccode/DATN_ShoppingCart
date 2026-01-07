using Microsoft.AspNetCore.Mvc;
using ShoppingCard.Models;
using ShoppingCard.Repository;
using System.Security.Claims;

namespace ShoppingCard.Controllers
{
    public class CheckoutController : Controller
    {
        private readonly DataContext _dataContext;

        public CheckoutController(DataContext dataContext)
        {
            _dataContext = dataContext;
        }

        public async Task<IActionResult> Checkout()
        {
            var userEmail = User.FindFirstValue(ClaimTypes.Email); 
            if(userEmail == null)
            {
                return RedirectToAction("Login", "Account");
            }
            else
            {
                var orderCode = Guid.NewGuid().ToString();
                var orderItem = new OrderModel();
                orderItem.OrderCode = orderCode; 
                orderItem.UserName = userEmail;
                orderItem.Status = 1;
                orderItem.CreateDate = DateTime.Now;
                _dataContext.Orders.Add(orderItem);
                await  _dataContext.SaveChangesAsync();
                TempData["Success"] = "Đơn hàng đã được tạo thành công!";
                return RedirectToAction("Index", "Cart");
            }
            return View(Checkout);
        }
    }
}
