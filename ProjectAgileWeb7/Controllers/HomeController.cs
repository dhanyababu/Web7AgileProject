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
                Hotels = _appContext.Hotels
                .Include(h => h.Rooms)
                .Include(h => h.HotelFacilities).ThenInclude(hf => hf.Facility)
            };

            FillingViewBags();

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
            TempData["searchKeyword"] = hotelsVievModel.SearchKeyword;
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

            FillingViewBags();

            return View("Index", hotelsVievModel);
        }



        [HttpPost]
        public IActionResult Filter(HotelsViewModel hotelViewModel)
        {
            var searchKeyword = TempData["searchKeyword"]?.ToString();
            var hotelList = GetHotelsBySearch(searchKeyword);
            var facilitiesList = hotelViewModel.Facilities;
            var starList = hotelViewModel.StarsList;
            var distanceList = hotelViewModel.DistanceList;

            hotelViewModel.Hotels = hotelList
                .Where(h => starList != null ? starList.All(s => h.Stars.ToString().Contains(s)) : true)
                .Where(h => facilitiesList != null ? facilitiesList.All(f => h.HotelFacilities.Select(f => f.FacilityId.ToString()).Contains(f)) : true)
                .Where(h => distanceList != null ? h.DistanceFromCenter < distanceList.Max() : true)
                .ToList();


            FillingViewBags();

            return View("Index", hotelViewModel);
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

        private void FillingViewBags()
        {
            ViewBag.Facilities = _appContext.Hotels
                                             .Include(h => h.Rooms)
                                             .Include(h => h.HotelFacilities).ThenInclude(hf => hf.Facility)
                                             .SelectMany(x => x.HotelFacilities.Select(y => y.Facility))
                                              .Distinct().ToList();

            ViewBag.Stars = _appContext.Hotels
                       .Select(h => h.Stars)
                       .OrderByDescending(s => s)
                       .Distinct()
                       .ToList();
        }

        private IEnumerable<Hotel> GetHotelsBySearch(string searchKeyword)
        {
            if (searchKeyword != null)
            {
                return _appContext.Hotels.Include(h => h.Rooms).Include(h => h.HotelFacilities).ThenInclude(hf => hf.Facility)
                .Where(h => h.Name.Contains(searchKeyword)
                         || h.City.Contains(searchKeyword));
            }
            else
            {
                return _appContext.Hotels.Include(h => h.Rooms).Include(h => h.HotelFacilities).ThenInclude(hf => hf.Facility);
            }
        }
    }
}
