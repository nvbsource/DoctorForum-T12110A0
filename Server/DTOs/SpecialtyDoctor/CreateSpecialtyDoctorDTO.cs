using System.ComponentModel.DataAnnotations;

namespace Doctors_Forum_Server.DTOs.SpecialtyDoctor
{
	public class CreateSpecialtyDoctorDTO
	{
		[Required]
		public int SpecialtyId { get; set; }
		[Required]
		public string? Educational { get; set; }
	}
}
