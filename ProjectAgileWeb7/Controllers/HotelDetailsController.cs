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

            return View(hotel[0]);
        }

        [Authorize]
        public async Task<IActionResult> BookRoom(RoomType roomType, int id)
        {
            var rooms = await _appContext.Rooms
                .Where(t => t.RoomType == roomType).Include(h => h.Hotel).Where(hi => hi.HotelId == id)
                .ToListAsync();

            CurrentUser = await _userManager.GetUserAsync(User);
            if (CurrentUser != null)
                ViewBag.User = CurrentUser;

            //var wordDeser = JsonConvert.DeserializeObject(HttpContext.Session.GetString("SearchWord"));
            var checkInObj = JsonConvert.DeserializeObject(HttpContext.Session.GetString("CheckInDate"));
            var checkOutObj = JsonConvert.DeserializeObject(HttpContext.Session.GetString("CheckOutDate"));
            //var myModel = JsonConvert.DeserializeObject(HttpContext.Session.GetString("HotelModelView"));
            var checkInDate = Convert.ToDateTime(checkInObj);
            var checkOutDate = Convert.ToDateTime(checkOutObj);
            var daysRangeList = new List<DateTime>();


            for (DateTime date = checkInDate; date < checkOutDate; date = date.AddDays(1))
            {
                daysRangeList.Add(date);
            }

            var gg = daysRangeList;
            return View(rooms[0]);
        }
    }
}
