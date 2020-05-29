using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace ProjectAgileWeb7.Models
{
    public enum RoomType { Single, Double, Twin, Triple }
    public class Room
    {
        public int RoomId { get; set; }

        [Required]
        [Display(Name = "Room Type")]
        public RoomType RoomType { get; set; }

        [Required]
        [Column(TypeName = "decimal(18,4)")]
        [Range(0, double.PositiveInfinity)]
        [Display(Name = "Room Price")]
        public decimal RoomPrice { get; set; }

        [Required]
        [StringLength(255)]
        [Display(Name = "Room Description (max 255 characters)")]
        public string RoomDescription { get; set; }

        [Required]
        [Display(Name = "Number of Beds")]
        [Range(1, 5)]
        public int NumberOfBeds { get; set; }

        [Required]
        [Range(1, 7)]
        public int Capacity { get; set; } //how many persons
        public string RoomImageUrl { get; set; }

        [Required]
        public int HotelId { get; set; }
        public Hotel Hotel { get; set; }
    }
}
