using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;

namespace Doctors_Forum_Server.Models
{
	public class Post
	{
		[Key]
		[DatabaseGenerated(DatabaseGeneratedOption.Identity)]
		public int Id { get; set; }
		public int UserId { get; set; }
		public int TopicId { get; set; }
		public string? Title { get; set; }
		public string? Image { get; set; }
		public string? Content { get; set; }
		public DateTime Created_at { get; set; }
		public DateTime Updated_at { get; set; }
		public ICollection<Like>? Likes { get; set; }
		public ICollection<Comment>? Comments { get; set; }
		public Topic? Topic { get; set; }
		public User? User { get; set; }

		public Post()
        {
            Created_at = DateTime.Now;
            Updated_at = DateTime.Now;
        }
    }
}


