using System;
using Doctors_Forum_Server.Data;

namespace Doctors_Forum_Server.Repositories.Comment
{
    using Doctors_Forum_Server.Models;
    using Microsoft.EntityFrameworkCore;
    using System.Threading.Tasks;

    public class CommentService : BaseRepository<Comment>, ICommentRepository
    {
        private readonly IConfiguration _config;
        public CommentService(ApplicationContext context, IConfiguration config) : base(context)
        {
            _config = config;
        }
        public Comment? FindCommentByPostId(int postId)
        {
            return this._context.Comments.SingleOrDefault(c => c.PostId.Equals(postId));
        }

        public int GetNumberCommentInPost(int postId)
        {
            return this._context.Comments.Where(c => c.PostId == postId).Count();
        }
    }
}
