using System;
using Doctors_Forum_Server.Data;

namespace Doctors_Forum_Server.Repositories.Certificate
{
    using Doctors_Forum_Server.Models;

    public class AppointmentReasonService : BaseRepository<Certificate>, IAppointmentReasonRepository
    {
        private readonly IConfiguration _config;
        public AppointmentReasonService(ApplicationContext context, IConfiguration config) : base(context)
        {
            _config = config;
        }

    }
}
