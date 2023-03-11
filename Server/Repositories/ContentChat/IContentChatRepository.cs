namespace Doctors_Forum_Server.Repositories.ContentChat
{
    using Doctors_Forum_Server.DTOs.ContentChat;
    using Doctors_Forum_Server.Models;
    public interface IContentChatRepository : IRepository<ContentChat>
    {
        public Task<ContentChatRoomDTO> GetChatsInRoom(User? user, int receiverId);
    }
}
