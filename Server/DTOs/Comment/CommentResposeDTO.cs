
namespace Doctors_Forum_Server.DTOs.Comment
{
    using Doctors_Forum_Server.DTOs.Like;
    using Doctors_Forum_Server.DTOs.User;
    using Doctors_Forum_Server.Models;
    public class CommentResponseDTO: CommentBaseDTO
    {
        public ICollection<LikeBaseDTO> Likes { get; set; }
        public UserBaseDTO User { get; set; }
        public virtual ICollection<CommentResponseDTO> ReplyComments { get; set; }
    }
}
