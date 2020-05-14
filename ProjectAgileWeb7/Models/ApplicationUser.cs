using Microsoft.AspNetCore.Identity;
using System.Collections.Generic;

namespace ProjectAgileWeb7.Models
{
    public class ApplicationUser : IdentityUser
    {

        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string Address { get; set; }
        public string PostalCode { get; set; }
        public string City { get; set; }
        public string Country { get; set; }
        public bool IsMember { get; set; }
        public ICollection<HotelUser> HotelUsers { get; set; }
    }
}
