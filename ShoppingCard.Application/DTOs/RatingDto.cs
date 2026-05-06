using System.ComponentModel.DataAnnotations;

namespace ShoppingCard.Application.DTOs
{
    public class RatingDto
    {
        public long ProductId { get; set; }

        [Required(ErrorMessage = "Vui lòng nhập tên của bạn")]
        public string Name { get; set; }

        public string Email { get; set; }

        [Required(ErrorMessage = "Vui lòng nhập nội dung đánh giá")]
        public string Comment { get; set; }

        [Range(1, 5, ErrorMessage = "Vui lòng chọn số sao")]
        public int Star { get; set; }
    }
}
