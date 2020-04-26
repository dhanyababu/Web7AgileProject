using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace ProjectAgileWeb7.Models
{
    public class HotelsViewModel
    {
        public IEnumerable<Hotel> Hotels { get; set; }
        
        [Required(ErrorMessage = "Enter a city or a hotel name")]
        public string SearchKeyword { get; set; }

        [DataType(DataType.Date)]
        public DateTime CheckIn { get; set; }

        [DataType(DataType.Date)]
        public DateTime CheckOut { get; set; }
    }
}
