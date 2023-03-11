using System;
using Doctors_Forum_Server.Data;
using System.Drawing;

namespace Doctors_Forum_Server.Repositories.User
{
    using System.Collections.Generic;
    using System.Drawing;
    using System.Drawing.Drawing2D;
    using System.Drawing.Imaging;
    using System.Drawing.Text;
    using System.IdentityModel.Tokens.Jwt;
    using System.Security.Claims;
    using System.Text;
    using System.Threading.Tasks;
    using AutoMapper;
    using Doctors_Forum_Server.DTOs.User;
    using Doctors_Forum_Server.Models;
    using Doctors_Forum_Server.Repositories.GeoLocation;
    using Doctors_Forum_Server.Repositories.Post;
    using Doctors_Forum_Server.Repositories.Topic;
    using Doctors_Forum_Server.Repositories.UserAccessLogs;
    using Doctors_Forum_Server.Utilities;
    using Microsoft.AspNetCore.Mvc;
    using Microsoft.EntityFrameworkCore;
    using Microsoft.Extensions.Hosting;
    using Microsoft.IdentityModel.Tokens;
    using SkiaSharp;

    public class UserService : BaseRepository<User>, IUserRepository
    {
        private readonly IConfiguration _config;
        private readonly IMapper _mapper;
        private readonly ILogger<UserAccessLogsService> _logger;
        private readonly AESEncryption _encryption;
        private readonly IUserAccessLogsRepository _userAccessLogsRepository;
        private readonly IGeoLocationService _geoLocation;
        private List<string> _BackgroundColours = new List<string> { "339966", "3366CC", "CC33FF", "FF5050" };

        public UserService(ApplicationContext context, IConfiguration config, IMapper mapper, ILogger<UserAccessLogsService> logger, IUserAccessLogsRepository userAccessLogsRepository, IGeoLocationService geoLocation) : base(context)
        {
            _config = config;
            _mapper = mapper;
            _logger = logger;
            _encryption = new AESEncryption(_config["AESEncryption:SecretKey"], _config["AESEncryption:Salt"]);
            _userAccessLogsRepository = userAccessLogsRepository;
            _geoLocation = geoLocation;
        }

        public async Task<bool> ChangePassword(string username, string newPassword)
        {
            User? user = FindByUsername(username);
            if (user != null)
            {
                string encryptedPassword = _encryption.Encrypt(newPassword);
                user.Password = encryptedPassword;
                await this.Update(user);
                return true;
            }
            return false;
        }

        public async Task<User?> CheckLogin(UserLoginDTO user)
        {
            var doctorUser = await this._context.Users
                .Where(u => u.Username == user.Username)
                .Include(d => d.UserAccessLogs.OrderByDescending(u => u.AccessTime))
                .FirstOrDefaultAsync(d => d.Username.ToLower().Equals(user.Username.ToLower()));
            if (doctorUser == null)
            {
                return null;
            }

            string decryptedPassword = _encryption.Decrypt(doctorUser.Password);

            return decryptedPassword.Equals(user.Password) ? doctorUser : null;
        }

        public async Task<bool> CheckUsernameExist(string? username)
        {
            if (username == null) return false;
            return await this._context.Users.AnyAsync(d => d.Username.ToLower().Equals(username.ToLower()));
        }

        public async Task<List<UserBasePrivateDTO>> GetAllUserToAdmin()
        {
            var users = this._context.Users.Include(u => u.SpecialtyDoctors);
            var list = new List<UserBasePrivateDTO>();
            foreach (var user in users)
            {
                var userMapper = _mapper.Map<UserBasePrivateDTO>(user);
                userMapper.NumberSpecialtyChecking = user.SpecialtyDoctors.Count(s => s.Status == "checking");
                list.Add(userMapper);
            }
            return list;
        }


        public async Task<UserResponseCreateDTO?> CreateUser(UserCreateDTO user, string url)
        {
            try
            {
                if (user.Username == null || user.Password == null) return null;

                user.Username = user.Username.ToLower();
                user.Password = _encryption.Encrypt(user.Password);
                var userMapper = _mapper.Map<User>(user);
                var pathAvatarDefault = GenerateCircle(userMapper.FirstName, userMapper.LastName);
                userMapper.Avatar = url + pathAvatarDefault;
                var newUser = _mapper.Map<UserResponseCreateDTO>(await this.Create(userMapper));
                newUser.Token = this.GenerateToken(userMapper);
                return newUser;
            }
            catch (DbUpdateException ex)
            {
                _logger.LogError(ex, "System error");
                return null;
            }

        }
        public string GenerateCircle(string firstName, string lastName)
        {
            var avatarString = string.Format("{0}{1}", firstName[0], lastName[0]).ToUpper();

            var randomIndex = new Random().Next(0, _BackgroundColours.Count - 1);
            var bgColour = _BackgroundColours[randomIndex];

            using var surface = SKSurface.Create(new SKImageInfo(192, 192));
            var canvas = surface.Canvas;
            canvas.Clear(SKColors.Transparent);

            using var bgPaint = new SKPaint
            {
                Color = SKColor.Parse("#" + bgColour),
                IsAntialias = true
            };
            canvas.DrawCircle(96, 96, 96, bgPaint);

            using var textPaint = new SKPaint
            {
                Color = SKColors.White,
                IsAntialias = true,
                TextAlign = SKTextAlign.Center,
                TextSize = 72
            };
            canvas.DrawText(avatarString, 96, 116, textPaint);

            // Save the image to the "uploads" folder in the application
            var fileName = $"{Guid.NewGuid()}.png";
            var filePath = Path.Combine("uploads/avatars", fileName);
            using var image = surface.Snapshot();
            using var data = image.Encode(SKEncodedImageFormat.Png, 100);
            using var stream = new FileStream(filePath, FileMode.Create);
            data.SaveTo(stream);

            // Return the file name
            return "/uploads/avatars/" + fileName;
        }



        public User? FindByUsername(string? username)
        {
            if (username == null) return null;
            return this._context.Users.Include(d => d.UserAccessLogs.OrderByDescending(u => u.AccessTime)).SingleOrDefault(d => d.Username != null && d.Username.Equals(username.ToLower()));
        }

        public async Task<List<UserFindLocationResponseDTO>> FindDoctorsByAddressAndSpecialty(FindUserDTO data)
        {
            var usersFilter = this._context.Users.Include(u => u.SpecialtyDoctors)
                            .Where(u => u.SpecialtyDoctors.Any(s => s.Status == "active"))
                            .Where(u => !string.IsNullOrEmpty(u.Location.StreetAddress));
            var users = data.SpecialtyId != null
                            ? usersFilter
                                .Where(u => u.SpecialtyDoctors.Any(s => s.SpecialtyId == data.SpecialtyId))
                            : usersFilter;
            var listUser = new List<UserFindLocationResponseDTO>();
            if (users.Count() != 0)
            {
                var location = data.Address != null ? _geoLocation.GetLatLongFromAddress(data.Address) : null;
                foreach (var user in users)
                {
                    var userMapper = _mapper.Map<UserFindLocationResponseDTO>(user);
                    if (user.Latitude != null && user.Longitude != null && location != null)
                    {
                        var distance = _geoLocation.Distance(location.Latitude, location.Longitude, user.Latitude ?? 0, user.Longitude ?? 0);
                        userMapper.Distance = distance;
                    }
                    listUser.Add(userMapper);
                }
                return listUser.OrderBy(u => u.Distance ?? 0).ToList();
            }
            return new List<UserFindLocationResponseDTO>();
        }

        public UserBaseProfileDTO? FindProfileById(int userId)
        {
            var user = this._context.Users.Where(u => u.Id == userId)
                .Include(u => u.Posts)
                .ThenInclude(u => u.Topic)
                .Include(u => u.AppointmentReasons)
                .Include(u => u.SpecialtyDoctors)
                    .ThenInclude(u => u.Specialty)
                .SingleOrDefault();
            return _mapper.Map<UserBaseProfileDTO>(user);
        }

        public UserBasePrivateDTO? FindProfileByIdAdmin(int userId)
        {
            var user = this._context.Users.Where(u => u.Id == userId)
                .Include(u => u.Posts)
                .ThenInclude(u => u.Topic)
                .Include(u => u.AppointmentReasons)
                .Include(u => u.SpecialtyDoctors)
                    .ThenInclude(u => u.Specialty)
                .SingleOrDefault();
            return _mapper.Map<UserBasePrivateDTO>(user);
        }

        public string GenerateToken(User user)
        {
            var tokenHandler = new JwtSecurityTokenHandler();
            var key = Encoding.ASCII.GetBytes(_config["Jwt:Key"]);
            var tokenDescriptor = new SecurityTokenDescriptor
            {
                Audience = _config["Jwt:Audience"],
                Issuer = _config["Jwt:Issuer"],
                Subject = new ClaimsIdentity(new Claim[]
                {
                    new Claim(ClaimTypes.Name, user.Username),
                    new Claim(ClaimTypes.Role, user.Role)
                }),
                Expires = DateTime.Now.AddDays(1),
                SigningCredentials = new SigningCredentials(new SymmetricSecurityKey(key), SecurityAlgorithms.HmacSha256Signature)
            };
            var token = tokenHandler.CreateToken(tokenDescriptor);
            return tokenHandler.WriteToken(token);
        }
        public User? GetUserFromToken(string token)
        {
            try
            {
                var tokenHandler = new JwtSecurityTokenHandler();
                var key = Encoding.UTF8.GetBytes(_config["Jwt:Key"]);
                var tokenValidationParameters = new TokenValidationParameters
                {
                    ValidateIssuerSigningKey = true,
                    IssuerSigningKey = new SymmetricSecurityKey(key),
                    ValidateIssuer = true,
                    ValidIssuer = _config["Jwt:Issuer"],
                    ValidateAudience = true,
                    ValidAudience = _config["Jwt:Audience"],
                    ValidateLifetime = true,
                    ClockSkew = TimeSpan.Zero
                };
                SecurityToken securityToken;
                var principal = tokenHandler.ValidateToken(token, tokenValidationParameters, out securityToken);
                var jwtSecurityToken = securityToken as JwtSecurityToken;
                if (jwtSecurityToken == null || !jwtSecurityToken.Header.Alg.Equals(SecurityAlgorithms.HmacSha256, StringComparison.InvariantCultureIgnoreCase))
                {
                    return null;
                }
                var username = principal.FindFirst(ClaimTypes.Name)?.Value;
                var role = principal.FindFirst(ClaimTypes.Role)?.Value;
                return this.FindByUsername(username);
            }
            catch
            {
                return null;
            }
        }

        public async Task<StatisticsDTO> Statistics()
        {
            return new StatisticsDTO()
            {
                Topics = await this._context.Topics.Where(t => t.ParentId != null).CountAsync(),
                Posts = await this._context.Posts.CountAsync(),
                Members = await this._context.Users.CountAsync(),
                NewMembers = await this._context.Users.Where(u => u.Created_at.Date == DateTime.Today.Date).CountAsync()
            };
        }
        public async Task<StatisticsAdminDTO> StatisticsAdmin()
        {
            return new StatisticsAdminDTO()
            {
                Topics = await this._context.Topics.Where(t => t.ParentId != null).CountAsync(),
                Posts = await this._context.Posts.CountAsync(),
                Users = await this._context.Users.CountAsync(),
                Appointments = await this._context.Appointments.CountAsync(),

                TopicsToday = await this._context.Topics.Where(u => u.Created_at.Date == DateTime.Today.Date).CountAsync(),
                PostsToday = await this._context.Posts.Where(u => u.Created_at.Date == DateTime.Today.Date).CountAsync(),
                UsersToday = await this._context.Users.Where(u => u.Created_at.Date == DateTime.Today.Date).CountAsync(),
                AppointmentsToday = await this._context.Appointments.Where(u => u.Created_at.Date == DateTime.Today.Date).CountAsync(),
            };
        }
    }
}
