using Doctors_Forum_Server.DTOs.AppointmentReason;
using Doctors_Forum_Server.Models;

namespace Doctors_Forum_Server.DTOs.Appointment
{
    public class AppointmentBaseDTO
    {
        public int Id { get; set; }
        public string? FullName { get; set; }
        public string? Email { get; set; }
        public string? Phone { get; set; }
        public int UserId { get; set; }
        public AppointmentReasonBaseClientDTO AppointmentReason { get; set; }
        public string? Other { get; set; }
        public string? Status { get; set; }
        public string? CommentAdmin { get; set; }
        public DateTime? TimeStart { get; set; }
        public DateTime? StartDate { get; set; }
        public DateTime Created_at { get; set; }
        public DateTime Updated_at { get; set; }
    }
}
