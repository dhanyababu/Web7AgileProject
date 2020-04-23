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
        
        [Required]
        public string SearchKeyword { get; set; }
        public string CheckIn { get; set; }
        public string CheckOut { get; set; }
    }
}
