using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace ProjectAgileWeb7.Models
{
    public class Hotel
    {
        public int HotelId { get; set; }

        [Required]
        public string Name { get; set; }

        [Required]
        public string Website { get; set; }

        [Required]
        public string Address { get; set; }

        [Required]
        public string ZipCode { get; set; }

        [Required]
        public string City { get; set; }

        [Required]
        public string Country { get; set; }

        [Required]
        public string Description { get; set; }

        [Required]
        public int Stars { get; set; }

        [Required]
        public double DistanceFromCenter { get; set; }

        [Required]
        public string Latitude { get; set; }

        [Required]
        public string Longitude { get; set; }
        public string ImageUrl { get; set; }

        public ICollection<Room> Rooms { get; set; }

        public ICollection<HotelFacility> HotelFacilities { get; set; }

        public ICollection<HotelUser> HotelUsers { get; set; }
    }
}
