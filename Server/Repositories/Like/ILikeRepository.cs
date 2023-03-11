
namespace Doctors_Forum_Server.Repositories.Like
{
    using Doctors_Forum_Server.Models;
    public interface ILikeRepository : IRepository<Like>
    {
        public Like? FindLikeByPostId(int postId);
        public List<Like>? GetAllLikePost(int postId);
        public Like? FindLikeComment(int postId, int commentId);
    }
}
