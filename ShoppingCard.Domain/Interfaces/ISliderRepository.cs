using ShoppingCard.Domain.Entities;

namespace ShoppingCard.Domain.Interfaces
{
    public interface ISliderRepository
    {
        Task<IEnumerable<Slider>> GetActiveSlidersAsync();
        Task SaveChangesAsync();
    }
}
