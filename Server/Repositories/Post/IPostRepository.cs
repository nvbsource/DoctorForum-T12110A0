namespace Doctors_Forum_Server.Repositories.Post
{
    using Doctors_Forum_Server.Models;
    public interface IPostRepository : IRepository<Post>
    {
        public Task<Post?> Detail(int id);
        public List<Post> GetPostOfDoctor(int userId);
        public List<Post> GetNewsPost(int perPage);
        public List<Post> GetAllPostOfTopic(int topicId);
        public List<Post> GetAllPost();
    }
}
