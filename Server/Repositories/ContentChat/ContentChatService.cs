using System;
using Doctors_Forum_Server.Data;

namespace Doctors_Forum_Server.Repositories.ContentChat
{
    using System.Collections.Generic;
    using AutoMapper;
    using Doctors_Forum_Server.DTOs.ContentChat;
    using Doctors_Forum_Server.DTOs.User;
    using Doctors_Forum_Server.Models;
    using Doctors_Forum_Server.Repositories.Chat;
    using Doctors_Forum_Server.Repositories.User;

    public class ContentChatService : BaseRepository<ContentChat>, IContentChatRepository
    {
        private readonly IConfiguration _config;
        private readonly IMapper _mapper;
        private readonly IChatRepository _chatRepository;
        private readonly IUserRepository _userRepository;
        public ContentChatService(ApplicationContext context, IConfiguration config, IMapper mapper, IChatRepository chatRepository, IUserRepository userRepository) : base(context)
        {
            _config = config;
            _mapper = mapper;
            _chatRepository = chatRepository;
            _userRepository = userRepository;
        }

        public async Task<ContentChatRoomDTO> GetChatsInRoom(User? user, int receiverId)
        {
            Chat? chatRoom = _chatRepository.FindRoomFromSeederReceiverId(user.Id, receiverId);
            var infoReceiver = _mapper.Map<UserBaseProfileDTO>(await _userRepository.FindOne(receiverId));
            if (chatRoom != null)
            {
                var infoChat = new ContentChatRoomDTO();
                var contentChats = _mapper.Map<List<ContentChatBaseDTO>>(this._context.ContentChats.ToList())
                    .Where(c =>
                    {
                        c.IsYou = c.UserId == user.Id;
                        return c.ChatId.Equals(chatRoom.Id);
                    }).TakeLast(100).OrderBy(c => c.Created_at).ToList();
                infoChat.ContentChats = contentChats;
                infoChat.UserReceiver = infoReceiver;
                return infoChat;
            }
            return new ContentChatRoomDTO()
            {
                UserReceiver = infoReceiver
            };
        }
    }
}
