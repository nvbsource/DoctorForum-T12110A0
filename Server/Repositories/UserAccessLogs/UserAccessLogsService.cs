using System;
using Doctors_Forum_Server.Data;

namespace Doctors_Forum_Server.Repositories.UserAccessLogs
{
    using System.Net;
    using System.Threading.Tasks;
    using Doctors_Forum_Server.Models;

    public class UserAccessLogsService : BaseRepository<UserAccessLogs>, IUserAccessLogsRepository
    {
        private readonly IConfiguration _config;
        private readonly ILogger<UserAccessLogsService> _logger;
        public UserAccessLogsService(ApplicationContext context, IConfiguration config, ILogger<UserAccessLogsService> logger) : base(context)
        {
            _config = config;
            _logger = logger;
        }

        public async Task<UserAccessLogs> CreateAsync(int userId, string ipAddress, string userAgent)
        {
            var accessLog = new UserAccessLogs
            {
                UserId = userId,
                AccessTime = DateTime.UtcNow,
                IpAddress = ipAddress,
                DeviceInfo = userAgent
            };

            await this.Create(accessLog);
            return accessLog;
        }
    }
}
