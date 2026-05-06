using System.ComponentModel.DataAnnotations;

namespace ShoppingCard.Domain.Entities
{
    public class Brand
    {
        [Key]
        public int Id { get; set; }
        [Required(ErrorMessage = "Yêu cầu nhập Tên Thương hiệu.")]
        public string Name { get; set; }
        [Required(ErrorMessage = "Yêu cầu nhập Mô tả Thương hiệu.")]
        public string? Description { get; set; }
        public string? Slug { get; set; }
        public int Status { get; set; }
    }
}
