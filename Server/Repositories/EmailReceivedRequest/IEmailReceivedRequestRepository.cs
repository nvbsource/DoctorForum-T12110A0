namespace Doctors_Forum_Server.Repositories.EmailReceivedRequest
{
    using Doctors_Forum_Server.Models;
    using System.Threading.Tasks;

    public interface IEmailReceivedRequestRepository : IRepository<EmailReceivedRequest>
    {
        public Task<List<EmailReceivedRequest>> GetAllOfUser(int userId);
    }
}
