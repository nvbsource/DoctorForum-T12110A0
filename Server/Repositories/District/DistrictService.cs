using System;
using Doctors_Forum_Server.Data;

namespace Doctors_Forum_Server.Repositories.District
{
    using Doctors_Forum_Server.Models;

    public class DistrictService : BaseRepository<District>, IDistrictRepository
    {
        private readonly IConfiguration _config;
        public DistrictService(ApplicationContext context, IConfiguration config) : base(context)
        {
            _config = config;
        }

    }
}
