namespace Doctors_Forum_Server.DTOs.Comment
{
    public class CommentBaseDTO
    {
        public int Id { get; set; }
        public int? ParentId { get; set; }
        public int PostId { get; set; }
        public int UserId { get; set; }
        public string? Content { get; set; }
        public DateTime Created_at { get; set; }
        public DateTime Updated_at { get; set; }
    }
}
