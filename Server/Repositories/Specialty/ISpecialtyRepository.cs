
namespace Doctors_Forum_Server.Repositories.Specialty
{
    using Doctors_Forum_Server.DTOs.Specialty;
    using Doctors_Forum_Server.Models;
    public interface ISpecialtyRepository : IRepository<Specialty>
    {
		public List<SpecialtyBaseDTO> GetAllSpecialty();
	}

}
