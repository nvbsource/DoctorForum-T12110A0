
namespace Doctors_Forum_Server.DTOs.ContentChat
{
    using Doctors_Forum_Server.DTOs.User;
    using Doctors_Forum_Server.Models;
    public class ContentChatRoomDTO
    {
        public ICollection<ContentChatBaseDTO> ContentChats { get; set; }
        public UserBaseProfileDTO UserReceiver { get; set; }
    }
}
