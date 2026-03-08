using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using ShoppingCard.Areas.Admin.Repository;
using ShoppingCard.Models;
using ShoppingCard.Models.ViewsModels;

namespace ShoppingCard.Controllers
{
    public class AccountController : Controller
    {
        private UserManager<AppUserModel> _userManager;
        private SignInManager<AppUserModel> _signInManager;
        private readonly IEmailSender _emailSender;
        public AccountController(UserManager<AppUserModel> userManager, SignInManager<AppUserModel> signInManager, IEmailSender emailSender)
        {
            _userManager = userManager;
            _signInManager = signInManager;
            _emailSender = emailSender;
        }

        public IActionResult Login(string returnUrl)
        {
            return View(new LoginViewModel { ReturnUrl = returnUrl});
        }

        [HttpPost]
        public async Task<IActionResult> Login(LoginViewModel loginVM)
        {
            if(ModelState.IsValid)
            {
                Microsoft.AspNetCore.Identity.SignInResult result = await _signInManager.PasswordSignInAsync(loginVM.UserName, loginVM.Password, false, false);
                if(result.Succeeded)
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

        public async Task<IActionResult> Create()
        {
            return View();
        }

        [HttpPost]
        public async Task<IActionResult> Create(UserModel user)
        {
            if(ModelState.IsValid)
            {
                AppUserModel newUser = new AppUserModel()
                {
                    UserName = user.UserName,
                    Email = user.Email
                };
                IdentityResult result = await _userManager.CreateAsync(newUser, user.Password);
                if(result.Succeeded)
                {
                    TempData["success"] = "Tạo tài khoản thành công!";
                    return Redirect("/account/login");
                }
                foreach(IdentityError error in result.Errors)
                {
                    ModelState.AddModelError("", error.Description);
                }
                
            }
            return View();
        }

        public async Task<IActionResult> Logout(string returnUrl="/")
        {
            await _signInManager.SignOutAsync();
            return Redirect(returnUrl);
        }
    }
}
