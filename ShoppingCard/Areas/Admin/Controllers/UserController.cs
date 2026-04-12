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
                // Cập nhật các thuộc tính của user
                existingUser.UserName = user.UserName;
                existingUser.Email = user.Email;
                existingUser.PhoneNumber = user.PhoneNumber;
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

            var deleteResult = await _userManager.DeleteAsync(user);

            if (!deleteResult.Succeeded) {
                return View("Error");
            }

            TempData["success"] = "User đã được xóa.";
            return RedirectToAction("Index");
        }

    }
}

