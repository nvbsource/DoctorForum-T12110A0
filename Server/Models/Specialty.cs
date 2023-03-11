using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace Doctors_Forum_Server.Models
{
    public class Specialty
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int Id { get; set; }
        public string? Name { get; set; }
        public int? ParentId { get; set; }
        public DateTime Created_at { get; set; }
        public DateTime Updated_at { get; set; }
        public virtual ICollection<Specialty>? SubSpecialties { get; set; }
        public virtual Specialty? ParentSpecialty { get; set; }
        public virtual ICollection<SpecialtyDoctor>? SpecialtyDoctors { get; set; }
        public Specialty()
        {
            Created_at = DateTime.Now;
            Updated_at = DateTime.Now;
        }
    }
}
