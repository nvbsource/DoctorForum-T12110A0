using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Doctors_Forum_Server.Models
{
    public class ContentChat
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int Id { get; set; }
        public int ChatId { get; set; }
        public int UserId { get; set; }
        public int? ParentId { get; set; }
        public string? Content { get; set; }
        public bool IsRead { get; set; } 
        public DateTime Created_at { get; set; }
        public DateTime Updated_at { get; set; }
        public virtual User? User { get; set; }
        public virtual Chat? Chat { get; set; }
        public virtual ContentChat? ParentChat { get; set; }
        public virtual ICollection<ContentChat>? ReplyChats { get; set; }

        public ContentChat()
        {
            Created_at = DateTime.Now;
            Updated_at = DateTime.Now;
            IsRead = false;
        }
    }
}
