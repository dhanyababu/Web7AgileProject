using System;
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
        public Status Status { get; set; }

        public string UserId { get; set; }
        [ForeignKey("UserId")]
        public ApplicationUser User { get; set; }
        public int? PaymentId { get; set; }
        [ForeignKey("PaymentId")]
        public Payment Payment { get; set; }
    }
}
