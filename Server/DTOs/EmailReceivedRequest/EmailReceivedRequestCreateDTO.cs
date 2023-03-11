using System.ComponentModel.DataAnnotations;

namespace Doctors_Forum_Server.DTOs.EmailReceivedRequest
{
    public class EmailReceivedRequestCreateDTO
    {
        [Required]
        public string Email { get; set; }
        public bool? Status { get; set; }
    }
}
