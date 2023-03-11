using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;
using System;

namespace Doctors_Forum_Server.Models
{
    public class EmailReceivedRequest
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int Id { get; set; }
        public int UserId { get; set; }
        public string? Email { get; set; }
        public bool Status { get; set; }
        public DateTime Created_at { get; set; }
        public DateTime Updated_at { get; set; }
        public User? User { get; set; }

        public EmailReceivedRequest()
        {
            Created_at = DateTime.Now;
            Updated_at = DateTime.Now;
        }
    }
}
