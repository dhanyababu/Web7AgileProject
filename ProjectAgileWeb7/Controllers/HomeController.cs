using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Newtonsoft.Json;
using ProjectAgileWeb7.Data;
using ProjectAgileWeb7.Models;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Security.Claims;

namespace ProjectAgileWeb7.Controllers
{
    public class HomeController : Controller
    {       
        private readonly ApplicationDbContext _appContext;
        
        public HomeController(ApplicationDbContext appContext)
        {            
            _appContext = appContext;
        }

        public IActionResult Index(bool clear)
        {
            string currentUserId = GetCurrentUserId();
            List<int> hotelIdList = GetHotelIdList(currentUserId);

            var hotelsViewModel = new HotelsViewModel()
            {
                Hotels = _appContext.Hotels
                                    .Include(h => h.Rooms)
                                    .Include(h => h.HotelFacilities).ThenInclude(hf => hf.Facility),
                FavoriteHotels = hotelIdList
            };

            FillingViewBags();
            if (HttpContext.Session.GetString("SearchKeyword") == null || clear)
            {
                HttpContext.Session.SetString("SearchKeyword", string.Empty);
            }
            if (HttpContext.Session.GetString("CheckInDate") == null || clear)
            {
                HttpContext.Session.SetString("CheckInDate", JsonConvert.SerializeObject(null));
            }
            if (HttpContext.Session.GetString("CheckOutDate") == null || clear)
            {
                HttpContext.Session.SetString("CheckOutDate", JsonConvert.SerializeObject(null));
            }

            return View(hotelsViewModel);
        }

        [HttpPost]
        [AutoValidateAntiforgeryToken]
        public IActionResult Search(HotelsViewModel hotelsViewModel)
        {
            if (hotelsViewModel.SearchKeyword != null)
            {
                HttpContext.Session.SetString("SearchKeyword", hotelsViewModel.SearchKeyword);
            }
            if (hotelsViewModel.CheckIn != DateTime.MinValue)
            {
                HttpContext.Session.SetString("CheckInDate", JsonConvert.SerializeObject(hotelsViewModel.CheckIn));
            }
            if (hotelsViewModel.CheckOut != DateTime.MinValue)
            {
                HttpContext.Session.SetString("CheckOutDate", JsonConvert.SerializeObject(hotelsViewModel.CheckOut));
            }

            string currentUserId = GetCurrentUserId();
            List<int> hotelIdList = GetHotelIdList(currentUserId);

            var hotelListAfterSearch = GetHotelsBySearch(
                HttpContext.Session.GetString("SearchKeyword"), 
                Convert.ToDateTime(JsonConvert.DeserializeObject(HttpContext.Session.GetString("CheckInDate"))), 
                Convert.ToDateTime(JsonConvert.DeserializeObject(HttpContext.Session.GetString("CheckOutDate")))
                );

            var newHotelViewModel = new HotelsViewModel
            {
                SearchKeyword = HttpContext.Session.GetString("SearchKeyword"),
                CheckIn = Convert.ToDateTime(JsonConvert.DeserializeObject(HttpContext.Session.GetString("CheckInDate"))),
                CheckOut = Convert.ToDateTime(JsonConvert.DeserializeObject(HttpContext.Session.GetString("CheckOutDate"))),
                FavoriteHotels = hotelIdList,
                Hotels = hotelListAfterSearch
            };

            FillingViewBags();

            return Filter(newHotelViewModel);
        }

        [HttpPost]
        public IActionResult Filter(HotelsViewModel hotelsViewModel)
        {
            var hotelListAfterSearch = hotelsViewModel.Hotels ??
                GetHotelsBySearch(
                    HttpContext.Session.GetString("SearchKeyword"),
                    Convert.ToDateTime(JsonConvert.DeserializeObject(HttpContext.Session.GetString("CheckInDate"))),
                    Convert.ToDateTime(JsonConvert.DeserializeObject(HttpContext.Session.GetString("CheckOutDate")))
                );

            var facilitiesList = hotelsViewModel.Facilities;
            var starList = hotelsViewModel.StarsList;
            var distanceList = hotelsViewModel.DistanceList;

            var hotelListAfterFilter = hotelListAfterSearch
                           .Where(h => starList != null ? starList.All(s => h.Stars.ToString().Contains(s)) : true)
                           .Where(h => facilitiesList != null ? facilitiesList.All(f => h.HotelFacilities.Select(f => f.FacilityId.ToString()).Contains(f)) : true)
                           .Where(h => distanceList != null ? h.DistanceFromCenter < distanceList.Max() : true)
                           .ToList();

            string currentUserId = GetCurrentUserId();
            List<int> hotelIdList = GetHotelIdList(currentUserId);

            var newHotelViewModel = new HotelsViewModel
            {
                SearchKeyword = HttpContext.Session.GetString("SearchKeyword"),
                CheckIn = Convert.ToDateTime(JsonConvert.DeserializeObject(HttpContext.Session.GetString("CheckInDate"))),
                CheckOut = Convert.ToDateTime(JsonConvert.DeserializeObject(HttpContext.Session.GetString("CheckOutDate"))),
                FavoriteHotels = hotelIdList,
                Hotels = hotelListAfterFilter
            };
            FillingViewBags();

            return View("Index", newHotelViewModel);
        }

        public IActionResult Privacy()
        {
            return View();
        }

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

        private IEnumerable<Hotel> GetHotelsBySearch(string searchKeyword, DateTime checkInDate, DateTime checkOutDate)
        {
            if (searchKeyword != null && searchKeyword != string.Empty)
            {
                var hotelsViewModel = new HotelsViewModel
                {
                    Hotels = _appContext.Hotels
                        .Include(h => h.HotelFacilities)
                        .Include(h => h.Rooms)
                        .Where(h => h.Name.Contains(searchKeyword) ||
                                    h.City.Contains(searchKeyword))
                        .ToList()
                };

                if (checkInDate != DateTime.MinValue && checkOutDate != DateTime.MinValue)
                {
                    var stay = new List<DateTime>();
                    for (DateTime date = checkInDate; date < checkOutDate; date = date.AddDays(1))
                    {
                        stay.Add(date);
                    }

                    var unavailableRooms = _appContext.Rooms
                        .Where(r => _appContext.BookedRooms
                        .Any(b => b.RoomId == r.RoomId && stay.Contains(b.Date)));

                    var availableRooms = _appContext.Rooms
                        .Except(unavailableRooms);

                    var availableHotels = availableRooms
                        .Select(r => r.Hotel)
                        .Distinct()
                        .ToList();

                    hotelsViewModel.Hotels = hotelsViewModel.Hotels
                        .Where(h1 => availableHotels
                        .Any(h2 => h2.HotelId == h1.HotelId))
                        .ToList();
                }

                return hotelsViewModel.Hotels;
            }
            return _appContext.Hotels
                .Include(h => h.Rooms)
                .Include(h => h.HotelFacilities)
                .ThenInclude(hf => hf.Facility)
                .ToList();
        }

        private string GetCurrentUserId()
        {
            var claimIdentity = (ClaimsIdentity)User.Identity;
            var identityClaimUser = claimIdentity.FindFirst(ClaimTypes.NameIdentifier);
            string currentUserId = identityClaimUser?.Value;
            return currentUserId;
        }

        private List<int> GetHotelIdList(string currentUserId)
        {
            return !string.IsNullOrEmpty(currentUserId)
                            ? _appContext.HotelUsers
                                .Where(x => x.UserId == currentUserId)
                                .Select(x => x.HotelId)
                                .ToList()
                            : new List<int>();
        }
    }
}
