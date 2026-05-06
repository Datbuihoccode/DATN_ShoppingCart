using System.ComponentModel.DataAnnotations;
using Microsoft.AspNetCore.Http;
using System.Collections.Generic;

namespace ShoppingCard.Models.ViewModels
{
    public class LoginViewModel
    {
        public int Id { get; set; }

        [Required(ErrorMessage = "Làm ơn nhập UserName")]
        public string UserName { get; set; }

        [DataType(DataType.Password), Required(ErrorMessage = "Làm ơn nhập Password")]
        public string Password { get; set; }

        public string ReturnUrl { get; set; }
    }

    public class AdminProfileViewModel
    {
        public string UserName { get; set; }
        public string Email { get; set; }
        public string PhoneNumber { get; set; }
        public string AvatarUrl { get; set; }

        public IFormFile AvatarUpload { get; set; }

        [DataType(DataType.Password)]
        public string NewPassword { get; set; }

        [DataType(DataType.Password)]
        public string CurrentPassword { get; set; }

        public IList<string> Roles { get; set; }
    }
    public class UserModel
    {
        public int Id { get; set; }

        [Required(ErrorMessage = "Làm ơn nhập UserName")]
        public string UserName { get; set; }

        [Required(ErrorMessage = "Làm ơn nhập Email"), EmailAddress]
        public string Email { get; set; }

        [DataType(DataType.Password), Required(ErrorMessage = "Làm ơn nhập Password")]
        public string Password { get; set; }

        public string FullName { get; set; }
        public string Address { get; set; }
    }
}
