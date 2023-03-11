namespace Doctors_Forum_Server.Repositories.Topic
{
    using Doctors_Forum_Server.DTOs.Topic;
    using Doctors_Forum_Server.Models;
    public interface ITopicRepository : IRepository<Topic>
    {
        public List<TopicResponseClientDTO> GetAllTopicAndSubs();
        public TopicResponseClientDTO GetTopicOfParent(int id);
    }
}