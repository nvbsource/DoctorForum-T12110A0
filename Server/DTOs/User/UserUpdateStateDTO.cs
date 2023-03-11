
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Doctors_Forum_Server.DTOs.User
{
    public class UserUpdateStateDTO
    {
        public bool? IsAnonymouse { get; set; }
        public bool? IsViewOnline { get; set; }
        public int? RemindPatient { get; set; }
        public int? AppointmentEveryDay { get; set; }
        public bool? IsDisabledAppointmentEveryDay { get; set; }
        public bool? IsDisabledRemindPatient { get; set; }
    }
}
