
namespace Doctors_Forum_Server.DTOs.SpecialtyDoctor
{
    using Doctors_Forum_Server.DTOs.Specialty;
    using Doctors_Forum_Server.DTOs.SubSpecialty;
    using Doctors_Forum_Server.Models;

    public class SpecialtyDoctorAdminResponse
    {
        public int Id { get; set; }
        public SpecialtyClientDTO Specialty { get; set; }
        public List<FileSpecialtyDoctorDTO> files { get; set; }
        public int UserId { get; set; }
        public string Status { get; set; }
        public string? Educational { get; set; }
        public DateTime Created_at { get; set; }
        public DateTime Updated_at { get; set; }
    }
}
