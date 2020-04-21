using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;

namespace ProjectAgileWeb7.Models
{
    public class Facility
    {
        public int FacilityId { get; set; }
        public string Name { get; set; }
        public bool IsFree { get; set; }
        [Column(TypeName = "decimal(18,4)")]
        public decimal Price { get; set; }
        public ICollection<HotelFacility> HotelFacilities { get; set; }
    }
}
