using System.ComponentModel.DataAnnotations;

namespace Doctors_Forum_Server.DTOs.User
{
    public class UserChangePassDTO
    {
        [Required]
        public string PasswordOld { get; set; } = string.Empty;
        [Required]
        [StringLength(50, MinimumLength = 6, ErrorMessage = "password must be {2} or more characters")]
        public string PasswordNew { get; set; } = string.Empty;
        [Required]
        public string ConfirmPasswordNew { get; set; } = string.Empty;
    }
}
