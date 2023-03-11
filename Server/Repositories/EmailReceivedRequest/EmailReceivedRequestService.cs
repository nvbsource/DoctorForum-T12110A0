using System;
using Doctors_Forum_Server.Data;

namespace Doctors_Forum_Server.Repositories.EmailReceivedRequest
{
    using Doctors_Forum_Server.Models;
    using Microsoft.EntityFrameworkCore;
    using System.Collections.Generic;
    using System.Threading.Tasks;

    public class EmailReceivedRequestService : BaseRepository<EmailReceivedRequest>, IEmailReceivedRequestRepository
    {
        private readonly IConfiguration _config;
        public EmailReceivedRequestService(ApplicationContext context, IConfiguration config) : base(context)
        {
            _config = config;
        }

        public Task<List<EmailReceivedRequest>> GetAllOfUser(int userId)
        {
            return this._context.EmailReceivedRequests.Where(e => e.UserId == userId).ToListAsync();
        }
    }
}
