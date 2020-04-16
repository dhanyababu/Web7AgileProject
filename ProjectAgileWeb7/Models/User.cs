using Microsoft.AspNetCore.Identity;
using System.Collections.Generic;

namespace ProjectAgileWeb7.Models
{
    public class User : IdentityUser
    {
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string Address { get; set; }
        public string ZipCode { get; set; }
        public string City { get; set; }
        public string Country { get; set; }
        public bool IsMember { get; set; }
        public IList<Booking> Bookings { get; set; }
        public IList<Hotel> Favorites { get; set; }

    }
}
