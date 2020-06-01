using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace ProjectAgileWeb7.Models
{
    public class Hotel
    {
        public int HotelId { get; set; }

        [Required]
        [Display(Name = "Hotel Name")]
        [StringLength(30)]
        public string Name { get; set; }

        [Required]
        [Url]
        public string Website { get; set; }

        [Required]
        public string Address { get; set; }

        [Required]
        [RegularExpression("^[a-zA-Z0-9- ]*$", ErrorMessage = "Only letters, numbers, hyphens (-) and blank spaces allowed.")]
        [Display(Name = "Zip Code")]
        public string ZipCode { get; set; }

        [Required]
        [RegularExpression("^[a-zA-Z0-9- ]*$", ErrorMessage = "Only letters, numbers, hyphens (-) and blank spaces allowed.")]
        public string City { get; set; }

        [Required]
        [RegularExpression("^[a-zA-Z- ]*$", ErrorMessage = "Only lettersm hyphens (-) and blank spaces allowed.")]
        public string Country { get; set; }

        [Required]
        [StringLength(255)]
        [Display(Name = "Description (max 255 characters)")]
        public string Description { get; set; }

        [Required]
        [Range(1, 5)]
        public int Stars { get; set; }

        [Required]
        [Range(0, double.MaxValue)]
        [Display(Name = "Distance from Center")]
        public double DistanceFromCenter { get; set; }

        [Required]
        [Range(typeof(decimal), "-90", "90")]
        public string Latitude { get; set; }

        [Required]
        [Range(typeof(decimal), "-180", "180")]
        public string Longitude { get; set; }

        public string ImageUrl { get; set; }

        public ICollection<Room> Rooms { get; set; }

        public ICollection<HotelFacility> HotelFacilities { get; set; }

        public ICollection<HotelUser> HotelUsers { get; set; }
    }
}
