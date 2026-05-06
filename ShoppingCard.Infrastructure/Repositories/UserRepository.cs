using Microsoft.EntityFrameworkCore;
using ShoppingCard.Domain.Interfaces;
using ShoppingCard.Domain.Entities;
using ShoppingCard.Infrastructure.Data;

namespace ShoppingCard.Infrastructure.Repositories
{
    public class UserRepository : IUserRepository
    {
        private readonly DataContext _context;

        public UserRepository(DataContext context)
        {
            _context = context;
        }

        public async Task<IEnumerable<dynamic>> GetUsersWithRolesAsync()
        {
            var usersWithRoles = await (from u in _context.Users
                                        join ur in _context.UserRoles on u.Id equals ur.UserId into userRoles
                                        from ur in userRoles.DefaultIfEmpty()
                                        join r in _context.Roles on ur.RoleId equals r.Id into roles
                                        from r in roles.DefaultIfEmpty()
                                        select new { User = u, RoleName = r != null ? r.Name : "No role" })
                                        .ToListAsync();
            return usersWithRoles;
        }

        public async Task<bool> HasOrdersAsync(string userEmail)
        {
            return await _context.Orders.AnyAsync(o => o.UserName == userEmail);
        }

        public async Task DeleteUserRelatedDataAsync(string userId)
        {
            var userCarts = _context.Carts.Where(c => c.UserId == userId);
            _context.Carts.RemoveRange(userCarts);

            var userWishlists = _context.Wishlists.Where(w => w.UserId == userId);
            _context.Wishlists.RemoveRange(userWishlists);
        }

        public async Task<int> CountAsync()
        {
            return await _context.Users.CountAsync();
        }

        public async Task<AppUser?> FindByIdAsync(string id)
        {
            return await _context.Users.FindAsync(id);
        }

        public async Task SaveChangesAsync()
        {
            await _context.SaveChangesAsync();
        }
    }
}
