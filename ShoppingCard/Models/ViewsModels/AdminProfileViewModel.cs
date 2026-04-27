using System.ComponentModel.DataAnnotations;
using Microsoft.AspNetCore.Mvc.ModelBinding;

namespace ShoppingCard.Models.ViewsModels
{
    public class AdminProfileViewModel
    {
        public string UserName { get; set; }

        [Required(ErrorMessage = "Vui lòng nhập Email.")]
        [EmailAddress(ErrorMessage = "Email không hợp lệ.")]
        public string Email { get; set; }

        [Phone(ErrorMessage = "Số điện thoại không hợp lệ.")]
        [Display(Name = "Số điện thoại")]
        public string PhoneNumber { get; set; }

        [DataType(DataType.Password)]
        [Display(Name = "Mật khẩu mới")]
        [MinLength(6, ErrorMessage = "Mật khẩu mới phải có ít nhất 6 ký tự.")]
        public string NewPassword { get; set; }

        // Avatar
        public string AvatarUrl { get; set; }

        [BindNever]
        [Display(Name = "Ảnh đại diện")]
        public IFormFile AvatarUpload { get; set; }

        // Roles (chỉ hiển thị)
        public IList<string> Roles { get; set; } = new List<string>();
    }
}

