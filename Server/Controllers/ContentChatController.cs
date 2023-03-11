using Microsoft.AspNetCore.Mvc;
using Doctors_Forum_Server.Repositories.ContentChat;
using Doctors_Forum_Server.DTOs.Chat;
using Doctors_Forum_Server.Models;
using Doctors_Forum_Server.Utilities;
using System.Data;
using AutoMapper;
using Doctors_Forum_Server.DTOs.ContentChat;
using System.Collections.Generic;
using Doctors_Forum_Server.Repositories.Chat;
using Microsoft.AspNetCore.SignalR;
using Doctors_Forum_Server.Repositories.User;
using Doctors_Forum_Server.Hubs;
using Microsoft.AspNetCore.Authorization;
using static Microsoft.EntityFrameworkCore.DbLoggerCategory.Database;
using Doctors_Forum_Server.Repositories;

namespace Doctors_Forum_Server.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ContentChatController : ControllerBase
    {
        private IContentChatRepository _repository;
        private IChatRepository _chatRepository;
        private IUserRepository _doctorUserRepository;
        private IMapper _mapper;
        private IHubContext<ChatHub> _hubContext;
        private ConnectionManagement _connections;

        public ContentChatController(IContentChatRepository repository, IChatRepository chatRepository, IUserRepository doctorUserRepository, IMapper mapper, IHubContext<ChatHub> hubContext, ConnectionManagement connections)
        {
            _repository = repository;
            _mapper = mapper;
            _hubContext = hubContext;
            _chatRepository = chatRepository;
            _doctorUserRepository = doctorUserRepository;
            _connections = connections;
        }
        [HttpGet]
        [Authorize(Roles = "Member, Admin")]
        public async Task<IActionResult> GetRooms(int receiverId)
        {
            User? user = HttpContext.Items["User"] as User;
            ContentChatRoomDTO contentChats = await _repository.GetChatsInRoom(user, receiverId);
            return Ok(Helpers.ResponseApi(new ResponseModel()
            {
                code = Helpers.SUCCESS_CODE,
                message = "Get message successfully",
                result = contentChats
            }));
        }
        [HttpPost]
        [Authorize(Roles = "Member, Admin")]
        public async Task<IActionResult> SendMessage(ContentChatCreateDTO data)
        {
            if (ModelState.IsValid)
            {
                User? user = HttpContext.Items["User"] as User;
                Chat? checkRoomChatExist = _chatRepository.FindRoomFromSeederReceiverId(user.Id, data.ReceiverId);
                User? userReceiver = await _doctorUserRepository.FindOne(data.ReceiverId);
                Chat newChat = new Chat()
                {
                    UserId = user.Id,
                    ReceiverUserId = data.ReceiverId
                };
                if (userReceiver == null)
                {
                    return Ok(Helpers.ResponseApi(new ResponseModel()
                    {
                        code = Helpers.NOTFOUND_CODE,
                        message = "Receiver not found",
                    }));
                }
                if (checkRoomChatExist == null)
                {
                    await _chatRepository.Create(newChat);
                }
                ContentChat newContentChat = new ContentChat()
                {
                    ChatId = checkRoomChatExist != null ? checkRoomChatExist.Id : newChat.Id,
                    UserId = user.Id,
                    Content = data.Content
                };
                await _repository.Create(newContentChat);
                var response = _mapper.Map<ContentChatBaseDTO>(newContentChat);
                response.ReceiverId = userReceiver.Id;
                var userSend = _connections.GetConnections(user.Username);
                var receiverConnections = _connections.GetConnections(userReceiver.Username);
                if (checkRoomChatExist == null)
                {
                    await _hubContext.Clients.Clients(receiverConnections).SendAsync("newRoom");
                    await _hubContext.Clients.Clients(userSend).SendAsync("newRoom");
                }
                else
                {
                    response.IsYou = false;
                    await _hubContext.Clients.Clients(receiverConnections).SendAsync("newMessage", response);
                    response.IsYou = true;
                    await _hubContext.Clients.Clients(userSend).SendAsync("newMessage", response);
                }
                return Ok(Helpers.ResponseApi(new ResponseModel()
                {
                    code = Helpers.SUCCESS_CODE,
                    message = "Send message successfully",
                    result = response
                }));
            }
            var errors = ModelState.Where(x => x.Value.Errors.Count > 0).ToDictionary(x => x.Key, x => x.Value.Errors.Select(e => e.ErrorMessage).ToList());
            return BadRequest(Helpers.ResponseApi(new ResponseModel()
            {
                code = Helpers.ERROR_DATA_CODE,
                message = "Input data is incorrect",
                errors = errors
            }));
        }
    }
}
