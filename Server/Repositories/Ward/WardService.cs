using System;
using Doctors_Forum_Server.Data;

namespace Doctors_Forum_Server.Repositories.Ward
{
    using Doctors_Forum_Server.Models;

    public class CertificateService : BaseRepository<Ward>, ICertificateRepository
    {
        private readonly IConfiguration _config;
        public CertificateService(ApplicationContext context, IConfiguration config) : base(context)
        {
            _config = config;
        }

    }
}
