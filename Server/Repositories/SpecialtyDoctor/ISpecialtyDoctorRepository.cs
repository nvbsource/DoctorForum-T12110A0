namespace Doctors_Forum_Server.Repositories.SpecialtyDoctor
{
    using Doctors_Forum_Server.DTOs.SpecialtyDoctor;
    using Doctors_Forum_Server.Models;
    public interface ISpecialtyDoctorRepository : IRepository<SpecialtyDoctor>
    {
        public Task<List<SpecialtyDoctorClientResponse>> GetAllSpecialtiesOfDoctor(int userId);
    }
}
