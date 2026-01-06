using System.ComponentModel.DataAnnotations;

namespace ShoppingCard.Models.ViewsModels
{
    public class LoginViewModel
    {
        public int Id { get; set; }

        [Required(ErrorMessage = "Không bỏ trống Tên đăng nhập.")]
        public string UserName { get; set; }

        [DataType(DataType.Password), Required(ErrorMessage = "Yêu cầu nhập Mật khẩu")]
        public string Password { get; set; }
        public string ReturnUrl { get; set; }

    }
}
