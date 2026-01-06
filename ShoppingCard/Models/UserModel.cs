using System.ComponentModel.DataAnnotations;

namespace ShoppingCard.Models
{
    public class UserModel
    {
        public int Id { get; set; }

        [Required(ErrorMessage ="Không bỏ trống Tên đăng nhập.")]
        public string UserName { get; set; }

        [Required(ErrorMessage = "Không bỏ trống Email")]
        public string Email { get; set; }

        [DataType(DataType.Password), Required(ErrorMessage ="Yêu cầu nhập Mật khẩu")] 
        public string Password { get; set; }
    }
}
