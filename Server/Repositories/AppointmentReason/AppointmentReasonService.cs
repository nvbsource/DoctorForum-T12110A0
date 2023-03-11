using System;
using Doctors_Forum_Server.Data;

namespace Doctors_Forum_Server.Repositories.AppointmentReason
{
    using AutoMapper;
    using Doctors_Forum_Server.DTOs.AppointmentReason;
    using Doctors_Forum_Server.Models;
    using Doctors_Forum_Server.Repositories.Appointment;
    using System.Collections.Generic;
    using System.Threading.Tasks;

    public class AppointmentReasonService : BaseRepository<AppointmentReason>, IAppointmentReasonRepository
    {
        private readonly IConfiguration _config;
        private readonly IMapper _mapper;
        public AppointmentReasonService(ApplicationContext context, IConfiguration config, IMapper mapper) : base(context)
        {
            _config = config;
            _mapper = mapper;
        }

        public bool FindByName(int userId, string name)
        {
            return this._context.AppointmentReasons.Any(d => d.Name.ToLower().Equals(name.ToLower()) && d.UserId.Equals(userId));
        }

        public List<AppointmentReason> GetAllAppointmentReason(int id)
        {
            return this._context.AppointmentReasons.Where(d => d.UserId.Equals(id)).ToList();
        }

        public List<AppointmentReasonBaseClientDTO> GetAllAppointmentReasonByUser(int userId)
        {
            var appointmentResons = this._context.AppointmentReasons.Where(d => d.UserId.Equals(userId)).Where(u => u.Active == true).ToList();
            return _mapper.Map<List<AppointmentReasonBaseClientDTO>>(appointmentResons);
        }
    }
}
