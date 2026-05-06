using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace ShoppingCard.Domain.Entities
{
    public class Rating
    {
        [Key]
        public int Id { get; set; }
        public int ProductId { get; set; }
        [Required(ErrorMessage = "Mời nhập đánh giá của bạn.")]
        public string? Comment { get; set; }
        [Required(ErrorMessage = "Mời nhập tên của bạn.")]
        public string? Name { get; set; }
        [Required(ErrorMessage = "Mời nhập Email của bạn.")]
        public string? Email { get; set; }
        public string? Star { get; set; }

        [ForeignKey("ProductId")]
        public virtual Product? Product { get; set; }
    }
}
