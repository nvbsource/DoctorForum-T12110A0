using System.ComponentModel.DataAnnotations;

namespace Doctors_Forum_Server.DTOs.Comment
{
    public class CreateCommentDTO
    {
        [Required]
        public int PostId { get; set; }
        public int? ParentId { get; set; }
        [Required]
        public string? Content { get; set; }
    }
}
