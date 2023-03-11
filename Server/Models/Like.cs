using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;

namespace Doctors_Forum_Server.Models
{
	public class Like
	{
		[Key]
		[DatabaseGenerated(DatabaseGeneratedOption.Identity)]
		public int Id { get; set; }
		public int PostId { get; set; }
		public int UserId { get; set; }
		public int? CommentId { get; set; }
		public virtual User? User { get; set; }
		public virtual Post? Post { get; set; }
		public virtual Comment? Comment { get; set; }
		public DateTime Created_at { get; set; }
		public DateTime Updated_at { get; set; }
		public Like()
		{
			Created_at = DateTime.Now;
            Updated_at = DateTime.Now;
        }
	}
}
