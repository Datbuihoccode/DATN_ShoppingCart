using Microsoft.AspNetCore.Http;
using System.ComponentModel.DataAnnotations;

namespace ShoppingCard.Application.DTOs
{
    public class SliderDto
    {
        public int Id { get; set; }

        [Required(ErrorMessage = "Yêu cầu nhập Tên Slider.")]
        public string Name { get; set; }

        [Required(ErrorMessage = "Yêu cầu nhập Mô tả Slider.")]
        public string Description { get; set; }

        public int? Status { get; set; }

        public string Image { get; set; }

        public IFormFile ImageUpload { get; set; }
    }
}
