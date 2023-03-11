using System.ComponentModel.DataAnnotations;

namespace Doctors_Forum_Server.DTOs.User
{
    public class UserLoginDTO
    {
        [Required]
        public string Username { get; set; }
        [Required]
        public string Password { get; set; }
    }
}
