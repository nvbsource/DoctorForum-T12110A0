using System;
using System.ComponentModel.DataAnnotations;

namespace Doctors_Forum_Server.DTOs.Post
{
	public class CreatePostDTO
	{
        [Required]
        public int TopicId { get; set; }
        [Required]
        public string? Title { get; set; }
        public string? Image { get; set; }
        [Required]
        public string? Content { get; set; }
    }
}

