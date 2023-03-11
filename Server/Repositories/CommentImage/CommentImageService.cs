using System;
using Doctors_Forum_Server.Data;

namespace Doctors_Forum_Server.Repositories.CommentImage
{
    using Doctors_Forum_Server.Models;

    public class CommentImageService : BaseRepository<CommentImage>, ICommentImageRepository
    {
        private readonly IConfiguration _config;
        public CommentImageService(ApplicationContext context, IConfiguration config) : base(context)
        {
            _config = config;
        }

    }
}
