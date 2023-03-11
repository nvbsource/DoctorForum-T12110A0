using Doctors_Forum_Server.DTOs.Specialty;
using Doctors_Forum_Server.DTOs.SubSpecialty;

namespace Doctors_Forum_Server.DTOs.SpecialtyDoctor
{
    public class SpecialtyDoctorBaseDTO
    {
        public int Id { get; set; }
        public int SpecialtyId { get; set; }
        public int UserId { get; set; }
        public string? Educational { get; set; }
        public string Status { get; set; }
        public SpecialtyBaseDTO Specialty { get; set; }
        public DateTime Created_at { get; set; }
        public DateTime Updated_at { get; set; }
    }
}
