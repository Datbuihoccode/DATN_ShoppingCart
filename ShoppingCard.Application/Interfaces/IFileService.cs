using Microsoft.AspNetCore.Http;

namespace ShoppingCard.Application.Interfaces
{
    public interface IFileService
    {
        Task<string> UploadImageAsync(IFormFile file, string subDirectory);
        void DeleteImage(string fileName, string subDirectory);
    }
}
