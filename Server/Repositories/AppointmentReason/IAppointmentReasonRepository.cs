namespace Doctors_Forum_Server.Repositories.AppointmentReason
{
    using Doctors_Forum_Server.DTOs.AppointmentReason;
    using Doctors_Forum_Server.Models;
    using System.Threading.Tasks;

    public interface IAppointmentReasonRepository : IRepository<AppointmentReason>
    {
        public List<AppointmentReason> GetAllAppointmentReason(int id);
        public List<AppointmentReasonBaseClientDTO> GetAllAppointmentReasonByUser(int userId);
        public bool FindByName(int userId, string name);
    }
}
