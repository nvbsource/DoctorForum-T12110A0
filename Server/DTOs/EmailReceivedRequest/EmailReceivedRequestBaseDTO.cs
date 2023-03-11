namespace Doctors_Forum_Server.DTOs.EmailReceivedRequest
{
    public class EmailReceivedRequestBaseDTO
    {
        public int Id { get; set; }
        public int UserId { get; set; }
        public string? Email { get; set; }
        public bool Status { get; set; }
        public DateTime Created_at { get; set; }
        public DateTime Updated_at { get; set; }
    }
}
