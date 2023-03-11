using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using static GoogleMaps.LocationServices.Directions;

namespace Doctors_Forum_Server.Models
{
    public class SpecialtyDoctor
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int Id { get; set; }
        public int SpecialtyId { get; set; }
        public int UserId { get; set; }
        public string? Educational { get; set; }
        public string Status { get; set; }
        public DateTime Created_at { get; set; }
        public DateTime Updated_at { get; set; }
        public virtual ICollection<Certificate>? Certificates { get; set; }
        public virtual Specialty? Specialty { get; set; }
        public virtual User? User { get; set; }

        public SpecialtyDoctor()
        {
            Status = "pending";
            Created_at = DateTime.Now;
            Updated_at = DateTime.Now;
        }
    }
}
