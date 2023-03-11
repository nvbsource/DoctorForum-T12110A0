namespace Doctors_Forum_Server.DTOs.Topic
{
    public class TopicUpdateDTO
    {
        public string? Title { get; set; }
        public int? ParentId { get; set; }
        public string? Description { get; set; }
        public string? Icon { get; set; }
        public bool? IsAdmin { get; set; }
    }
}
