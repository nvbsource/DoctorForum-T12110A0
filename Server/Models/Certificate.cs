using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;

namespace Doctors_Forum_Server.Models
{
	public class Certificate
    {
		[Key]
		[DatabaseGenerated(DatabaseGeneratedOption.Identity)]
		public int Id { get; set; }
		public int SpecialtyDoctorId { get; set; }
		public string? Image { get; set; }
        public DateTime Created_at { get; set; }
        public DateTime Updated_at { get; set; }
        public virtual SpecialtyDoctor? SpecialtyDoctor { get; set; }
        public Certificate()
        {
            Created_at = DateTime.Now;
            Updated_at = DateTime.Now;
        }
    }
}
