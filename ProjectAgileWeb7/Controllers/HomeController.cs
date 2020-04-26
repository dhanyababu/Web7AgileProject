using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using ProjectAgileWeb7.Data;
using ProjectAgileWeb7.Models;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;

namespace ProjectAgileWeb7.Controllers
{
    public class HomeController : Controller
    {
        private readonly ILogger<HomeController> _logger;
        private readonly ApplicationDbContext _appContext;

        public HomeController(ILogger<HomeController> logger, ApplicationDbContext appContext)
        {
            _logger = logger;
            _appContext = appContext;
        }

        public IActionResult Index()
        {
            var hotelsViewModel = new HotelsViewModel()
            {
                Hotels = _appContext.Hotels.Include(h => h.HotelFacilities).Include(h => h.Rooms)
            };

            return View(hotelsViewModel);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public IActionResult Search(HotelsViewModel hotelsVievModel)
        {
            DateTime checkIn = Convert.ToDateTime(hotelsVievModel.CheckIn);
            DateTime checkOut = Convert.ToDateTime(hotelsVievModel.CheckOut);            

            hotelsVievModel.Hotels = _appContext.Hotels.Include(h => h.HotelFacilities).Include(h => h.Rooms)
                  .Where(h => h.City == hotelsVievModel.SearchKeyword
                           || h.Name == hotelsVievModel.SearchKeyword
                           || h.Name.Contains(hotelsVievModel.SearchKeyword)
                           || h.City.Contains(hotelsVievModel.SearchKeyword));
                           // Add more (ex: split search keyword)

            if (checkIn >= DateTime.Now.Date && checkOut >= DateTime.Now.Date)
            {
                var stay = new List<DateTime>();
                for (DateTime date = checkIn; date < checkOut; date = date.AddDays(1))
                {
                    stay.Add(date);
                }               

                var unavailableRooms = _appContext.Rooms.Where(r => _appContext.BookingPerDays.Any(b => b.RoomId == r.RoomId && stay.Contains(b.Date)));
                var availableRooms = _appContext.Rooms.Except(unavailableRooms);
                var availableHotels = availableRooms.Select(r => r.Hotel).Distinct().ToList();

                hotelsVievModel.Hotels = hotelsVievModel.Hotels.Where(h1 => availableHotels.Any(h2 => h2.HotelId == h1.HotelId));
            }

            return View("Index", hotelsVievModel);
        }

        //public IActionResult Privacy()
        //{
        //    return View();
        //}

        [ResponseCache(Duration = 0, Location = ResponseCacheLocation.None, NoStore = true)]
        public IActionResult Error()
        {
            return View(new ErrorViewModel { RequestId = Activity.Current?.Id ?? HttpContext.TraceIdentifier });
        }
    }
}
