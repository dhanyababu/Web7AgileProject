using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ProjectAgileWeb7.Models
{
    public class BookingConfirmationViewModel
    {
        public ApplicationUser User { get; set; }
        public Booking Booking { get; set; }
        public Payment Payment { get; set; }
        public Hotel Hotel { get; set; }
        public Room Room { get; set; }
    }
}
