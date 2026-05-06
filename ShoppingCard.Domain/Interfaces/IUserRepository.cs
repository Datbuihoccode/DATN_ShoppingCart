using ShoppingCard.Domain.Entities;

namespace ShoppingCard.Domain.Interfaces
{
    public interface IUserRepository
    {
        Task<IEnumerable<dynamic>> GetUsersWithRolesAsync();
        Task<bool> HasOrdersAsync(string userEmail);
        Task DeleteUserRelatedDataAsync(string userId);
        Task<int> CountAsync();
        Task<AppUser?> FindByIdAsync(string id);
        Task SaveChangesAsync();
    }
}
