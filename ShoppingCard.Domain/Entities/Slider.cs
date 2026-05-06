using System.ComponentModel.DataAnnotations;

namespace ShoppingCard.Domain.Entities
{
    public class Slider
    {
        [Key]
        public int Id { get; set; }
        [Required(ErrorMessage = "Yêu cầu nhập Tên Slider.")]
        public string Name { get; set; }
        [Required(ErrorMessage = "Yêu cầu nhập Mô tả Thương hiệu.")]
        public string Description { get; set; }
        public int? Status { get; set; }
        public string Image { get; set; }
    }
}
