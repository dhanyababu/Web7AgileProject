using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ProjectAgileWeb7.Models
{
    public class HotelsViewModel
    {
        public IEnumerable<Hotel> Hotels { get; set; }
        public string searchKeyword { get; set; }
        public DateTime CheckIn { get; set; }
        public DateTime CheckOut { get; set; }
    }
}
