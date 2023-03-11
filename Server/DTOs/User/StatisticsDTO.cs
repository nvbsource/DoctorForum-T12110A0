using System;
namespace Doctors_Forum_Server.DTOs.User
{
    public class StatisticsDTO
    {
        public int Topics { get; set; }
        public int Posts { get; set; }
        public int Members { get; set; }
        public int NewMembers { get; set; }
    }
}

