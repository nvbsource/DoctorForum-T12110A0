namespace Doctors_Forum_Server.DTOs.SubSpecialty
{
    public class SubSpecialtyBaseDTO
    {
        public int Id { get; set; }
        public int ParentId { get; set; }
        public string? Name { get; set; }
        public DateTime Created_at { get; set; }
        public DateTime Updated_at { get; set; }
    }
}
