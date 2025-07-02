using System.ComponentModel.DataAnnotations;

namespace ManufacturingERP.Entity
{
    public class User
    {
        [Key]
        public int Id { get; set; }

        [Required, StringLength(50)]
        public string FirstName { get; set; }

        [Required, StringLength(50)]
        public string LastName { get; set; }

        [Required, EmailAddress, StringLength(100)]
        public string Email { get; set; }

        [Required]
        [StringLength(255, MinimumLength = 7, ErrorMessage = "Password must be at least 7 characters long.")]
        [DataType(DataType.Password)]
        public string Password { get; set; }

        [Required, StringLength(15)]
        [RegularExpression(@"^[0-9]{10,15}$", ErrorMessage = "Enter a valid Contact Number.")]
        public string ContactNo { get; set; }

        public DateTime CreatedDate { get; set; } = DateTime.Now;
        public DateTime? ModifiedDate { get; set; }
    }
}
