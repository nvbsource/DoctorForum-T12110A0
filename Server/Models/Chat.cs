using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Doctors_Forum_Server.Models
{
    public class Chat
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int Id { get; set; }
        public int UserId { get; set; }
        public int ReceiverUserId { get; set; }
        public string? NameChat { get; set; }
        public DateTime Created_at { get; set; }
        public DateTime Updated_at { get; set; }
        public virtual User? User { get; set; }
        public virtual User? ReceiverUser { get; set; }
        public virtual ICollection<ContentChat>? ContentChats { get; set; }
        public Chat()
        {
            Created_at = DateTime.Now;
            Updated_at = DateTime.Now;
        }
    }
}
