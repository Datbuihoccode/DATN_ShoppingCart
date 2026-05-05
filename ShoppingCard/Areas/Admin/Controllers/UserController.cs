using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using ShoppingCard.Models;
using ShoppingCard.Repository;
using System.Security.Claims;

namespace ShoppingCard.Areas.Admin.Controllers
{
    [Area("Admin")]
    [Route("Admin/User")]
   
    [Authorize(Roles = "Admin", AuthenticationSchemes = "AdminScheme")]
    public class UserController : Controller
    {
        private readonly UserManager<AppUserModel> _userManager;
        private readonly RoleManager<IdentityRole> _roleManager;
        private readonly DataContext _dataContext;

        private void AddIdentityErrors(IdentityResult identityResult)
        {
            foreach (var error in identityResult.Errors)
            {
                ModelState.AddModelError(string.Empty, error.Description);
            }
        }

        public UserController(DataContext context,UserManager<AppUserModel> userManager, RoleManager<IdentityRole> roleManager)
        {
            _userManager = userManager;
            _roleManager = roleManager;
            _dataContext = context;
        }

        [HttpGet]
        [Route("Index")]
        public async Task<IActionResult> Index()
        {
            var usersWithRoles = await (from u in _dataContext.Users
                                        join ur in _dataContext.UserRoles on u.Id equals ur.UserId into userRoles
                                        from ur in userRoles.DefaultIfEmpty()
                                        join r in _dataContext.Roles on ur.RoleId equals r.Id into roles
                                        from r in roles.DefaultIfEmpty()
                                        select new { User = u, RoleName = r != null ? r.Name : "No role" })
                                        .ToListAsync();

            var loggedInUserID = User.FindFirstValue(ClaimTypes.NameIdentifier); // Lấy ID của người dùng hiện tại
            ViewBag.loggedInUserID = loggedInUserID;
            return View(usersWithRoles);
        }

        [HttpGet]
        [Route("Create")]
        public async Task<IActionResult> Create()
        {
            var roles = await _roleManager.Roles.ToListAsync();
            ViewBag.Roles = new SelectList(roles, "Id", "Name");
            return View(new AppUserModel());
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        [Route("Create")]
        public async Task<IActionResult> Create(AppUserModel user)
        {
            var roles = await _roleManager.Roles.ToListAsync();

            if (ModelState.IsValid)
            {
                var createUserResult = await _userManager.CreateAsync(user, user.PasswordHash); // tao user voi password
                if (createUserResult.Succeeded)
                {
                    var createdUser = await _userManager.FindByEmailAsync(user.Email); // tim user dua vao email]
                    var role = await _roleManager.FindByIdAsync(user.RoleId); // lay role dua vao roleId
                    if (createdUser == null || role == null)
                    {
                        TempData["error"] = "Không tìm thấy user hoặc role để gán.";
                        ViewBag.Roles = new SelectList(roles, "Id", "Name", user.RoleId);
                        return View(user);
                    }

                    // gan role cho user
                    var addToRoleResult = await _userManager.AddToRoleAsync(createdUser, role.Name);
                    if(!addToRoleResult.Succeeded)
                    {
                        AddIdentityErrors(addToRoleResult);
                        ViewBag.Roles = new SelectList(roles, "Id", "Name", user.RoleId);
                        return View(user);
                    }

                    return RedirectToAction("Index","User");
                }
                else
                {
                    AddIdentityErrors(createUserResult);
                    ViewBag.Roles = new SelectList(roles, "Id", "Name", user.RoleId);
                    return View(user);
                }
            }
            else
            {
                TempData["error"] = "Model có một vài lỗi.";
                List<string> errors = new List<string>();
                foreach (var value in ModelState.Values)
                {
                    foreach (var error in value.Errors)
                    {
                        errors.Add(error.ErrorMessage);
                    }
                }
            }
            ViewBag.Roles = new SelectList(roles, "Id", "Name", user.RoleId);
            return View(user);
        }


        [HttpGet]
        [Route("Edit")]
        public async Task<IActionResult> Edit(string id)
        {
            if (string.IsNullOrEmpty(id))
            {
                return NotFound();
            }
            var user = await _userManager.FindByIdAsync(id);
            if (user == null)
            {
                return NotFound();
            }

            var roles = await _roleManager.Roles.ToListAsync();
            ViewBag.Roles = new SelectList(roles, "Id", "Name");

            return View(user);
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        [Route("Edit")]
        
        public async Task<IActionResult> Edit(string id, AppUserModel user)
        {
            var existingUser = await _userManager.FindByIdAsync(id); // lấy user id
            if (existingUser == null)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                // CHỈ cập nhật RoleId, KHÔNG cập nhật thông tin cá nhân (FullName, Email, etc.)
                // theo yêu cầu: admin không có quyền update thông tin người dùng.
                existingUser.RoleId = user.RoleId;

                var updateResult = await _userManager.UpdateAsync(existingUser);
                if (updateResult.Succeeded)
                {
                    // Cập nhật Role trong bảng trung gian UserRoles
                    var oldRoles = await _userManager.GetRolesAsync(existingUser);
                    var newRole = await _roleManager.FindByIdAsync(user.RoleId);
                    
                    if (newRole != null)
                    {
                        var newRoleName = newRole.Name;
                        if (!oldRoles.Contains(newRoleName))
                        {
                            if (oldRoles.Any())
                            {
                                await _userManager.RemoveFromRolesAsync(existingUser, oldRoles);
                            }
                            await _userManager.AddToRoleAsync(existingUser, newRoleName);
                        }
                    }

                    TempData["success"] = "User đã được cập nhật.";
                    return RedirectToAction("Index", "User");
                }
                else
                {
                    AddIdentityErrors(updateResult);
                    return View(existingUser);
                }
            }

            var roles = await _roleManager.Roles.ToListAsync();
            ViewBag.Roles = new SelectList(roles, "Id", "Name");

            // Nếu có lỗi trong ModelState, hiển thị lại form với thông báo lỗi
            TempData["error"] = "Model có một vài lỗi.";
            var errors = ModelState.Values.SelectMany(v => v.Errors).Select(e => e.ErrorMessage).ToList();
            string errorMessages = string.Join("\n", errors);

            return View(existingUser);
        }

        [HttpGet]
        [Route("Delete")]
        public async Task<IActionResult> Delete(string id)
        {
            if (string.IsNullOrEmpty(id))
            {
                return NotFound();
            }

            var user = await _userManager.FindByIdAsync(id);
            if (user == null)
            {
                return NotFound();
            }

            // 1. Không cho phép tự xóa chính mình
            var loggedInUserID = User.FindFirstValue(ClaimTypes.NameIdentifier);
            if (id == loggedInUserID)
            {
                TempData["error"] = "Bạn không thể tự xóa tài khoản của chính mình.";
                return RedirectToAction("Index");
            }

            // 2. Kiểm tra nếu User có đơn hàng (Optional but recommended)
            // Trong project này OrderModel liên kết qua UserName (Email), 
            // nhưng ta vẫn nên kiểm tra để tránh mất dữ liệu lịch sử quan trọng.
            var hasOrders = await _dataContext.Orders.AnyAsync(o => o.UserName == user.Email);
            if (hasOrders)
            {
                TempData["error"] = "Không thể xóa người dùng này vì họ đã có lịch sử đơn hàng. Hãy vô hiệu hóa tài khoản thay vì xóa.";
                return RedirectToAction("Index");
            }

            try
            {
                // 3. Xóa các dữ liệu liên quan trong các bảng phụ (Carts, Wishlists)
                var userCarts = _dataContext.Carts.Where(c => c.UserId == id);
                _dataContext.Carts.RemoveRange(userCarts);

                var userWishlists = _dataContext.Wishlists.Where(w => w.UserId == id);
                _dataContext.Wishlists.RemoveRange(userWishlists);

                await _dataContext.SaveChangesAsync();

                // 4. Xóa User thông qua UserManager (Sẽ tự động xóa UserRoles)
                var deleteResult = await _userManager.DeleteAsync(user);

                if (!deleteResult.Succeeded)
                {
                    TempData["error"] = "Lỗi khi xóa User: " + string.Join(", ", deleteResult.Errors.Select(e => e.Description));
                    return RedirectToAction("Index");
                }

                TempData["success"] = "Người dùng đã được xóa thành công.";
            }
            catch (Exception ex)
            {
                TempData["error"] = "Đã xảy ra lỗi khi xóa: " + ex.Message;
            }

            return RedirectToAction("Index");
        }

    }
}

