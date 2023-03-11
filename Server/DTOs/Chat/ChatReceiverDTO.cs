using Doctors_Forum_Server.DTOs.User;
namespace Doctors_Forum_Server.DTOs.Chat
{
    using Doctors_Forum_Server.DTOs.ContentChat;
    using Doctors_Forum_Server.Models;
    public class ChatReceiverDTO : ChatBaseDTO
    {
        public bool Online { get; set; }
        public ContentChatBaseDTO? LastChat { get; set; }
        public virtual UserBaseProfileDTO? ReceiverUser { get; set; }
        public virtual ICollection<ContentChat>? ContentChats { get; set; }
    }
}
