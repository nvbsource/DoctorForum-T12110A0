namespace Doctors_Forum_Server.Repositories.Appointment
{
    using Doctors_Forum_Server.DTOs.Appointment;
    using Doctors_Forum_Server.Models;

    public interface IAppointmentRepository : IRepository<Appointment>
    {
        public List<AppointmentManageDTO> GetAllAppointment(int AppointmentServiceId);
        public bool CheckAcceptRequestAppointment(User user, DateTime date);
        public bool CheckExistsUserRequestInDate(string email, string phone, DateTime date);
    }
}
