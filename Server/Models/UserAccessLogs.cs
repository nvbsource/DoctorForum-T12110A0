namespace Doctors_Forum_Server.Models
{
    public class UserAccessLogs
    {
        public int Id { get; set; }
        public int UserId { get; set; }
        public DateTime AccessTime { get; set; }
        public string IpAddress { get; set; }
        public string DeviceInfo { get; set; }
        public User User { get; set; }
    }
}
