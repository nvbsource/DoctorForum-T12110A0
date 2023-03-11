using System;
using Doctors_Forum_Server.Data;

namespace Doctors_Forum_Server.Repositories.Like
{
    using Doctors_Forum_Server.Models;
    using Microsoft.EntityFrameworkCore;

    public class LikeService : BaseRepository<Like>, ILikeRepository
    {
        private readonly IConfiguration _config;
        public LikeService(ApplicationContext context, IConfiguration config) : base(context)
        {
            _config = config;
        }

        public Like? FindLikeByPostId(int postId)
        {
            return this._context.Likes.SingleOrDefault(l => l.PostId.Equals(postId) && l.CommentId == null);
        }
        public Like? FindLikeComment(int postId, int commentId)
        {
            return this._context.Likes.SingleOrDefault(l => l.PostId.Equals(postId) && l.CommentId.Equals(commentId));
        }
        public List<Like>? GetAllLikePost(int postId)
        {
            return this._context.Likes.Where(l => l.PostId.Equals(postId)).ToList();
        }

    }
}
