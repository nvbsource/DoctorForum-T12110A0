using System;
using Doctors_Forum_Server.Data;

namespace Doctors_Forum_Server.Repositories.Specialty
{
    using AutoMapper;
    using Doctors_Forum_Server.DTOs.Specialty;
    using Doctors_Forum_Server.DTOs.SubSpecialty;
    using Doctors_Forum_Server.Models;
    using Microsoft.EntityFrameworkCore;

    public class SpecialtyService : BaseRepository<Specialty>, 
        ISpecialtyRepository
    {
        private readonly IConfiguration _config;
        private readonly IMapper _mapper;
        public SpecialtyService(ApplicationContext context, IConfiguration config, IMapper mapper) : base(context)
        {
            _config = config;
            _mapper = mapper;
        }

		public List<SpecialtyBaseDTO> GetAllSpecialty()
		{   var a = this._context.Specialties.Where(s => s.ParentId == null)
                .Include(s => s.SubSpecialties)
                .Select(s => new SpecialtyBaseDTO()
                {
                    Id = s.Id,
                    Name = s.Name,
                    SubSpecialties = _mapper.Map<List<SubSpecialtyBaseDTO>>(s.SubSpecialties),
                    Created_at = s.Created_at,
                    Updated_at = s.Updated_at,
                })
                .ToList();
            return a;
		}
	}
}
