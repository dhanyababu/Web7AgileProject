using System.Collections.Generic;

namespace ProjectAgileWeb7.Models
{
    public class Facility
    {
        public int FacilityId { get; set; }
        public string Name { get; set; }
        public bool IsFree { get; set; }
        public string Symbol { get; set; }
        public ICollection<HotelFacility> HotelFacilities { get; set; }
    }
}
