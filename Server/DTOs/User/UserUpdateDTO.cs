using System.ComponentModel.DataAnnotations;
using Doctors_Forum_Server.Models;

namespace Doctors_Forum_Server.DTOs.User
{
    public class UserUpdateDTO
    {
        public int? PositionId { get; set; }
        [Required]
        public string? FirstName { get; set; }
        [Required]
        public string? LastName { get; set; }
        public string? Description { get; set; }
        [RegularExpression(@"^(male|female|more)$", ErrorMessage = "Invalid gender value")]
        public string? Gender { get; set; }
        public LocationEntity? Location { get; set; }
        public string? PhoneNumber { get; set; }
        public string? OfficeHours { get; set; }
        public string? Website { get; set; }
        public bool? IsAnonymouse { get; set; }
    }
}
