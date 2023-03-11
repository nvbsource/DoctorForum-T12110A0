using System;
using Doctors_Forum_Server.Data;

namespace Doctors_Forum_Server.Repositories.Position
{
    using Doctors_Forum_Server.Models;

    public class PositionService : BaseRepository<Position>, IPositionRepository
    {
        private readonly IConfiguration _config;
        public PositionService(ApplicationContext context, IConfiguration config) : base(context)
        {
            _config = config;
        }

    }
}
