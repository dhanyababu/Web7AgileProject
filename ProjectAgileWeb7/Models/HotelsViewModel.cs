using System;
using System.Collections.Generic;

namespace ProjectAgileWeb7.Models
{
    public class HotelsViewModel
    {
        public IEnumerable<Hotel> Hotels { get; set; }
        public string searchKeyword { get; set; }
        public DateTime CheckIn { get; set; }
        public DateTime CheckOut { get; set; }
        public List<string> Facilities { get; set; }
        public List<string> GGG { get; set; }
    }
}
