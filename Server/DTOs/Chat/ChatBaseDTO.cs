using Doctors_Forum_Server.DTOs.User;
namespace Doctors_Forum_Server.DTOs.Chat
{
    public class ChatBaseDTO : UserReceiverDTO
    {
        public int Id { get; set; }
        public int UserId { get; set; }
        public int ReceiverUserId { get; set; }
        public string? NameChat { get; set; }
        public DateTime Created_at { get; set; }
        public DateTime Updated_at { get; set; }
    }
}
