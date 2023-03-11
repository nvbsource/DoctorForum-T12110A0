using Microsoft.Extensions.Hosting;

namespace Doctors_Forum_Server.DTOs.User
{
    using Doctors_Forum_Server.DTOs.AppointmentReason;
    using Doctors_Forum_Server.DTOs.Post;
    using Doctors_Forum_Server.DTOs.SpecialtyDoctor;
    using Doctors_Forum_Server.Models;

    public class UserBaseProfileDTO : UserBaseDTO
    {
        public ICollection<PostBaseDTO> Posts { get; set; }
        public virtual ICollection<AppointmentReasonBaseDTO>? AppointmentReasons { get; set; }
        public virtual ICollection<SpecialtyDoctorBaseDTO>? SpecialtyDoctors { get; set; }
        public DateTime Updated_at { get; set; }
        public DateTime LastLogin_at { get; set; }
    }
}
