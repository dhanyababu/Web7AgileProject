using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using ProjectAgileWeb7.Data;
using ProjectAgileWeb7.Models;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ProjectAgileWeb7.Controllers
{
    public class MyBookingsController : Controller
    {
        private readonly ApplicationDbContext _appContext;
        private readonly UserManager<ApplicationUser> _userManager;
        [BindProperty]
        public ApplicationUser CurrentUser { get; set; }

        public MyBookingsController(ApplicationDbContext appContext, UserManager<ApplicationUser> userManager)
        {
            _appContext = appContext;
            _userManager = userManager;
        }

        [Authorize]
        public async Task<IActionResult> MyBookings()
        {
            CurrentUser = await _userManager.GetUserAsync(User);
            if (CurrentUser != null)
            {
                ViewBag.User = CurrentUser;
            }
            var myBookingsList = await _appContext.Bookings
                                    .Where(b => b.UserId == CurrentUser.Id)
                                    .Include(b => b.Payment)
                                    .Include(b => b.Room)
                                    .ThenInclude(r => r.Hotel)

                                    .ToListAsync();

            foreach (var booking in myBookingsList)
            {
                if (booking.Payment == null)
                {
                    _appContext.Bookings.Remove(booking);
                }
            }
            await _appContext.SaveChangesAsync();

            return View(myBookingsList);
        }
    }
}
