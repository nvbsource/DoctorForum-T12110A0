using Doctors_Forum_Server.DTOs.User;
using Microsoft.AspNetCore.Mvc;
using Doctors_Forum_Server.Repositories.User;
using Doctors_Forum_Server.Utilities;
using AutoMapper;
using Doctors_Forum_Server.Repositories.UserAccessLogs;
using Microsoft.AspNetCore.Authorization;
using Doctors_Forum_Server.Models;

namespace Doctors_Forum_Server.Controllers.Admin
{
    [Route("api/admin/[controller]")]
    [ApiController]
    public class UserController : ControllerBase
    {
        private readonly IUserRepository _repository;
        private readonly IUserAccessLogsRepository _userAccessLogsRepository;
        private readonly IMapper _mapper;

        public UserController(IUserRepository repository, IMapper mapper, IUserAccessLogsRepository userAccessLogsRepository)
        {
            _repository = repository;
            _mapper = mapper;
            _userAccessLogsRepository = userAccessLogsRepository;
        }

        [HttpGet("statistics")]
        public async Task<IActionResult> Statistics()
        {
            return Ok(Helpers.ResponseApi(new ResponseModel()
            {
                code = Helpers.SUCCESS_CODE,
                message = "Get statistics successfully",
                result = await _repository.StatisticsAdmin()
            }));
        }

        [HttpPost("login")]
        public async Task<IActionResult> Login([FromBody] UserLoginDTO user)
        {
            var userExist = await _repository.CheckLogin(user);
            if (userExist == null || userExist?.Role != "Admin")
            {
                return Unauthorized(Helpers.ResponseApi(new ResponseModel()
                {
                    code = Helpers.UNAUTHORIZED_CODE,
                    message = "Incorrect account or password!",
                }));
            }

            userExist.LastLogin_at = DateTime.Now;
            await _repository.Update(userExist);
            // Access logs
            var ipAddress = HttpContext.Connection.RemoteIpAddress.ToString();
            var userAgent = HttpContext.Request.Headers["User-Agent"].ToString();
            await _userAccessLogsRepository.CreateAsync(userExist.Id, ipAddress, userAgent);

            string token = _repository.GenerateToken(userExist);
            var response = new
            {
                token,
                user = _mapper.Map<UserBasePrivateDTO>(userExist)
            };
            return Ok(Helpers.ResponseApi(new ResponseModel()
            {
                code = Helpers.SUCCESS_CODE,
                message = "Login successfully",
                result = response
            }));
        }
        [HttpGet]
        [Authorize(Roles = "Admin")]
        public async Task<IActionResult> GetAll()
        {
            var users = await _repository.GetAllUserToAdmin();
            var response = _mapper.Map<List<UserBasePrivateDTO>>(users);
            return Ok(Helpers.ResponseApi(new ResponseModel()
            {
                code = Helpers.SUCCESS_CODE,
                message = "Get successfully",
                result = response
            }));
        }
        [HttpGet("profile/{id}")]
        public async Task<IActionResult> Profile(int id)
        {
            UserBasePrivateDTO? user = _repository.FindProfileByIdAdmin(id);
            if (user == null)
            {
                return Ok(Helpers.ResponseApi(new ResponseModel()
                {
                    code = Helpers.NOTFOUND_CODE,
                    message = "The user does not exist in the system",
                }));
            }

            return Ok(Helpers.ResponseApi(new ResponseModel()
            {
                code = Helpers.SUCCESS_CODE,
                message = "Get profile successfully",
                result = user
            }));
        }
    }
}
