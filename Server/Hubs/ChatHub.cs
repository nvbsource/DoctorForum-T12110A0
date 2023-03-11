using AutoMapper;
using Doctors_Forum_Server.DTOs.ContentChat;
using Doctors_Forum_Server.DTOs.Chat;
using Doctors_Forum_Server.Models;
using Doctors_Forum_Server.Repositories.ContentChat;
using Doctors_Forum_Server.Repositories.Chat;
using Doctors_Forum_Server.Repositories.User;
using Microsoft.AspNetCore.SignalR;
using Microsoft.AspNetCore.Authorization;
using Doctors_Forum_Server.DTOs.User;
using static Microsoft.EntityFrameworkCore.DbLoggerCategory.Database;
using Doctors_Forum_Server.Repositories;
using System.Data.Common;

namespace Doctors_Forum_Server.Hubs
{
    [Authorize]
    public class ChatHub : Hub
    {
        private readonly IChatRepository _repository;
        private readonly IContentChatRepository _contentChatRepository;
        private readonly IUserRepository _doctorUserRepository;
        private readonly ConnectionManagement _connections;
        private readonly IMapper _mapper;

        public ChatHub(IChatRepository repository, IContentChatRepository contentChatRepository, IUserRepository doctorUserRepository, IMapper mapper, ConnectionManagement connections)
        {
            _repository = repository;
            _mapper = mapper;
            _doctorUserRepository = doctorUserRepository;
            _contentChatRepository = contentChatRepository;
            _connections = connections;
        }

        public async Task SendMessage(int senderId, int receiverId, string message)
        {
            if (!string.IsNullOrEmpty(message.Trim()))
            {
                var chatRoom = _mapper.Map<ChatBaseDTO>(_repository.FindRoomFromSeederReceiverId(senderId, receiverId));
                var userReceiver = await _doctorUserRepository.FindOne(receiverId);
                if (chatRoom != null && userReceiver != null)
                {
                    var chatNew = new ContentChat()
                    {
                        ChatId = chatRoom.Id,
                        UserId = senderId,
                        Content = message
                    };
                    await _contentChatRepository.Create(chatNew);
                    var mapperChatRoom = _mapper.Map<ContentChatBaseDTO>(chatNew);
                    mapperChatRoom.IsYou = true;
                    await Clients.Caller.SendAsync("newMessage", mapperChatRoom);
                }
            }
        }

        public async Task SendStateOnlineToUser(string username, bool isOnline)
        {
            var doctorUser = _doctorUserRepository.FindByUsername(username);
            var mapperUserBase = _mapper.Map<UserBaseDTO>(doctorUser);
            if (isOnline && doctorUser.IsViewOnline)
            {
                await Clients.All.SendAsync("UserOnline", mapperUserBase);
            }
            else
            {
                await Clients.All.SendAsync("UserOffline", mapperUserBase);
            }
        }
        public async Task GetUserOnline()
        {
            var userBaseDTOs = new List<UserBaseDTO>();
            foreach (var username in _connections.GetAllKeys())
            {
                var user = _doctorUserRepository.FindByUsername(username);
                if (user.IsViewOnline)
                {
                    userBaseDTOs.Add(_mapper.Map<UserBaseDTO>(user));
                }
            }
            await Clients.Caller.SendAsync("UserOnline", userBaseDTOs);
        }

        public override Task OnConnectedAsync()
        {
            try
            {
                string? username = Context?.User?.Identity?.Name;
                _connections.Add(username, Context.ConnectionId);
                SendStateOnlineToUser(username, true);
            }
            catch (Exception ex)
            {
                Clients.Caller.SendAsync("onError", "OnConnected:" + ex.Message);
            }
            return base.OnConnectedAsync();
        }

        public override Task OnDisconnectedAsync(Exception exception)
        {
            try
            {
                var username = Context.User.Identity.Name;
                _connections.Remove(username, Context.ConnectionId);
                SendStateOnlineToUser(username, false);
            }
            catch (Exception ex)
            {
                Clients.Caller.SendAsync("onError", "OnDisconnected: " + ex.Message);
            }

            return base.OnDisconnectedAsync(exception);
        }
    }
}
