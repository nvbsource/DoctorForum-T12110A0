using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;

namespace Doctors_Forum_Server.Models
{
	public class District
	{
		[Key]
		[DatabaseGenerated(DatabaseGeneratedOption.Identity)]
		public int Id { get; set; }
		public int ProvinceId { get; set; }
		public string? Name { get; set; }
		public virtual Province? Province { get; set; }
		public virtual ICollection<Ward>? Wards { get; set; }
	}
}
