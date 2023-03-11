using System.ComponentModel.DataAnnotations;

namespace Doctors_Forum_Server.DTOs.Comment
{
    public class UpdateCommentDTO
    {
        [Required]
        public int CommentId { get; set; }
        [Required]
        public string? Content { get; set; }
    }
}
