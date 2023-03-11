using System;
using Doctors_Forum_Server.Data;

namespace Doctors_Forum_Server.Repositories.SpecialtyDoctor
{
    using System.Collections.Generic;
    using System.Threading.Tasks;
    using AutoMapper;
    using Doctors_Forum_Server.DTOs.Specialty;
    using Doctors_Forum_Server.DTOs.SpecialtyDoctor;
    using Doctors_Forum_Server.DTOs.SubSpecialty;
    using Doctors_Forum_Server.Models;
    using Doctors_Forum_Server.Utilities;
    using Microsoft.AspNetCore.Mvc;
    using Microsoft.EntityFrameworkCore;

    public class SpecialtyDoctorService : BaseRepository<SpecialtyDoctor>, ISpecialtyDoctorRepository
    {
        private readonly IConfiguration _config;
        private readonly IMapper _mapper;
        public SpecialtyDoctorService(ApplicationContext context, IConfiguration config, IMapper mapper) : base(context)
        {
            _config = config;
            _mapper = mapper;
        }

        public async Task<List<SpecialtyDoctorClientResponse>> GetAllSpecialtiesOfDoctor(int userId)
        {
            var specialtiesOfDoctor = await this._context.SpecialtyDoctors.AsNoTracking()
                                            .Where(s => s.UserId == userId)
                                            .Include(s => s.Specialty)
                                            .ToListAsync();

            var specialtyDoctorClientResponse = specialtiesOfDoctor.Select(s => new SpecialtyDoctorClientResponse()
            {
                Id = s.Id,
                Specialty = _mapper.Map<SpecialtyClientDTO>(s.Specialty),
                UserId = s.UserId,
                Educational = s.Educational,
                Status = s.Status,
                Created_at = s.Created_at,
                Updated_at = s.Updated_at
            });
            return specialtyDoctorClientResponse.ToList();
        }
    }
}
