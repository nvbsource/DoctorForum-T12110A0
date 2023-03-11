
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Doctors_Forum_Server.DTOs.User
{
    public class UserResponseCreateDTO : UserBasePrivateDTO
    {
        public string Token { get; set; }
    }
}
