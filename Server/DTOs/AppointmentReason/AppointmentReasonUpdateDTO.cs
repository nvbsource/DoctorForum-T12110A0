using System.ComponentModel.DataAnnotations;

namespace Doctors_Forum_Server.DTOs.AppointmentReson

{
    public class AppointmentReasonUpdateDTO
    {
        public string? Name { get; set; }
        public bool? Active { get; set; }
    }
}
