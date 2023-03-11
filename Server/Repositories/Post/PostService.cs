using System;
using Doctors_Forum_Server.Data;

namespace Doctors_Forum_Server.Repositories.Post
{
    using System.Threading.Tasks;
    using Doctors_Forum_Server.DTOs.Comment;
    using Doctors_Forum_Server.Models;
    using Microsoft.EntityFrameworkCore;

    public class PostService : BaseRepository<Post>, IPostRepository
    {
        private readonly IConfiguration _config;
        public PostService(ApplicationContext context, IConfiguration config) : base(context)
        {
            _config = config;
        }

        public async Task<Post?> Detail(int id)
        {
            var post = await this._context.Posts
                .Include(c => c.User) // Bao gồm thông tin người dùng cho mỗi post
                .Include(p => p.Comments) // Lấy tất cả các comment của bài đăng
                     .ThenInclude(c => c.User) // Bao gồm thông tin người dùng cho mỗi comment
                     .ThenInclude(u => u.Posts)
                .Include(p => p.Topic)
                .Include(p => p.Likes)
                .SingleOrDefaultAsync(p => p.Id.Equals(id));
            if (post == null) return null;
            post.Comments = GetCommentTree(post.Comments.ToList(), true); // Thay thế tất cả các comment của bài đăng bằng các comment cha đã được sắp xếp đúng thứ tự

            return post;
        }
        private List<Comment> GetCommentTree(List<Comment> comments, bool flag)
        {
            // Lấy tất cả các comment cha (có ParentId == null)
            var topLevelComments = flag ? comments.Where(c => c.ParentId == null).ToList() : comments;

            foreach (var comment in topLevelComments)
            {
                // Lấy tất cả các comment con của comment cha
                var childComments = comments.Where(c => c.ParentId == comment.Id).ToList();

                // Nếu comment cha có các comment con
                if (childComments.Count > 0)
                {
                    // Sử dụng đệ quy để lấy tất cả các reply comment con của các comment con
                    comment.ReplyComments = GetCommentTree(childComments, false);
                }
            }

            return topLevelComments;
        }

        public List<Post> GetAllPostOfTopic(int topicId)
        {
            return this._context.Posts.AsNoTracking()
                .Where(p => p.TopicId == topicId)
                .OrderByDescending(p => p.Created_at)
                .Include(p => p.User)
                .Include(p => p.Comments)
                .ToList();
        }
        public List<Post> GetAllPost()
        {
            return this._context.Posts.AsNoTracking()
                .Include(c => c.User)
                .Include(p => p.Comments)
                     .ThenInclude(c => c.User)
                     .ThenInclude(u => u.Posts)
                .Include(p => p.Topic)
                .Include(p => p.Likes)
                .OrderByDescending(p => p.Created_at)
                .ToList();
        }

        public List<Post> GetNewsPost(int perPage)
        {
            return this._context.Posts.AsNoTracking()
                .OrderByDescending(p => p.Created_at)
                .Take(perPage)
                .Include(p => p.User)
                .Include(p => p.Topic)
                .ToList();
        }

        public List<Post> GetPostOfDoctor(int userId)
        {
            return this._context.Posts.AsNoTracking()
                .Where(d => d.UserId.Equals(userId))
                .OrderByDescending(p => p.Created_at)
                .Include(p => p.Likes)
                .Include(p => p.Comments)
                .ThenInclude(p => p.Likes)
                .Include(p => p.User)
                .Include(p => p.Topic)
                .ToList();
        }
    }
}
