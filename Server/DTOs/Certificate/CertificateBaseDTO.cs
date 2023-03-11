namespace Doctors_Forum_Server.DTOs.Certificate
{
    public class CertificateBaseDTO
    {
        public int Id { get; set; }
        public int SpecialtyDoctorId { get; set; }
        public string? Image { get; set; }
        public DateTime Created_at { get; set; }
        public DateTime Updated_at { get; set; }
    }
}
