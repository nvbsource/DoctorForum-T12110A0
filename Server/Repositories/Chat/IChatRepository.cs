using Doctors_Forum_Server.DTOs.Chat;
namespace Doctors_Forum_Server.Repositories.Chat
{
    using Doctors_Forum_Server.Models;
    public interface IChatRepository : IRepository<Chat>
    {
        public List<ChatReceiverDTO> GetRooms(int userId);
        public Chat? FindRoomFromSeederReceiverId(int senderId, int receiverId);
        public List<User?> GetListUsernameWithUsername(string username);
    }
}
