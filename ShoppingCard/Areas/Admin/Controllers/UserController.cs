using ShoppingCard.Application.Interfaces;
using ShoppingCard.Domain.Interfaces;
using ShoppingCard.Domain.Entities;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using System.Security.Claims;
using System.Threading.Tasks;
using System;
using System.Linq;
using System.Collections.Generic;

namespace ShoppingCard.Areas.Admin.Controllers
{
    [Area("Admin")]
    [Route("Admin/User")]
   
    [Authorize(Roles = "Admin", AuthenticationSchemes = "AdminScheme")]
    public class UserController : Controller
    {
        private readonly UserManager<AppUser> _userManager;
        private readonly RoleManager<IdentityRole> _roleManager;
        private readonly IUserRepository _userRepository;

        private void AddIdentityErrors(IdentityResult identityResult)
        {
            foreach (var error in identityResult.Errors)
            {
                ModelState.AddModelError(string.Empty, error.Description);
            }
        }

        public UserController(IUserRepository userRepository, UserManager<AppUser> userManager, RoleManager<IdentityRole> roleManager)
        {
            _userManager = userManager;
            _roleManager = roleManager;
            _userRepository = userRepository;
        }

        [HttpGet]
        [Route("Index")]
        public async Task<IActionResult> Index()
        {
            var usersWithRoles = await _userRepository.GetUsersWithRolesAsync();

            var loggedInUserID = User.FindFirstValue(ClaimTypes.NameIdentifier);
            ViewBag.loggedInUserID = loggedInUserID;
            return View(usersWithRoles);
        }

        [HttpGet]
        [Route("Create")]
        public async Task<IActionResult> Create()
        {
            var roles = await _roleManager.Roles.ToListAsync();
            ViewBag.Roles = new SelectList(roles, "Id", "Name");
            return View(new AppUser());
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        [Route("Create")]
        public async Task<IActionResult> Create(AppUser user)
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
        
        public async Task<IActionResult> Edit(string id, AppUser user)
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

            var loggedInUserID = User.FindFirstValue(ClaimTypes.NameIdentifier);
            if (id == loggedInUserID)
            {
                TempData["error"] = "Bạn không thể tự xóa tài khoản của chính mình.";
                return RedirectToAction("Index");
            }

            var hasOrders = await _userRepository.HasOrdersAsync(user.Email);
            if (hasOrders)
            {
                TempData["error"] = "Không thể xóa người dùng này vì họ đã có lịch sử đơn hàng. Hãy vô hiệu hóa tài khoản thay vì xóa.";
                return RedirectToAction("Index");
            }

            try
            {
                await _userRepository.DeleteUserRelatedDataAsync(id);
                await _userRepository.SaveChangesAsync();

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

