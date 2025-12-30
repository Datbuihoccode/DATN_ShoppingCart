using System.ComponentModel.DataAnnotations;

namespace ShoppingCard.Repository.Validation
{
    public class FileExtensionAttribute : ValidationAttribute
    {
        protected override ValidationResult? IsValid(object? value, ValidationContext validationContext)
        {
            if (value is IFormFile file)
            {
                var extension = Path.GetExtension(file.FileName);//123.jpg
                string[] permittedExtensions = { ".jpg", ".jpeg", ".png", ".gif" };

                bool result = extension.Any(x => extension.EndsWith(x));

                if (!result)
                {
                    return new ValidationResult("File không hợp lệ. Vui lòng tải lên tệp hình ảnh (.jpg, .jpeg, .png, .gif).");
                }
            }
            return ValidationResult.Success;
        }
    }
}
