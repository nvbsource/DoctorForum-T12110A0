using System;
using Doctors_Forum_Server.Data;

namespace Doctors_Forum_Server.Repositories.Province
{
    using Doctors_Forum_Server.Models;

    public class ProvinceService : BaseRepository<Province>, IProvinceRepository
    {
        private readonly IConfiguration _config;
        public ProvinceService(ApplicationContext context, IConfiguration config) : base(context)
        {
            _config = config;
        }

    }
}
