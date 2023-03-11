using System;
using System.ComponentModel.DataAnnotations;
using Doctors_Forum_Server.DTOs.Topic;

namespace Doctors_Forum_Server.DTOs.Post
{
    public class PostBaseDTO
    {
        public int Id { get; set; }
        public int UserId { get; set; }
        public int TopicId { get; set; }
        public string? Title { get; set; }
        public string? Image { get; set; }
        public string? Content { get; set; }
        public DateTime Created_at { get; set; }
        public DateTime Updated_at { get; set; }
        public TopicBaseDTO? Topic { get; set; }
    }
}

