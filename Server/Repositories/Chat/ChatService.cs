using System;
using Doctors_Forum_Server.Data;
using Doctors_Forum_Server.DTOs.Chat;
namespace Doctors_Forum_Server.Repositories.Chat
{
    using System.Collections.Generic;
    using Doctors_Forum_Server.Models;
    using Microsoft.EntityFrameworkCore;
    using AutoMapper;
    using Doctors_Forum_Server.Hubs;
    using Doctors_Forum_Server.DTOs.ContentChat;
    using Doctors_Forum_Server.DTOs.User;

    public class ChatService : BaseRepository<Chat>, IChatRepository
    {
        private readonly IConfiguration _config;
        private readonly IMapper _mapper;
        public ChatService(ApplicationContext context, IConfiguration config, IMapper mapper) : base(context)
        {
            _config = config;
            _mapper = mapper;
        }

        public List<ChatReceiverDTO> GetRooms(int userId)
        {
            var chatList = this._context.Chats
            .Include(c => c.ReceiverUser)
            .Include(c => c.ContentChats)
            .Where(c => c.UserId.Equals(userId) || c.ReceiverUserId.Equals(userId))
            .OrderByDescending(c => c.ContentChats.OrderByDescending(c => c.Created_at).Take(1).FirstOrDefault().Created_at)
            .Select(c => new ChatReceiverDTO()
            {
                Id = c.Id,
                UserId = c.UserId,
                ReceiverUserId = c.ReceiverUserId,
                ReceiverUser = _mapper.Map<UserBaseProfileDTO>(c.UserId == userId ? c.ReceiverUser : c.User),
                NameChat = (c.UserId.Equals(userId) && !c.ReceiverUserId.Equals(userId)) ? !c.ReceiverUser.IsAnonymouse ? string.Concat(c.ReceiverUser.FirstName, " ", c.ReceiverUser.LastName) : null : !c.User.IsAnonymouse ? string.Concat(c.User.FirstName, " ", c.User.LastName) : null,
                LastChat = _mapper.Map<ContentChatBaseDTO>(c.ContentChats.OrderByDescending(c => c.Created_at).Take(1).FirstOrDefault()),
                Online = false,
                Created_at = c.Created_at,
                Updated_at = c.Updated_at
            })

            .ToList();
            return chatList;
        }
        public Chat? FindRoomFromSeederReceiverId(int senderId, int receiverId)
        {
            var chat = this._context.Chats.SingleOrDefault(c => (c.UserId == senderId && c.ReceiverUserId == receiverId) || (c.ReceiverUserId == senderId && c.UserId == receiverId));
            return chat;
        }
        public List<User?> GetListUsernameWithUsername(string username)
        {
            return this._context.Chats
                    .Where(c => c.User.Username == username || c.ReceiverUser.Username == username)
                    .Select(c => c.User.Username == username
                                ? c.ReceiverUser
                                : c.User)
                    .ToList();
        }
    }
}
