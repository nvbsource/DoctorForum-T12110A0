using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;

namespace Doctors_Forum_Server.Models
{
    public class Appointment
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int Id { get; set; }
        public string FullName { get; set; }
        public string Email { get; set; }
        public string Phone { get; set; }
        public int UserId { get; set; }
        public int AppointmentReasonId { get; set; }
        public string? Other { get; set; }
        public string? Status { get; set; }
        public string? CommentAdmin { get; set; }
        public DateTime? TimeStart { get; set; }
        public DateTime StartDate { get; set; }
        public DateTime Created_at { get; set; }
        public DateTime Updated_at { get; set; }
        public virtual User? User { get; set; }
        public virtual AppointmentReason? AppointmentReason { get; set; }

        public Appointment()
        {
            Status = "pending";
            Created_at = DateTime.Now;
            Updated_at = DateTime.Now;
        }
    }
}
