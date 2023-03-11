using System.ComponentModel.DataAnnotations;

namespace Doctors_Forum_Server.DTOs.Topic
{
	public class TopicCreateDTO
	{
		[Required]
		public string? Title { get; set; }
		public int? ParentId { get; set; }
		public string? Description { get; set; }
		public string? Icon { get; set; }
	}
}
