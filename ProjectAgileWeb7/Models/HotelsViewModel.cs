using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

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
        [NotMapped]
        public List<string> Facilities { get; set; }
        [NotMapped]
        public List<string> StarsList { get; set; }
        [NotMapped]
        public List<int> DistanceList { get; set; }
        [NotMapped]
        public List<int> FavoriteHotels { get; set; }
    }
}
