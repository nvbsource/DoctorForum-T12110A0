using Doctors_Forum_Server.DTOs.User;
using Microsoft.AspNetCore.Mvc;
using Doctors_Forum_Server.Repositories.User;
using Doctors_Forum_Server.Repositories.Position;
using Doctors_Forum_Server.Utilities;
using AutoMapper;
using Microsoft.AspNetCore.Authorization;
using Doctors_Forum_Server.Models;
using Doctors_Forum_Server.Repositories.UserAccessLogs;
using System.Reflection.Emit;
using Newtonsoft.Json;
using Doctors_Forum_Server.Repositories.GeoLocation;

namespace Doctors_Forum_Server.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class UserController : ControllerBase
    {
        private readonly IConfiguration _config;
        private readonly IUserRepository _repository;
        private readonly IUserAccessLogsRepository _userAccessLogsRepository;
        private readonly IPositionRepository _positionRepository;
        private readonly IMapper _mapper;
        private readonly ILogger<UserController> _logger;
        private readonly IGeoLocationService _geoLocation;

        public UserController(IConfiguration config, IUserRepository repository, ILogger<UserController> logger, IMapper mapper, IPositionRepository positionRepository, IUserAccessLogsRepository userAccessLogsRepository, IGeoLocationService geoLocation)
        {
            _config = config;
            _repository = repository;
            _mapper = mapper;
            _logger = logger;
            _positionRepository = positionRepository;
            _userAccessLogsRepository = userAccessLogsRepository;
            _geoLocation = geoLocation;
        }
        [HttpPost("change-avatar")]
        [Authorize(Roles = "Member, Admin")]
        public async Task<ActionResult<string>> ChangeAvatar([FromForm] AvatarUserDTO model)
        {
            try
            {
                User? user = HttpContext.Items["User"] as User;
                // Lưu trữ tệp lên máy chủ
                string avatarFileName = $"{Guid.NewGuid()}{Path.GetExtension(model.Avatar.FileName)}";
                string avatarFilePath = Path.Combine("uploads", "avatars", avatarFileName);
                using (var stream = new FileStream(avatarFilePath, FileMode.Create))
                {
                    await model.Avatar.CopyToAsync(stream);
                }
                var baseUrl = $"{HttpContext.Request.Scheme}://{HttpContext.Request.Host}";
                user.Avatar = $"{baseUrl}/{avatarFilePath}";
                _repository.Update(user);
                // Trả về đường dẫn tệp mới
                return Ok(Helpers.ResponseApi(new ResponseModel()
                {
                    code = Helpers.SUCCESS_CODE,
                    message = "Update avatar successfully",
                    result = user.Avatar
                }));
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Failed to change avatar.");
                return StatusCode(StatusCodes.Status500InternalServerError);
            }
        }
        [HttpPost("email")]
        public async Task<ActionResult> TestEmail()
        {
            await new Helpers().SendEmailAsync("nvbluutru@gmail.com", "123", "123");
            return Ok("Send email success");
        }
        [HttpPost("update-state")]
        [Authorize(Roles = "Member, Admin")]
        public async Task<IActionResult> UpdateState([FromBody] UserUpdateStateDTO data)
        {
            if (ModelState.IsValid)
            {
                User? user = HttpContext.Items["User"] as User;
                _mapper.Map(data, user);
                await _repository.Update(user);
                return Ok(Helpers.ResponseApi(new ResponseModel()
                {
                    code = Helpers.SUCCESS_CODE,
                    message = "Update successfully"
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
        [HttpPost("login")]
        public async Task<IActionResult> Login([FromBody] UserLoginDTO user)
        {
            var userExist = await _repository.CheckLogin(user);
            if (userExist == null)
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
        [HttpPost("changePassword")]
        [Authorize(Roles = "Member, Admin")]
        public async Task<IActionResult> ChangePass([FromBody] UserChangePassDTO data)
        {
            User? user = HttpContext.Items["User"] as User;
            User? checkUser = await _repository.CheckLogin(new UserLoginDTO() { Username = user.Username, Password = data.PasswordOld });
            if (checkUser == null)
            {
                ModelState.AddModelError("PasswordOld", "Old password is incorrect");
            }
            if (data.PasswordNew != data.ConfirmPasswordNew)
            {
                ModelState.AddModelError("ConfirmPasswordNew", "Confirm the password must match the new password");
            }
            if (ModelState.IsValid)
            {
                bool stateChangePass = await _repository.ChangePassword(user.Username, data.PasswordNew);
                if (stateChangePass)
                {
                    return Ok(Helpers.ResponseApi(new ResponseModel()
                    {
                        code = Helpers.SUCCESS_CODE,
                        message = "Change password successfully",
                    }));
                }
            }
            var errors = ModelState.Where(x => x.Value.Errors.Count > 0).ToDictionary(x => x.Key, x => x.Value.Errors.Select(e => e.ErrorMessage).ToList());
            return BadRequest(Helpers.ResponseApi(new ResponseModel()
            {
                code = Helpers.ERROR_DATA_CODE,
                message = "Input data is incorrect",
                errors = errors
            }));
        }
        [HttpPost("create")]
        public async Task<IActionResult> Create([FromBody] UserCreateDTO user)
        {
            bool checkUsername = await _repository.CheckUsernameExist(user.Username);
            if (checkUsername)
            {
                ModelState.AddModelError("Username", "Username already exists");
            }
            if (ModelState.IsValid)
            {
                var userResponse = await _repository.CreateUser(user, $"{HttpContext.Request.Scheme}://{HttpContext.Request.Host}");
                if (userResponse != null)
                {
                    return Ok(Helpers.ResponseApi(new ResponseModel()
                    {
                        code = Helpers.SUCCESS_CODE,
                        message = "Create successfully",
                        result = userResponse
                    }));
                }
            }

            var errors = ModelState.Where(x => x.Value.Errors.Count > 0).ToDictionary(x => x.Key, x => x.Value.Errors.Select(e => e.ErrorMessage).ToList());
            return BadRequest(Helpers.ResponseApi(new ResponseModel()
            {
                code = Helpers.ERROR_DATA_CODE,
                message = "Input data is incorrect",
                errors = errors
            }));
        }
        [HttpPut("update")]
        [Authorize(Roles = "Member, Admin")]
        public async Task<IActionResult> Update([FromBody] UserUpdateDTO updateUser)
        {
            User? user = HttpContext.Items["User"] as User;
            if (updateUser.PositionId != null)
            {
                var position = await _positionRepository.FindOne(updateUser.PositionId ?? 0);
                if (position == null)
                {
                    return Ok(Helpers.ResponseApi(new ResponseModel()
                    {
                        code = Helpers.NOTFOUND_CODE,
                        message = "The position does not exist in the system",
                    }));
                }
            }
            if (ModelState.IsValid)
            {
                if (user.IsDoctor == true)
                {
                    var address = updateUser?.Location?.StreetAddress;
                    var location = address != user.Location?.StreetAddress ? _geoLocation.GetLatLongFromAddress(address) : null;
                    if (location != null)
                    {
                        user.Longitude = location.Longitude;
                        user.Latitude = location.Latitude;
                    }
                }
                user = _mapper.Map(updateUser, user);
                user.Updated_at = DateTime.Now;
                await _repository.Update(user);

                var response = _mapper.Map<UserBasePrivateDTO>(user);
                return Ok(Helpers.ResponseApi(new ResponseModel()
                {
                    code = Helpers.SUCCESS_CODE,
                    message = "Update successfully",
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
        [HttpGet("profile/{id}")]
        public async Task<IActionResult> Profile(int id)
        {
            UserBaseProfileDTO? user = _repository.FindProfileById(id);
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
        [HttpPost("findDoctor")]
        public async Task<IActionResult> FindDoctor([FromBody] FindUserDTO data)
        {
            var users = await _repository.FindDoctorsByAddressAndSpecialty(data);

            return Ok(Helpers.ResponseApi(new ResponseModel()
            {
                code = Helpers.SUCCESS_CODE,
                message = "Get doctor successfully",
                result = users
            }));
        }
        [HttpGet("statistics")]
        public async Task<IActionResult> Statistics()
        {
            return Ok(Helpers.ResponseApi(new ResponseModel()
            {
                code = Helpers.SUCCESS_CODE,
                message = "Get statistics successfully",
                result = await _repository.Statistics()
            }));
        }
        [HttpGet("profile")]
        [Authorize(Roles = "Member, Admin")]
        public IActionResult ProfileLogin()
        {
            User? user = HttpContext.Items["User"] as User;

            var response = _mapper.Map<UserBasePrivateDTO>(user);

            return Ok(Helpers.ResponseApi(new ResponseModel()
            {
                code = Helpers.SUCCESS_CODE,
                message = "Get profile successfully",
                result = response
            }));
        }

    }
}
