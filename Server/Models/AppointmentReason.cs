using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;
using System.Text.Json.Serialization;
using System;

namespace Doctors_Forum_Server.Models
{
	public class AppointmentReason
    {
		[Key]
		[DatabaseGenerated(DatabaseGeneratedOption.Identity)]
		public int Id { get; set; }
        public int UserId { get; set; }
        public string? Name { get; set; }
        public bool Active { get; set; }
        public DateTime Created_at { get; set; }
        public DateTime Updated_at { get; set; }
        public virtual ICollection<Appointment>? Appointments { get; set; }
        public virtual User? User { get; set; }

        public AppointmentReason()
        {
            Active = true;
            Created_at = DateTime.Now;
            Updated_at = DateTime.Now;
        }
    }
}
