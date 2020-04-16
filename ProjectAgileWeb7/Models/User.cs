using Microsoft.AspNetCore.Identity;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace ProjectAgileWeb7.Models
{
    public class User : IdentityUser
    {
        [Required]
        public string FirstName { get; set; }
        [Required]
        public string LastName { get; set; }
        public string Address { get; set; }
        public string PostalCode { get; set; }
        public string City { get; set; }
        public string Country { get; set; }
        public bool IsMember { get; set; }
        public IList<Booking> Bookings { get; set; }
        public IList<Hotel> Favorites { get; set; }


        //public IdentityUser IdentityUser { get; set; }
    }
}
