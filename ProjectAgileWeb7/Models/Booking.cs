using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace ProjectAgileWeb7.Models
{
    public enum Status { Accepted, Denied, Pending, Error }
    public class Booking
    {
        public int Id { get; set; }

        public int RoomId { get; set; }
        [ForeignKey("RoomId")]
        public Room Room { get; set; }

        public DateTime CheckIn { get; set; }
        public DateTime CheckOut { get; set; }
        public int PaymentId { get; set; }
        public Payment Payment { get; set; }
        public Status Status { get; set; }
    }
}