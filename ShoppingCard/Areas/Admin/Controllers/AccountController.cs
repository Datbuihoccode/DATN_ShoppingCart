using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Http;
using ShoppingCard.Domain.Entities;
using ShoppingCard.Models.ViewModels;
using System.Security.Claims;
using System.Threading.Tasks;
using System.Collections.Generic;
using System;
using System.IO;
using Microsoft.AspNetCore.Hosting;

namespace ShoppingCard.Areas.Admin.Controllers
{
    [Area("Admin")]
    public class AccountController : Controller
    {
        private readonly UserManager<AppUser> _userManager;
        private readonly SignInManager<AppUser> _signInManager;
        private readonly IWebHostEnvironment _webHostEnvironment;

        public AccountController(UserManager<AppUser> userManager,
                                 SignInManager<AppUser> signInManager,
                                 IWebHostEnvironment webHostEnvironment)
        {
            _userManager = userManager;
            _signInManager = signInManager;
            _webHostEnvironment = webHostEnvironment;
        }

        [HttpGet]
        public IActionResult Login(string returnUrl)
        {
            return View(new LoginViewModel { ReturnUrl = returnUrl });
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Login(LoginViewModel loginVM)
        {
            if (ModelState.IsValid)
            {
                var user = await _userManager.FindByNameAsync(loginVM.UserName);
                if (user == null && loginVM.UserName.Contains("@"))
                    user = await _userManager.FindByEmailAsync(loginVM.UserName);

                if (user != null)
                {
                    // Kiểm tra mật khẩu thủ công thay vì dùng SignInManager (để có thể chỉ định scheme riêng)
                    if (await _userManager.CheckPasswordAsync(user, loginVM.Password))
                    {
                        var roles = await _userManager.GetRolesAsync(user);
                        if (roles.Contains("Admin") || roles.Contains("Staff"))
                        {
                            // Tạo các claim cho người dùng
                            var claims = new List<Claim>
                            {
                                new Claim(ClaimTypes.NameIdentifier, user.Id),
                                new Claim(ClaimTypes.Name, user.UserName),
                                new Claim(ClaimTypes.Email, user.Email ?? ""),
                            };

                            // Thêm các role vào claims
                            foreach (var role in roles)
                            {
                                claims.Add(new Claim(ClaimTypes.Role, role));
                            }

                            var claimsIdentity = new ClaimsIdentity(claims, "AdminScheme");
                            var authProperties = new AuthenticationProperties
                            {
                                IsPersistent = false // Có thể mở rộng để dùng Remember Me nếu muốn
                            };

                            // Đăng nhập vào scheme AdminScheme (không ảnh hưởng đến scheme mặc định của Client)
                            await HttpContext.SignInAsync("AdminScheme", new ClaimsPrincipal(claimsIdentity), authProperties);

                            TempData["success"] = "Chào mừng " + (roles.Contains("Admin") ? "Admin" : "Nhân viên") + " quay trở lại!";
                            return Redirect(loginVM.ReturnUrl ?? "/admin");
                        }
                        else
                        {
                            ModelState.AddModelError("", "Bạn không có quyền truy cập khu vực quản trị.");
                        }
                    }
                    else
                    {
                        ModelState.AddModelError("", "Mật khẩu hoặc tên đăng nhập không chính xác.");
                    }
                }
                else
                {
                    ModelState.AddModelError("", "Tài khoản không tồn tại.");
                }
            }
            return View(loginVM);
        }

        public async Task<IActionResult> Logout(string returnUrl = "/Admin/Account/Login")
        {
            // Đăng xuất khỏi scheme AdminScheme
            await HttpContext.SignOutAsync("AdminScheme");
            return Redirect(returnUrl);
        }

        // ===================== PROFILE =====================

        [HttpGet]
        [Authorize(Roles = "Admin,Staff", AuthenticationSchemes = "AdminScheme")]
        public async Task<IActionResult> Profile()
        {
            var user = await _userManager.GetUserAsync(User);
            if (user == null) return RedirectToAction("Login");

            var vm = new AdminProfileViewModel
            {
                UserName    = user.UserName,
                Email       = user.Email,
                PhoneNumber = user.PhoneNumber,
                AvatarUrl   = user.Avatar,
                Roles       = await _userManager.GetRolesAsync(user)
            };
            return View(vm);
        }

        [HttpPost]
        [Authorize(Roles = "Admin,Staff", AuthenticationSchemes = "AdminScheme")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Profile(AdminProfileViewModel vm)
        {
            // Bỏ validation mật khẩu nếu không nhập
            if (string.IsNullOrEmpty(vm.NewPassword))
                ModelState.Remove("NewPassword");
            ModelState.Remove("CurrentPassword");
            ModelState.Remove("AvatarUpload");

            if (!ModelState.IsValid) return View(vm);

            var user = await _userManager.GetUserAsync(User);
            if (user == null) return RedirectToAction("Login");

            // --- Cập nhật thông tin cơ bản ---
            user.Email       = vm.Email;
            user.PhoneNumber = vm.PhoneNumber;

            // --- Upload avatar ---
            if (vm.AvatarUpload != null && vm.AvatarUpload.Length > 0)
            {
                string uploadDir = Path.Combine(_webHostEnvironment.WebRootPath, "media", "avatars");
                Directory.CreateDirectory(uploadDir);

                // Xóa ảnh cũ
                if (!string.IsNullOrEmpty(user.Avatar))
                {
                    string oldFile = Path.Combine(uploadDir, user.Avatar);
                    if (System.IO.File.Exists(oldFile))
                        System.IO.File.Delete(oldFile);
                }

                string fileName = Guid.NewGuid() + "_" + vm.AvatarUpload.FileName;
                string filePath = Path.Combine(uploadDir, fileName);
                await using var fs = new FileStream(filePath, FileMode.Create);
                await vm.AvatarUpload.CopyToAsync(fs);

                user.Avatar = fileName;
            }

            var updateResult = await _userManager.UpdateAsync(user);
            if (!updateResult.Succeeded)
            {
                foreach (var e in updateResult.Errors)
                    ModelState.AddModelError("", e.Description);
                vm.AvatarUrl = user.Avatar;
                vm.Roles = await _userManager.GetRolesAsync(user);
                return View(vm);
            }

            // --- Đổi mật khẩu ---
            if (!string.IsNullOrEmpty(vm.NewPassword))
            {
                var token    = await _userManager.GeneratePasswordResetTokenAsync(user);
                var pwResult = await _userManager.ResetPasswordAsync(user, token, vm.NewPassword);
                if (!pwResult.Succeeded)
                {
                    foreach (var e in pwResult.Errors)
                        ModelState.AddModelError("", e.Description);
                    vm.AvatarUrl = user.Avatar;
                    vm.Roles = await _userManager.GetRolesAsync(user);
                    return View(vm);
                }
                await _signInManager.RefreshSignInAsync(user);
            }

            TempData["success"] = "Cập nhật thông tin tài khoản thành công!";
            return RedirectToAction("Profile");
        }
    }
}
