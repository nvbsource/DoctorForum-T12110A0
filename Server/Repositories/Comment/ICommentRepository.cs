

namespace Doctors_Forum_Server.Repositories.Comment
{
    using Doctors_Forum_Server.Models;
    using System.Threading.Tasks;

    public interface ICommentRepository: IRepository<Comment>
    {
        public Comment? FindCommentByPostId(int postId);
        public int GetNumberCommentInPost(int postId);
  
    }
}
