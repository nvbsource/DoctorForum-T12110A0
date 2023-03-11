using System;
using Doctors_Forum_Server.Data;

namespace Doctors_Forum_Server.Repositories.Appointment
{
    using AutoMapper;
    using Doctors_Forum_Server.DTOs.Appointment;
    using Doctors_Forum_Server.Models;
    using Microsoft.EntityFrameworkCore;
    using System.Collections.Generic;
    using System.Linq;
    using System.Threading.Tasks;

    public class AppointmentService : BaseRepository<Appointment>, IAppointmentRepository
    {
        private readonly IConfiguration _config;
        private readonly IMapper _mapper;
        public AppointmentService(ApplicationContext context, IConfiguration config, IMapper mapper) : base(context)
        {
            _config = config;
            _mapper = mapper;
        }

        public bool CheckAcceptRequestAppointment(User user, DateTime date)
        {
            var appointmentByDate = this._context.Appointments.Where(a => a.UserId == user.Id)
                                                .Where(a => a.StartDate.Date == date.Date).ToList();
            return appointmentByDate.Count() < user.AppointmentEveryDay ? true : false;
        }

        public bool CheckExistsUserRequestInDate(string email, string phone, DateTime date)
        {
            var appointmentByDate = this._context.Appointments.Where(a => a.StartDate.Date == date.Date)
                                                .Any(a => a.Email.ToLower() == email.ToLower() || a.Phone.ToLower() == phone.ToLower());
            return appointmentByDate;
        }

        public List<AppointmentManageDTO> GetAllAppointment(int userId)
        {
            var appointments = this._context.Appointments.Include(a => a.AppointmentReason).Where(d => d.UserId == userId).ToList();
            var intermediateResults = appointments.GroupBy(a => a.StartDate.Date).OrderByDescending(a => a.Key);

            var finalResults = intermediateResults.Where(d => d != null).Select(d => new AppointmentManageDTO()
            {
                StartDate = d.Key,
                NumberAppointment = d.Count(),
                NumberPending = d.Where(d => d.Status == "pending").Count(),
                ListAppointments = _mapper.Map<List<AppointmentBaseDTO>>(d.OrderByDescending(a => a.Created_at).ToList())
            });

            return finalResults.ToList();
        }

    }
}
