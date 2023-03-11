namespace Doctors_Forum_Server.DTOs.ContentChat
{
    public class ContentChatBaseDTO
    {
        public int Id { get; set; }
        public int ChatId { get; set; }
        public int UserId { get; set; }
        public int? ParentId { get; set; }
        public string? Content { get; set; }
        public bool IsRead { get; set; }
        public bool IsYou { get; set; }
        public int ReceiverId { get; set; }
        public DateTime Created_at { get; set; }
        public DateTime Updated_at { get; set; }
    }
}
