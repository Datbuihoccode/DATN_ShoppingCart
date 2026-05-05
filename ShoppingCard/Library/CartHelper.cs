using System.Security.Claims;
using Microsoft.AspNetCore.Http;

namespace ShoppingCard.Library
{
    public static class CartHelper
    {
        public static string GetUserId(HttpContext httpContext)
        {
            var userId = httpContext.User.FindFirstValue(ClaimTypes.NameIdentifier);
            if (string.IsNullOrEmpty(userId))
            {
                userId = httpContext.Request.Cookies["GuestCartId"];
                if (string.IsNullOrEmpty(userId))
                {
                    userId = "guest_" + Guid.NewGuid().ToString("N");
                    CookieOptions options = new CookieOptions
                    {
                        Expires = DateTime.Now.AddDays(7),
                        HttpOnly = true,
                        IsEssential = true,
                        Secure = httpContext.Request.IsHttps,
                        SameSite = SameSiteMode.Lax
                    };
                    httpContext.Response.Cookies.Append("GuestCartId", userId, options);
                }
            }
            return userId;
        }
    }
}
