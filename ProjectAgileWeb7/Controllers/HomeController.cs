using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
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
        private readonly ILogger<HomeController> _logger;
        private readonly ApplicationDbContext _appContext;
        private readonly UserManager<ApplicationUser> _userManager;
        [BindProperty]
        public ApplicationUser CurrentUser { get; set; }

        public HomeController(ILogger<HomeController> logger, ApplicationDbContext appContext, UserManager<ApplicationUser> userManager)
        {
            _logger = logger;
            _appContext = appContext;
            _userManager = userManager;
        }

        public IActionResult Index()
        {
            //CurrentUser = await _userManager.GetUserAsync(User);
            //string currentUserId = CurrentUser?.Id;

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
            HttpContext.Session.SetString("CheckInDate", JsonConvert.SerializeObject(null));
            HttpContext.Session.SetString("CheckOutDate", JsonConvert.SerializeObject(null));

            return View(hotelsViewModel);
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

        private string GetCurrentUserId()
        {
            var claimsIdentity = (ClaimsIdentity)User.Identity;
            var identityClaim = claimsIdentity.FindFirst(ClaimTypes.NameIdentifier);
            string currentUserId = identityClaim?.Value;
            return currentUserId;
        }

        [HttpPost]
        [AutoValidateAntiforgeryToken]
        public IActionResult Search(HotelsViewModel hotelsViewModel)
        {
            TempData["searchKeyword"] = hotelsViewModel.SearchKeyword;
            TempData["checkInDate"] = hotelsViewModel.CheckIn;
            TempData["checkOutDate"] = hotelsViewModel.CheckOut;

            //CurrentUser = await _userManager.GetUserAsync(User);
            //string currentUserId = CurrentUser?.Id;
            //var claimsIdentity = (ClaimsIdentity)User.Identity;
            //var identityClaim = claimsIdentity.FindFirst(ClaimTypes.NameIdentifier);
            //string currentUserId = identityClaim?.Value;

            //var hotelIdList = !string.IsNullOrEmpty(currentUserId)
            //    ? _appContext.HotelUsers
            //        .Where(x => x.UserId == currentUserId)
            //        .Select(x => x.HotelId)
            //        .ToList()
            //    : new List<int>();
            string currentUserId = GetCurrentUserId();
            List<int> hotelIdList = GetHotelIdList(currentUserId);

            //hotelsViewModel.Hotels = GetHotelsBySearch(hotelsViewModel.SearchKeyword, hotelsViewModel.CheckIn, hotelsViewModel.CheckOut);
            var hotelListAfterSearch = GetHotelsBySearch(hotelsViewModel.SearchKeyword, hotelsViewModel.CheckIn, hotelsViewModel.CheckOut);

            var newHotelViewModel = new HotelsViewModel
            {
                SearchKeyword = hotelsViewModel.SearchKeyword,
                CheckIn = hotelsViewModel.CheckIn,
                CheckOut = hotelsViewModel.CheckOut,
                FavoriteHotels = hotelIdList,
                Hotels = hotelListAfterSearch
            };
            // HttpContext.Session.SetString("HotelModelView", JsonConvert.SerializeObject(myModel));
            // HttpContext.Session.SetString("SearchWord", JsonConvert.SerializeObject(hotelsViewModel.SearchKeyword));
            HttpContext.Session.SetString("CheckInDate", JsonConvert.SerializeObject(hotelsViewModel.CheckIn));
            HttpContext.Session.SetString("CheckOutDate", JsonConvert.SerializeObject(hotelsViewModel.CheckOut));

            FillingViewBags();

            return Filter(newHotelViewModel);
        }



        [HttpPost]
        public IActionResult Filter(HotelsViewModel hotelsViewModel)
        {
            var hotelListAfterSearch = hotelsViewModel.Hotels ?? GetHotelsBySearch(TempData["searchKeyword"]?.ToString(), Convert.ToDateTime(TempData["checkInDate"]?.ToString()), Convert.ToDateTime(TempData["checkOutDate"]?.ToString()));

            var facilitiesList = hotelsViewModel.Facilities;
            var starList = hotelsViewModel.StarsList;
            var distanceList = hotelsViewModel.DistanceList;

            //hotelsViewModel.Hotels = hotelListAfterSearch
            //                        .Where(h => starList != null ? starList.All(s => h.Stars.ToString().Contains(s)) : true)
            //                        .Where(h => facilitiesList != null ? facilitiesList.All(f => h.HotelFacilities.Select(f => f.FacilityId.ToString()).Contains(f)) : true)
            //                        .Where(h => distanceList != null ? h.DistanceFromCenter < distanceList.Max() : true)
            //                        .ToList();

            var hotelListAfterFilter = hotelListAfterSearch
                                     .Where(h => starList != null ? starList.All(s => h.Stars.ToString().Contains(s)) : true)
                                     .Where(h => facilitiesList != null ? facilitiesList.All(f => h.HotelFacilities.Select(f => f.FacilityId.ToString()).Contains(f)) : true)
                                     .Where(h => distanceList != null ? h.DistanceFromCenter < distanceList.Max() : true)
                                     .ToList();

            //CurrentUser = await _userManager.GetUserAsync(User);
            //string currentUserId = CurrentUser?.Id;

            //var claimsIdentity = (ClaimsIdentity)User.Identity;
            //var identityClaim = claimsIdentity.FindFirst(ClaimTypes.NameIdentifier);
            //string currentUserId = identityClaim?.Value;

            //var hotelIdList = !string.IsNullOrEmpty(currentUserId)
            //       ? _appContext.HotelUsers
            //       .Where(x => x.UserId == currentUserId)
            //       .Select(x => x.HotelId)
            //       .ToList()
            //   : new List<int>();

            string currentUserId = GetCurrentUserId();
            List<int> hotelIdList = GetHotelIdList(currentUserId);

            var newHotelViewModel = new HotelsViewModel
            {
                SearchKeyword = hotelsViewModel.SearchKeyword,
                CheckIn = hotelsViewModel.CheckIn,
                CheckOut = hotelsViewModel.CheckOut,
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
            if (searchKeyword != null)
            {
                var hotelsViewModel = new HotelsViewModel();
                hotelsViewModel.Hotels = _appContext.Hotels.Include(h => h.HotelFacilities).Include(h => h.Rooms)
                      .Where(h => h.Name.Contains(searchKeyword)
                               || h.City.Contains(searchKeyword)).ToList();
                // Add more (ex: split search keyword)

                if (checkInDate != null && checkOutDate != null)
                {
                    var stay = new List<DateTime>();
                    for (DateTime date = checkInDate; date < checkOutDate; date = date.AddDays(1))
                    {
                        stay.Add(date);
                    }

                    var unavailableRooms = _appContext.Rooms.Where(r => _appContext.BookedRooms.Any(b => b.RoomId == r.RoomId && stay.Contains(b.Date)));
                    var availableRooms = _appContext.Rooms.Except(unavailableRooms);
                    var availableHotels = availableRooms.Select(r => r.Hotel).Distinct().ToList();

                    hotelsViewModel.Hotels = hotelsViewModel.Hotels.Where(h1 => availableHotels.Any(h2 => h2.HotelId == h1.HotelId)).ToList();
                }

                return hotelsViewModel.Hotels;
            }
            else
            {
                return _appContext.Hotels.Include(h => h.Rooms).Include(h => h.HotelFacilities).ThenInclude(hf => hf.Facility).ToList();
            }
        }
    }
}
