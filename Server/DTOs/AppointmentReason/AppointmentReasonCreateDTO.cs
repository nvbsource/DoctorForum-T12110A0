using System.ComponentModel.DataAnnotations;
using System.Text.Json.Serialization;

namespace Doctors_Forum_Server.DTOs.AppointmentReson

{
    public class AppointmentReasonCreateDTO
    {
        public string? Name { get; set; }
    }
}
