using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Http;
using ShoppingCard.Application.Interfaces;

namespace ShoppingCard.Infrastructure.Services
{
    public class FileService : IFileService
    {
        private readonly IWebHostEnvironment _webHostEnvironment;

        public FileService(IWebHostEnvironment webHostEnvironment)
        {
            _webHostEnvironment = webHostEnvironment;
        }

        public async Task<string> UploadImageAsync(IFormFile file, string subDirectory)
        {
            if (file == null) return null;

            string uploadDir = Path.Combine(_webHostEnvironment.WebRootPath, subDirectory);
            if (!Directory.Exists(uploadDir))
            {
                Directory.CreateDirectory(uploadDir);
            }

            string imageName = Guid.NewGuid().ToString() + "_" + file.FileName;
            string filePath = Path.Combine(uploadDir, imageName);

            using (var fs = new FileStream(filePath, FileMode.Create))
            {
                await file.CopyToAsync(fs);
            }

            return imageName;
        }

        public void DeleteImage(string fileName, string subDirectory)
        {
            if (string.IsNullOrEmpty(fileName) || fileName == "noimage.jpg") return;

            string uploadDir = Path.Combine(_webHostEnvironment.WebRootPath, subDirectory);
            string filePath = Path.Combine(uploadDir, fileName);

            if (File.Exists(filePath))
            {
                File.Delete(filePath);
            }
        }
    }
}
