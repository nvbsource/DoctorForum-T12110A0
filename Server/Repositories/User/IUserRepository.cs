using Doctors_Forum_Server.DTOs.User;

namespace Doctors_Forum_Server.Repositories.User
{
    using Doctors_Forum_Server.Models;
    public interface IUserRepository : IRepository<User>
    {
        public Task<User?> CheckLogin(UserLoginDTO user);
        public Task<bool> CheckUsernameExist(string? username);
        public User? FindByUsername(string? username);
        public UserBaseProfileDTO? FindProfileById(int userId);
        public UserBasePrivateDTO? FindProfileByIdAdmin(int userId);
        public Task<UserResponseCreateDTO?> CreateUser(UserCreateDTO user, string url);
        public string GenerateToken(User user);
        public User? GetUserFromToken(string token);
        public Task<bool> ChangePassword(string username, string newPassword);
        public Task<List<UserFindLocationResponseDTO>> FindDoctorsByAddressAndSpecialty(FindUserDTO data);
        public Task<StatisticsDTO> Statistics();
        public Task<StatisticsAdminDTO> StatisticsAdmin();
        public Task<List<UserBasePrivateDTO>> GetAllUserToAdmin();
    }
}
