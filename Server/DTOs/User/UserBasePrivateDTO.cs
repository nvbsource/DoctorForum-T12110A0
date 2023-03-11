using Doctors_Forum_Server.DTOs.Post;
using Doctors_Forum_Server.Models;

namespace Doctors_Forum_Server.DTOs.User
{
    public class UserBasePrivateDTO
    {
        public int Id { get; set; }
        public int? PositionId { get; set; }
        public string? FirstName { get; set; }
        public string? LastName { get; set; }
        public string? FullName { get; set; }
        public string? Description { get; set; }
        public string? Gender { get; set; }
        public string? Avatar { get; set; } = "http://localhost:5000/uploads/avatars/default/anonymous-avatar.jpg";
        public LocationEntity? Location { get; set; }
        public int AppointmentEveryDay { get; set; }
        public bool IsDisabledAppointmentEveryDay { get; set; }
        public string? PhoneNumber { get; set; }
        public string? EmailAddress { get; set; }
        public string? OfficeHours { get; set; }
        public string? Website { get; set; }
        public int PatientEvaluateNumber { get; set; }
        public bool IsAnonymouse { get; set; }
        public string? Role { get; set; }
        public bool IsDoctor { get; set; }
        public DateTime Created_at { get; set; }
        public int RemindPatient { get; set; }
        public bool IsDisabledRemindPatient { get; set; }
        public bool IsViewOnline { get; set; }
        public int? NumberSpecialtyChecking { get; set; }
        public ICollection<PostBaseDTO> Posts { get; set; }
        public ICollection<UserAccessLogs> UserAccessLogs { get; set; }
        public DateTime Updated_at { get; set; }
        public DateTime LastLogin_at { get; set; }
    }
}
