using Microsoft.AspNetCore.Authentication;
using Microsoft.AspNetCore.Authentication.Google;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using ShoppingCard.Areas.Admin.Repository;
using ShoppingCard.Models;
using ShoppingCard.Models.ViewsModels;
using ShoppingCard.Repository;
using System.Security.Claims;

namespace ShoppingCard.Controllers
{
    public class AccountController : Controller
    {
        private readonly UserManager<AppUserModel> _userManager;
        private readonly RoleManager<IdentityRole> _roleManager;
        private readonly SignInManager<AppUserModel> _signInManager;
        private readonly IEmailSender _emailSender;
        private readonly DataContext _dataContext;

        public AccountController(
            UserManager<AppUserModel> userManager,
            RoleManager<IdentityRole> roleManager,
            SignInManager<AppUserModel> signInManager,
            IEmailSender emailSender,
            DataContext context)
        {
            _userManager = userManager;
            _roleManager = roleManager;
            _signInManager = signInManager;
            _emailSender = emailSender;
            _dataContext = context;
        }

        public IActionResult Login(string returnUrl)
        {
            return View(new LoginViewModel { ReturnUrl = returnUrl });
        }

        [HttpPost]
        public async Task<IActionResult> Login(LoginViewModel loginVM)
        {
            if (ModelState.IsValid)
            {
                var result = await _signInManager.PasswordSignInAsync(loginVM.UserName, loginVM.Password, false, false);
                if (result.Succeeded)
                {
                    TempData["success"] = "Đăng nhập thành công!";
                    var receiver = "1977datbui@gmail.com";
                    var subject = "Đăng nhập thành công";
                    var message = "Bạn đã đăng nhập thành công vào hệ thống.";

                    await _emailSender.SendEmailAsync(receiver, subject, message);
                    return Redirect(loginVM.ReturnUrl ?? "/");
                }

                ModelState.AddModelError("", "Mật khẩu hoặc tên đăng nhập sai!");
            }

            return View(loginVM);
        }

        [HttpGet]
        public IActionResult LoginByGoogle(string returnUrl = null)
        {
            var redirectUrl = Url.Action(nameof(GoogleResponse), "Account", new { returnUrl });
            var properties = _signInManager.ConfigureExternalAuthenticationProperties(
                GoogleDefaults.AuthenticationScheme,
                redirectUrl);

            return Challenge(properties, GoogleDefaults.AuthenticationScheme);
        }

        [HttpGet]
        public async Task<IActionResult> GoogleResponse(string returnUrl = null, string remoteError = null)
        {
            if (!string.IsNullOrEmpty(remoteError))
            {
                TempData["error"] = "Đăng nhập Google thất bại.";
                return RedirectToAction("Login", "Account");
            }

            // Authenticate using Google scheme.
            // Identity may persist external principal in IdentityConstants.ExternalScheme,
            // so fallback to that scheme for compatibility with the current project setup.
            var result = await HttpContext.AuthenticateAsync(GoogleDefaults.AuthenticationScheme);
            if (!result.Succeeded || result.Principal == null)
            {
                result = await HttpContext.AuthenticateAsync(IdentityConstants.ExternalScheme);
            }

            if (!result.Succeeded || result.Principal == null)
            {
                return RedirectToAction("Login");
            }

            var claims = result.Principal.Identities.FirstOrDefault()?.Claims.Select(claim => new
            {
                claim.Issuer,
                claim.OriginalIssuer,
                claim.Type,
                claim.Value
            });

            // return Json(claims); // Dung de debug thong tin Google tra ve.

            var email = claims?.FirstOrDefault(c => c.Type == ClaimTypes.Email)?.Value;
            if (string.IsNullOrWhiteSpace(email))
            {
                TempData["error"] = "Tài khoản Google không có email hợp lệ.";
                return RedirectToAction("Login", "Account");
            }

            string emailName = email.Split('@')[0];
            var existingUser = await _userManager.FindByEmailAsync(email);

            if (existingUser == null)
            {
                var passwordHasher = new PasswordHasher<AppUserModel>();
                var hashedPassword = passwordHasher.HashPassword(null, "Ta!123");

                var newUser = new AppUserModel
                {
                    UserName = emailName,
                    Email = email
                };
                newUser.PasswordHash = hashedPassword;

                var createUserResult = await _userManager.CreateAsync(newUser);

                if (!createUserResult.Succeeded)
                {
                    TempData["error"] = "Đăng ký tài khoản thất bại. Vui lòng thử lại sau.";
                    return RedirectToAction("Login", "Account");
                }

                if (!await _roleManager.RoleExistsAsync("Admin"))
                {
                    await _roleManager.CreateAsync(new IdentityRole("Admin"));
                }

                var roleExist = await _userManager.IsInRoleAsync(newUser, "Admin");
                if (!roleExist)
                {
                    var roleAssignResult = await _userManager.AddToRoleAsync(newUser, "Admin");
                    if (!roleAssignResult.Succeeded)
                    {
                        TempData["error"] = "Không thể gán quyền Admin. Vui lòng thử lại sau.";
                        return RedirectToAction("Login", "Account");
                    }
                }

                await _signInManager.SignInAsync(newUser, isPersistent: false);
                await HttpContext.SignOutAsync(IdentityConstants.ExternalScheme);

                TempData["success"] = "Đăng ký tài khoản thành công.";
                return RedirectToAction("Index", "Home");
            }

            await _signInManager.SignInAsync(existingUser, isPersistent: false);
            await HttpContext.SignOutAsync(IdentityConstants.ExternalScheme);

            if (!string.IsNullOrWhiteSpace(returnUrl))
            {
                return LocalRedirect(returnUrl);
            }

            return RedirectToAction("Index", "Home");
        }

        public IActionResult Create()
        {
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create(UserModel user)
        {
            if (ModelState.IsValid)
            {
                var newUser = new AppUserModel
                {
                    UserName = user.UserName,
                    Email = user.Email
                };

                var result = await _userManager.CreateAsync(newUser, user.Password);
                if (result.Succeeded)
                {
                    if (!await _roleManager.RoleExistsAsync("User"))
                    {
                        await _roleManager.CreateAsync(new IdentityRole("User"));
                    }

                    var addRoleResult = await _userManager.AddToRoleAsync(newUser, "User");
                    if (!addRoleResult.Succeeded)
                    {
                        foreach (var error in addRoleResult.Errors)
                        {
                            ModelState.AddModelError("", error.Description);
                        }

                        TempData["error"] = "Tài khoản đã tạo nhưng chưa gán được quyền User.";
                        return View(user);
                    }

                    TempData["success"] = "Tạo tài khoản thành công!";
                    return Redirect("/account/login");
                }

                foreach (var error in result.Errors)
                {
                    ModelState.AddModelError("", error.Description);
                }
            }

            return View(user);
        }

        public async Task<IActionResult> Logout(string returnUrl = "/")
        {
            await HttpContext.SignOutAsync();
            await HttpContext.SignOutAsync(IdentityConstants.ExternalScheme);
            await _signInManager.SignOutAsync();
            return Redirect(returnUrl);
        }

        [HttpGet]
        public async Task<IActionResult> UpdateAccount()
        {
            var userEmail = User.FindFirstValue(ClaimTypes.Email) ?? User.Identity?.Name;
            if (string.IsNullOrEmpty(userEmail))
            {
                return RedirectToAction("Login", "Account");
            }

            var user = await _userManager.FindByEmailAsync(userEmail);
            if (user == null && !userEmail.Contains("@"))
            {
                user = await _userManager.FindByNameAsync(userEmail);
            }

            if (user == null)
            {
                return NotFound();
            }

            return View(user);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> UpdateInfoAccount(AppUserModel user)
        {
            if (User.Identity?.IsAuthenticated != true)
            {
                return RedirectToAction("Login", "Account");
            }

            if (string.IsNullOrWhiteSpace(user.Id))
            {
                return BadRequest();
            }

            var userId = await _userManager.FindByIdAsync(user.Id);
            if (userId == null)
            {
                return NotFound();
            }

            var currentUserId = _userManager.GetUserId(User);
            if (!string.Equals(currentUserId, userId.Id, StringComparison.Ordinal))
            {
                return Forbid();
            }

            userId.PhoneNumber = user.PhoneNumber;

            if (string.IsNullOrWhiteSpace(user.PasswordHash))
            {
                ModelState.AddModelError("PasswordHash", "Vui lòng nhập mật khẩu mới.");
            }
            else
            {
                var passwordHasher = new PasswordHasher<AppUserModel>();
                var passwordHash = passwordHasher.HashPassword(userId, user.PasswordHash);
                userId.PasswordHash = passwordHash;
            }

            if (!ModelState.IsValid)
            {
                user.UserName = userId.UserName;
                user.Email = userId.Email;
                user.PasswordHash = userId.PasswordHash;
                return View("UpdateAccount", user);
            }

            var result = await _userManager.UpdateAsync(userId);
            if (result.Succeeded)
            {
                await _signInManager.RefreshSignInAsync(userId);
                TempData["success"] = "Cập nhật tài khoản thành công";
                return RedirectToAction("UpdateAccount", "Account");
            }

            foreach (var error in result.Errors)
            {
                ModelState.AddModelError(string.Empty, error.Description);
            }

            user.UserName = userId.UserName;
            user.Email = userId.Email;
            user.PasswordHash = userId.PasswordHash;
            return View("UpdateAccount", user);
        }

        public async Task<IActionResult> History()
        {
            if (User.Identity?.IsAuthenticated != true)
            {
                return RedirectToAction("Login", "Account");
            }

            var userEmail = User.FindFirstValue(ClaimTypes.Email) ?? User.Identity?.Name;
            if (string.IsNullOrWhiteSpace(userEmail))
            {
                return RedirectToAction("Login", "Account");
            }

            var orders = await _dataContext.Orders
                .Where(od => od.UserName == userEmail)
                .OrderByDescending(od => od.Id)
                .ToListAsync();

            ViewBag.UserEmail = userEmail;
            return View(orders);
        }

        public async Task<IActionResult> CancelOrder(string ordercode)
        {
            if (User.Identity?.IsAuthenticated != true)
            {
                return RedirectToAction("Login", "Account");
            }

            if (string.IsNullOrWhiteSpace(ordercode))
            {
                TempData["error"] = "Mã đơn hàng không hợp lệ.";
                return RedirectToAction("History", "Account");
            }

            var userEmail = User.FindFirstValue(ClaimTypes.Email) ?? User.Identity?.Name;
            if (string.IsNullOrWhiteSpace(userEmail))
            {
                return RedirectToAction("Login", "Account");
            }

            var order = await _dataContext.Orders
                .FirstOrDefaultAsync(o => o.OrderCode == ordercode && o.UserName == userEmail);

            if (order == null)
            {
                TempData["error"] = "Không tìm thấy đơn hàng để hủy.";
                return RedirectToAction("History", "Account");
            }

            if (order.Status == 3)
            {
                TempData["info"] = "Đơn hàng đã được hủy trước đó.";
                return RedirectToAction("History", "Account");
            }

            try
            {
                order.Status = 3;
                _dataContext.Update(order);
                await _dataContext.SaveChangesAsync();
                TempData["success"] = "Hủy đơn hàng thành công.";
            }
            catch
            {
                TempData["error"] = "Đã xảy ra lỗi khi hủy đơn hàng.";
            }

            return RedirectToAction("History", "Account");
        }

        public IActionResult ForgetPass()
        {
            return View();
        }

        [HttpPost]
        public async Task<IActionResult> SendMailForgotPass(AppUserModel user)
        {
            var checkMail = await _userManager.Users.FirstOrDefaultAsync(u => u.Email == user.Email);
            
            if (checkMail == null)
            {
                TempData["error"] = "Không tìm thấy Email";
                return RedirectToAction("ForgetPass", "Account");
            }
            else
            {
                string token = Guid.NewGuid().ToString();
                
                checkMail.Token = token;
                _dataContext.Update(checkMail);
                await _dataContext.SaveChangesAsync();

                var receiver = checkMail.Email;
                var subject = "Change password for user " + checkMail.Email;
                var message = "Click on link to change password " +
                    "<a href='" + $"{Request.Scheme}://{Request.Host}/Account/NewPass?email=" + checkMail.Email + "&token=" + token + "'>Click here</a>";

                await _emailSender.SendEmailAsync(receiver, subject, message);

                TempData["success"] = "Một email đã được gửi đến địa chỉ đã đăng ký với hướng dẫn khôi phục mật khẩu.";
                return RedirectToAction("ForgetPass", "Account");
            }
        }

        public async Task<IActionResult> NewPass(string email, string token)
        {
            var checkuser = await _userManager.Users
                .Where(u => u.Email == email)
                .Where(u => u.Token == token).FirstOrDefaultAsync();

            if (checkuser != null)
            {
                ViewBag.Email = checkuser.Email;
                ViewBag.Token = token;
            }
            else
            {
                TempData["error"] = "Không tìm thấy email hoặc mã xác thực không đúng";
                return RedirectToAction("ForgetPass", "Account");
            }

            return View();
        }

        [HttpPost]
        public async Task<IActionResult> UpdateNewPassword(AppUserModel user, string token)
        {
            var checkuser = await _userManager.Users
                .FirstOrDefaultAsync(u => u.Email == user.Email && u.Token == token);

            if (checkuser != null)
            {
                var passwordHasher = new PasswordHasher<AppUserModel>();
                var passwordHash = passwordHasher.HashPassword(checkuser, user.PasswordHash);
                
                checkuser.PasswordHash = passwordHash;
                checkuser.Token = Guid.NewGuid().ToString();

                var result = await _userManager.UpdateAsync(checkuser);
                if (result.Succeeded)
                {
                    TempData["success"] = "Cập nhật mật khẩu thành công";
                    return RedirectToAction("Login", "Account");
                }
            }
            else
            {
                TempData["error"] = "Không tìm thấy email hoặc mã xác thực không hợp lệ";
                return RedirectToAction("ForgetPass", "Account");
            }

            return View();
        }
    }
}

