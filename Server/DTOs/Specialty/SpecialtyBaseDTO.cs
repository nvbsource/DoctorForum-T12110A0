using Doctors_Forum_Server.DTOs.SubSpecialty;

namespace Doctors_Forum_Server.DTOs.Specialty
{
    public class SpecialtyBaseDTO
    {
        public int Id { get; set; }
        public string? Name { get; set; }
        public ICollection<SubSpecialtyBaseDTO>? SubSpecialties { get; set; }
        public DateTime Created_at { get; set; }
        public DateTime Updated_at { get; set; }
    }
}
