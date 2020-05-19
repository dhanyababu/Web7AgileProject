using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace ProjectAgileWeb7.Models
{
    public enum RoomType { Single, Double, Twin, Triple }
    public class Room
    {
        public int RoomId { get; set; }

        [Required]
        public RoomType RoomType { get; set; }

        [Required]
        [Column(TypeName = "decimal(18,4)")]
        public decimal RoomPrice { get; set; }

        [Required]
        public string RoomDescription { get; set; }

        [Required]
        public int NumberOfBeds { get; set; }

        [Required]
        public int Capacity { get; set; } //how many persons
        public string RoomImageUrl { get; set; }

        [Required]
        public int HotelId { get; set; }
        public Hotel Hotel { get; set; }
    }
}
