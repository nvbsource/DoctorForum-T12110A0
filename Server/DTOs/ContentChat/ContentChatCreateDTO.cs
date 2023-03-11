using System.ComponentModel.DataAnnotations;

namespace Doctors_Forum_Server.DTOs.ContentChat
{
    public class ContentChatCreateDTO
    {
        [Required]
        public int ReceiverId { get; set; }
        [Required]
        public string Content { get; set; }
        public int? ParentId { get; set; }
    }
}
