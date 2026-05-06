using Microsoft.AspNetCore.Identity;

namespace ShoppingCard.Domain.Entities
{
    public class AppUser : IdentityUser
    {
        public string? Occupation { get; set; }
        public string? RoleId { get; set; }
        public string? Token { get; set; }
        public string? Avatar { get; set; }
        public string? Address { get; set; }
        public string? FullName { get; set; }
        public int? ProvinceId { get; set; }
        public int? WardId { get; set; }
    }
}
