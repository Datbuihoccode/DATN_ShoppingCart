using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Filters;

namespace ShoppingCard.Library
{
    public class PreventAdminAccessClientAttribute : ActionFilterAttribute
    {
        public override void OnActionExecuting(ActionExecutingContext context)
        {
            if (context.RouteData.Values.ContainsKey("area") || context.RouteData.DataTokens.ContainsKey("area"))
            {
                return;
            }

            if (context.HttpContext.User.Identity.IsAuthenticated)
            {
                if (context.HttpContext.User.IsInRole("Admin") || context.HttpContext.User.IsInRole("Staff"))
                {
                    context.Result = new RedirectToActionResult("Index", "Dashboard", new { area = "Admin" });
                }
            }
            base.OnActionExecuting(context);
        }
    }
}
