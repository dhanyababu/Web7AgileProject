using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace ProjectAgileWeb7.Models
{
    public enum DistanceEnum
    {
        less1 = 1, less3 = 3, less5 = 5, less10 = 10
    }

    public class HotelsViewModel
    {
        public IEnumerable<Hotel> Hotels { get; set; }
        
        [Required(ErrorMessage = "Enter a city or a hotel name")]
        public string SearchKeyword { get; set; }

        [DataType(DataType.Date)]
        public DateTime CheckIn { get; set; }

        [DataType(DataType.Date)]
        public DateTime CheckOut { get; set; }
        public List<string> Facilities { get; set; }
        public List<string> StarsList { get; set; }
        public List<int> DistanceList { get; set; }
    }
}
