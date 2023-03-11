namespace Doctors_Forum_Server.DTOs.Appointment
{
    public class AppointmentManageDTO
    {
        public DateTime? StartDate { get; set; }
        public int? NumberAppointment { get; set; }
        public int? NumberPending { get; set; }
        public ICollection<AppointmentBaseDTO>? ListAppointments { get; set; }
    }
}
