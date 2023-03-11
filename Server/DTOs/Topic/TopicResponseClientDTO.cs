
namespace Doctors_Forum_Server.DTOs.Topic
{
    using Doctors_Forum_Server.DTOs.Post;
    using Doctors_Forum_Server.Models;
    public class TopicResponseClientDTO
    {
        public int Id { get; set; }
        public string? Title { get; set; }
        public string? Description { get; set; }
        public string? Icon { get; set; }
        public int? NumberPost { get; set; }
        public bool IsAdmin { get; set; }
        public virtual ICollection<TopicResponseClientDTO>? SubTopics { get; set; }
        public virtual ResponsePostDTO? LastPost { get; set; }
    }
}
