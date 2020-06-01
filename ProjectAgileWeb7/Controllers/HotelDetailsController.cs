using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Newtonsoft.Json;
using ProjectAgileWeb7.Data;
using ProjectAgileWeb7.Models;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace ProjectAgileWeb7.Controllers
{
    [Authorize]
    public class HotelDetailsController : Controller
    {
        private readonly ApplicationDbContext _appContext;
        private readonly UserManager<ApplicationUser> _userManager;

        public HotelDetailsController(ApplicationDbContext appContext,
            UserManager<ApplicationUser> userManager)
        {
            _appContext = appContext;
            _userManager = userManager;
        }

        [BindProperty]
        [Required]
        [EmailAddress]
        public string Email { get; set; }

        [BindProperty]
        public ApplicationUser CurrentUser { get; set; }
        [BindProperty]
        public Payment Payment { get; set; }

        public async Task<IActionResult> HotelPage(int id)
        {
            var hotel = await _appContext.Hotels
                .Where(h => h.HotelId == id)
                .Include(r => r.Rooms)
                .Include(f => f.HotelFacilities)
                .ThenInclude(fa => fa.Facility)
                .ToListAsync();

            List<DateTime> daysRangeList = GetStayingDaysRangeList();
            ViewBag.DataInfo = daysRangeList;

            var unavailableRooms = _appContext.Rooms
                                    .Where(r => _appContext.BookedRooms
                                    .Any(b => b.RoomId == r.RoomId && daysRangeList.Contains(b.Date)));

            var availableRoomsToBeBooked = _appContext.Rooms.Except(unavailableRooms)
                                                .Where(r => r.HotelId == id);

            ViewBag.RoomsAvailable = availableRoomsToBeBooked.ToList();
            return View(hotel[0]);
        }

        public async Task<IActionResult> BookRoom(RoomType roomType, int id)
        {
            CurrentUser = await _userManager.GetUserAsync(User);
            if (CurrentUser != null)
                ViewBag.User = CurrentUser;

            List<DateTime> daysRangeList = GetStayingDaysRangeList();
            ViewBag.DataInfo = daysRangeList;

            var unavailableRooms = _appContext.Rooms
                .Where(r => _appContext.BookedRooms
                .Any(b => b.RoomId == r.RoomId && daysRangeList.Contains(b.Date)));

            var availableRoomToBeBooked = _appContext.Rooms
                .Except(unavailableRooms)
                .Include(h => h.Hotel)
                .Where(r => r.HotelId == id)
                .Where(r => r.RoomType == roomType)
                .FirstOrDefault();

            if (availableRoomToBeBooked != null)
            {
                HttpContext.Session.SetInt32("roomId", availableRoomToBeBooked.RoomId);
                return View(availableRoomToBeBooked);
            }
            else
            {
                return (NotFound());
            }
        }

        private List<DateTime> GetStayingDaysRangeList()
        {
            var checkInDate = Convert.ToDateTime(JsonConvert.DeserializeObject(HttpContext.Session.GetString("CheckInDate")));
            var checkOutDate = Convert.ToDateTime(JsonConvert.DeserializeObject(HttpContext.Session.GetString("CheckOutDate")));
            var daysRangeList = new List<DateTime>();

            for (DateTime date = checkInDate; date <= checkOutDate; date = date.AddDays(1))
            {
                daysRangeList.Add(date);
            }
            return daysRangeList;
        }
    }
}
