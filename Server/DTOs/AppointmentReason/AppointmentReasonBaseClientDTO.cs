﻿namespace Doctors_Forum_Server.DTOs.AppointmentReason
{
    public class AppointmentReasonBaseDTO
    {
        public int Id { get; set; }
        public int UserId { get; set; }
        public string? Name { get; set; }
        public bool Active { get; set; }
        public DateTime Created_at { get; set; }
        public DateTime Updated_at { get; set; }
    }
}
