using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;

namespace Doctors_Forum_Server.Models
{
	public class Province
	{
		[Key]
		[DatabaseGenerated(DatabaseGeneratedOption.Identity)]
		public int Id { get; set; }
		public int CountryId { get; set; }
		public string? Name { get; set; }
		public Country? Country { get; set; }
		public ICollection<District>? Districts { get; set; }
	}
}
