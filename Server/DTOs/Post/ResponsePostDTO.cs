using Doctors_Forum_Server.DTOs.Comment;
using Doctors_Forum_Server.DTOs.User;
using Doctors_Forum_Server.DTOs.Like;
using Doctors_Forum_Server.DTOs.Topic;

namespace Doctors_Forum_Server.DTOs.Post
{
    public class ResponsePostDTOAdmin : PostBaseDTO
    {
        public UserBasePrivateDTO? User { get; set; }
        public ICollection<LikeBaseDTO>? Likes { get; set; }
        public ICollection<CommentResponseDTO>? Comments { get; set; }
        public TopicBaseDTO? Topic { get; set; }
        public int? NumberComments { get; set; }
    }
}
