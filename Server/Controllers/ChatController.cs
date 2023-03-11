using Microsoft.AspNetCore.Mvc;
using Doctors_Forum_Server.Repositories.Chat;
using Microsoft.AspNetCore.Authorization;
using Doctors_Forum_Server.Models;
using Doctors_Forum_Server.Utilities;
using AutoMapper;
using Doctors_Forum_Server.DTOs.Chat;
using Microsoft.AspNetCore.SignalR;
using Doctors_Forum_Server.Hubs;

namespace Doctors_Forum_Server.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ChatController : ControllerBase
    {
        private IChatRepository _repository;
        private IMapper _mapper;
        private IHubContext<ChatHub> _hubContext;

        public ChatController(IChatRepository repository, IMapper mapper, IHubContext<ChatHub> hubContext)
        {
            _repository = repository;
            _mapper = mapper;
            _hubContext = hubContext;
        }
        [HttpGet]
        [Authorize(Roles = "Member, Admin")]
        public IActionResult GetRooms()
        {
            User? user = HttpContext.Items["User"] as User;
            var response = _repository.GetRooms(user?.Id ?? 0);
            return Ok(Helpers.ResponseApi(new ResponseModel()
            {
                code = Helpers.SUCCESS_CODE,
                message = "Get message successfully",
                result = response
            }));
        }
    }
}
