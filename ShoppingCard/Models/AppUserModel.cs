using Microsoft.AspNetCore.Identity;

namespace ShoppingCard.Models
{
    public class AppUserModel : IdentityUser
    {
        public string Occupation { get; set; }
    }
}
