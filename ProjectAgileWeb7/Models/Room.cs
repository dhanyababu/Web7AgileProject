using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;

namespace ProjectAgileWeb7.Models
{
    public enum RoomType { Single, Double, Twin, Triple }
    public class Room
    {
        public int RoomId { get; set; }
        public RoomType RoomType { get; set; }
        public int RoomNumber { get; set; }
        [Column(TypeName = "decimal(18,4)")]
        public decimal RoomPrice { get; set; }
        public string RoomDescription { get; set; }
        public int NumberOfBeds { get; set; }
        public int Capacity { get; set; } //how many persons 
        public bool IsAvailable { get; set; }
        public ICollection<HotelRoom> HotelRooms { get; set; }
    }
}
