namespace ProjectAgileWeb7.Models
{
    public class HotelFacility
    {
        public int HotelId { get; set; }
        public Hotel Hotel { get; set; }
        public int FacilityId { get; set; }
        public Facility Facility { get; set; }
    }
}
