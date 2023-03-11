
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Doctors_Forum_Server.DTOs.User
{
    public class UserCreateDTO
    {
        [Required(ErrorMessage = "Username cannot be left blank")]
        [StringLength(50, MinimumLength = 6, ErrorMessage = "username must be {2} or more characters")]
        public string? Username { get; set; }

        [Required(ErrorMessage = "Password cannot be left blank")]
        [StringLength(50, MinimumLength = 6, ErrorMessage = "password must be {2} or more characters")]
        public string? Password { get; set; }

        [Required(ErrorMessage = "FirstName cannot be left blank")]
        public string? FirstName { get; set; }

        [Required(ErrorMessage = "LastName cannot be left blank")]
        public string? LastName { get; set; }

        [RegularExpression(@"^(male|female|more)$", ErrorMessage = "Invalid gender value")]
        public string? Gender { get; set; }
        [Phone(ErrorMessage = "Phone invalid")]
        public string? PhoneNumber { get; set; }
        [EmailAddress(ErrorMessage = "Email invalid")]
        public string? EmailAddress { get; set; }
        public bool? IsDoctor { get; set; } = false;
    }
}
