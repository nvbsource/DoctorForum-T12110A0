using System;
using Doctors_Forum_Server.Data;

namespace Doctors_Forum_Server.Repositories.Country
{
    using Doctors_Forum_Server.Models;

    public class CountryService : BaseRepository<Country>, ICountryRepository
    {
        private readonly IConfiguration _config;
        public CountryService(ApplicationContext context, IConfiguration config) : base(context)
        {
            _config = config;
        }

    }
}
