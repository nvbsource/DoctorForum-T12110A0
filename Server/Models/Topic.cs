using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;
using System.Text.Json.Serialization;

namespace Doctors_Forum_Server.Models
{
	public class Topic
	{
		[Key]
		[DatabaseGenerated(DatabaseGeneratedOption.Identity)]
		public int Id { get; set; }
		public int? ParentId { get; set; }
		public string? Title { get; set; }
		public string? Description { get; set; }
		public string? Icon { get; set; }
		public bool IsAdmin { get; set; }
		public DateTime Created_at { get; set; }
		public DateTime Updated_at { get; set; }
        public virtual ICollection<Post>? Posts { get; set; }
        public virtual ICollection<Topic>? SubTopics { get; set; }
        public virtual Topic? ParentTopic { get; set; }

		public Topic()
        {
            Created_at = DateTime.Now;
            Updated_at = DateTime.Now;
            IsAdmin = true;
        }
    }
}
