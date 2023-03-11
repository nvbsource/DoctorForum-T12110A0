using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;

namespace Doctors_Forum_Server.Models
{
	public class Comment
	{
		[Key]
		[DatabaseGenerated(DatabaseGeneratedOption.Identity)]
		public int Id { get; set; }
		public int? ParentId { get; set; }
		public int PostId { get; set; }
		public int UserId { get; set; }
		public string? Content { get; set; }
		public DateTime Created_at { get; set; }
		public DateTime Updated_at { get; set; }
		public virtual ICollection<CommentImage>? CommentImages { get; set; }
		public virtual ICollection<Like>? Likes { get; set; }
		public virtual ICollection<Comment>? ReplyComments { get; set; }
        public virtual Comment? ParentComment { get; set; }
        public virtual User? User { get; set; }
        public virtual Post? Post { get; set; }

        public Comment()
        {
            Created_at = DateTime.Now;
            Updated_at = DateTime.Now;
        }
    }
}