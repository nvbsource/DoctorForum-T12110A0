using System.ComponentModel.DataAnnotations;
using Doctors_Forum_Server.DTOs.Specialty;
using Doctors_Forum_Server.DTOs.SubSpecialty;

namespace Doctors_Forum_Server.DTOs.SpecialtyDoctor
{
    public class SpecialtyDoctorUpdateDTO
    {
        [Required]
        public string Educational { get; set; }
    }
}
