namespace ProjectAgileWeb7.Models
{
    public class HotelUser
    {
        public int HotelId { get; set; }
        public Hotel Hotel { get; set; }
        public string UserId { get; set; }
        public ApplicationUser ApplicationUser { get; set; }
    }
}
