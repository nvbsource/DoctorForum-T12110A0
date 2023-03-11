namespace Doctors_Forum_Server.DTOs.CommentImage
{
    public class CommentImageBaseDTO
    {
        public int Id { get; set; }
        public int CommentId { get; set; }
        public string? Image { get; set; }
        public DateTime Created_at { get; set; }
        public DateTime Updated_at { get; set; }
    }
}
