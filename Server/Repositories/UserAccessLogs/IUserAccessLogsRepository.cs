using Doctors_Forum_Server.DTOs.User;

namespace Doctors_Forum_Server.Repositories.UserAccessLogs
{
    using Doctors_Forum_Server.Models;
    public interface IUserAccessLogsRepository : IRepository<UserAccessLogs>
    {
        public Task<UserAccessLogs> CreateAsync(int userId, string ipAddress, string userAgent);
    }
}
