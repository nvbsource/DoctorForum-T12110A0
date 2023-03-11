using Doctors_Forum_Server.Models;

namespace Doctors_Forum_Server.DTOs.User
{
    public class UserFindLocationResponseDTO : UserBaseDTO
    {
        public double? Distance { get; set; }
    }
}
