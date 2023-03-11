using Doctors_Forum_Server.DTOs.AppointmentReason;
using Doctors_Forum_Server.Models;

namespace Doctors_Forum_Server.DTOs.Appointment
{
    public class AppointmentUpdateStateDTO
    {
        public string? Status { get; set; }
        public DateTime? TimeStart { get; set; }
        public string? CommentAdmin { get; set; }
    }
}
