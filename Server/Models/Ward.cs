using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;
namespace Doctors_Forum_Server.Models
{
    public class Ward
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.Identity)]
        public int Id { get; set; }
        public int DistrictId { get; set; }
        public string? Name { get; set; }
        public virtual District? District { get; set; }
    }
}
