using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Text.Json.Serialization;

namespace Doctors_Forum_Server.Models
{
    public class User
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int Id { get; set; }
        public int? PositionId { get; set; }
        public string? Username { get; set; }
        [JsonIgnore]
        public string? Password { get; set; }
        public string? FirstName { get; set; }
        public string? LastName { get; set; }
        public string? Description { get; set; }
        public string? Gender { get; set; }
        public string? Avatar { get; set; }
        public LocationEntity? Location { get; set; }
        public string? PhoneNumber { get; set; }
        public string? EmailAddress { get; set; }
        public double? Latitude { get; set; }
        public double? Longitude { get; set; }
        public string? OfficeHours { get; set; }
        public string? Website { get; set; }
        public int PatientEvaluateNumber { get; set; }
        public int AppointmentEveryDay { get; set; }
        public int RemindPatient { get; set; }
        public bool IsAnonymouse { get; set; }
        public bool IsViewOnline { get; set; }
        public bool IsDisabledAppointmentEveryDay { get; set; }
        public bool IsDisabledRemindPatient { get; set; }
        public string? Role { get; set; }
        public string? IpAddress { get; set; }
        public bool IsVerifyProfile { get; set; }
        public bool? IsDoctor { get; set; }
        public DateTime Created_at { get; set; }
        public DateTime Updated_at { get; set; }
        public DateTime LastLogin_at { get; set; }
        public virtual ICollection<SpecialtyDoctor>? SpecialtyDoctors { get; set; }
        public virtual ICollection<Chat>? Chats { get; set; }
        public virtual ICollection<ContentChat>? ContentChats { get; set; }
        public virtual Position? Position { get; set; }
        public virtual ICollection<Like>? Likes { get; set; }
        public virtual ICollection<Post>? Posts { get; set; }
        public virtual ICollection<Comment>? Comments { get; set; }
        public virtual ICollection<AppointmentReason>? AppointmentReasons { get; set; }
        public virtual ICollection<Appointment>? Appointments { get; set; }
        public virtual ICollection<UserAccessLogs>? UserAccessLogs { get; set; }
        public virtual ICollection<EmailReceivedRequest>? EmailReceivedRequests { get; set; }

        public User()
        {
            Created_at = DateTime.Now;
            Updated_at = DateTime.Now;
            LastLogin_at = DateTime.Now;
            IsAnonymouse = false;
            IsViewOnline = true;
            IsDisabledAppointmentEveryDay = false;
            IsDisabledRemindPatient = false;
            IsVerifyProfile = false;
            Role = "Member";
            RemindPatient = 1;
            AppointmentEveryDay = 7;
        }
    }
    public class LocationEntity
    {
        public string? StreetAddress { get; set; }
        public string? StreetAddress2 { get; set; }
        public string? ZipCode { get; set; }
    }
}
