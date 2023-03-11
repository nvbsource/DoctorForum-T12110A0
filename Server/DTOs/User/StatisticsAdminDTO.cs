using System;
namespace Doctors_Forum_Server.DTOs.User
{
    public class StatisticsAdminDTO
    {
        public int Topics { get; set; }
        public int Posts { get; set; }
        public int Users { get; set; }
        public int Appointments { get; set; }

        public int TopicsToday { get; set; }
        public int PostsToday { get; set; }
        public int UsersToday { get; set; }
        public int AppointmentsToday { get; set; }
    }
}

