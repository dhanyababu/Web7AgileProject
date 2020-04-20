using System.Collections.Generic;

namespace ProjectAgileWeb7.Models
{
    public class Hotel
    {
        public int Id { get; set; }
        public string Name { get; set; }
        public string Website { get; set; }
        public string Address { get; set; }
        public string ZipCode { get; set; }
        public string City { get; set; }
        public string Country { get; set; }
        public string Description { get; set; }
        public int Stars { get; set; }
        public double DistanceFromCenter { get; set; }
        public string Latitude { get; set; }
        public string Longitude { get; set; }
        public string ImageUrl { get; set; }
        public int RatedByGuests { get; set; }

        public IList<Room> Rooms { get; set; }
        public IList<Facility> Facilities { get; set; }

    }
}
