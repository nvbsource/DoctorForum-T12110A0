using System.ComponentModel.DataAnnotations;

namespace Doctors_Forum_Server.DTOs.Appointment
{
    public class AppointmentCreateDTO
    {
        [Required]
        public string FullName { get; set; }
        [Required]
        public string Email { get; set; }
        [Required]
        public string Phone { get; set; }
        [Required]
        public int UserId { get; set; }
        [Required]
        public int AppointmentReasonId { get; set; }
        public string? Other { get; set; }
        [Required]
        public DateTime StartDate { get; set; }
    }
}
