using System;
using System.Collections.Generic;

namespace ProjectAgileWeb7.Models
{
    public enum DistanceEnum
    {
        less1 = 1, less3 = 3, less5 = 5, less10 = 10
    }

    public class HotelsViewModel
    {
        public IEnumerable<Hotel> Hotels { get; set; }
        public string searchKeyword { get; set; }
        public DateTime CheckIn { get; set; }
        public DateTime CheckOut { get; set; }
        public List<string> Facilities { get; set; }
        public List<string> StarsList { get; set; }
        public List<int> DistanceList { get; set; }
    }
}
