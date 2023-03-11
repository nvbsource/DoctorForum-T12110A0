
namespace Doctors_Forum_Server.DTOs.Topic
{
    using Doctors_Forum_Server.Models;
    public class TopicBaseDTO
    {
        public int Id { get; set; }
        public int? ParentId { get; set; }
        public string? Title { get; set; }
        public string? Description { get; set; }
        public string? Icon { get; set; }
        public bool isAdmin { get; set; }
        public virtual ICollection<Topic>? SubTopics { get; set; }
        public DateTime Created_at { get; set; }
        public DateTime Updated_at { get; set; }
    }
}
