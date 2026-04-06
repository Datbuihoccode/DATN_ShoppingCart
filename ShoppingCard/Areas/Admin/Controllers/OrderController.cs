using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using ShoppingCard.Models;
using ShoppingCard.Repository;

namespace ShoppingCard.Areas.Admin.Controllers
{
    [Area("Admin")]
    [Authorize]
    public class OrderController : Controller
    {
        private readonly DataContext _dataContext;

        public OrderController(DataContext context)
        {
            _dataContext = context;
        }

        public async Task<IActionResult> Index()
        {
            return View(await _dataContext.Orders.OrderByDescending(p => p.Id).ToListAsync());
        }

        public async Task<IActionResult> ViewOrder(string odercode)
        {
            if (string.IsNullOrWhiteSpace(odercode))
            {
                return NotFound();
            }

            var order = await _dataContext.Orders.AsNoTracking().FirstOrDefaultAsync(o => o.OrderCode == odercode);
            if (order == null)
            {
                return NotFound();
            }

            var detailsOrder = await _dataContext.OrderDetails
                .Include(od => od.Product)
                .Where(od => od.OrderCode == odercode)
                .ToListAsync();

            ViewBag.OrderCode = order.OrderCode;
            ViewBag.CouponCode = order.CouponCode;
            ViewBag.OrderStatus = order.Status;
            ViewBag.Status = order.Status;
            return View(detailsOrder);
        }

        [HttpPost]
        [Route("UpdateOrder")]
        public async Task<IActionResult> UpdateOrder(string ordercode, int status)
        {
            var order = await _dataContext.Orders.FirstOrDefaultAsync(o => o.OrderCode == ordercode);
            if (order == null)
            {
                return NotFound();
            }

            if (order.Status == 3)
            {
                return BadRequest(new { success = false, message = "Order has been canceled and cannot be updated." });
            }

            if (status != 1 && status != 2 && status != 0)
            {
                return BadRequest(new { success = false, message = "Invalid order status." });
            }

            var normalizedStatus = status == 0 ? 2 : status;
            var isMovingToProcessed = order.Status != 2 && normalizedStatus == 2;

            order.Status = normalizedStatus;
            _dataContext.Update(order);

            if (isMovingToProcessed)
            {
                var detailsOrder = await _dataContext.OrderDetails
                    .Include(od => od.Product)
                    .Where(od => od.OrderCode == order.OrderCode)
                    .Select(od => new
                    {
                        od.Quantity,
                        od.Price,
                        CapitalPrice = od.Product != null ? od.Product.CapitalPrice : 0m
                    })
                    .ToListAsync();

                var statisticalModel = await _dataContext.Statisticals
                    .FirstOrDefaultAsync(s => s.DateCreated.Date == order.CreateDate.Date);

                if (statisticalModel != null)
                {
                    foreach (var orderDetail in detailsOrder)
                    {
                        statisticalModel.Quantity += 1;
                        statisticalModel.Sold += orderDetail.Quantity;
                        statisticalModel.Revenue += orderDetail.Quantity * orderDetail.Price;
                        statisticalModel.Profit += orderDetail.Quantity * (orderDetail.Price - orderDetail.CapitalPrice);
                    }

                    _dataContext.Update(statisticalModel);
                }
                else
                {
                    var newQuantity = 0;
                    var newSold = 0;
                    decimal newRevenue = 0m;
                    decimal newProfit = 0m;

                    foreach (var orderDetail in detailsOrder)
                    {
                        newQuantity += 1;
                        newSold += orderDetail.Quantity;
                        newRevenue += orderDetail.Quantity * orderDetail.Price;
                        newProfit += orderDetail.Quantity * (orderDetail.Price - orderDetail.CapitalPrice);
                    }

                    statisticalModel = new StatisticalModel
                    {
                        DateCreated = order.CreateDate.Date,
                        Quantity = newQuantity,
                        Sold = newSold,
                        Revenue = newRevenue,
                        Profit = newProfit
                    };

                    _dataContext.Add(statisticalModel);
                }
            }

            try
            {
                await _dataContext.SaveChangesAsync();
                return Ok(new { success = true, message = "Order status updated successfully" });
            }
            catch (Exception)
            {
                return StatusCode(500, "An error occurred while updating the order status.");
            }
        }

        [HttpPost]
        [Route("DeleteOrder")]
        public async Task<IActionResult> DeleteOrder(string ordercode)
        {
            var order = await _dataContext.Orders.FirstOrDefaultAsync(o => o.OrderCode == ordercode);

            if (order == null)
            {
                return Json(new { success = false, message = "Khong tim thay don hang de xoa." });
            }

            try
            {
                var orderDetails = await _dataContext.OrderDetails
                    .Where(od => od.OrderCode == ordercode)
                    .ToListAsync();

                if (orderDetails.Any())
                {
                    _dataContext.OrderDetails.RemoveRange(orderDetails);
                }

                _dataContext.Orders.Remove(order);
                await _dataContext.SaveChangesAsync();

                return Json(new { success = true, message = "Xoa don hang thanh cong!" });
            }
            catch (Exception ex)
            {
                return Json(new { success = false, message = "Da xay ra loi khi xoa: " + ex.Message });
            }
        }
    }
}

