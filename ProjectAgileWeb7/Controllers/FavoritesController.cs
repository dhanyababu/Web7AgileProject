using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using ProjectAgileWeb7.Data;
using ProjectAgileWeb7.Models;
using System.Linq;
using System.Threading.Tasks;

namespace ProjectAgileWeb7.Controllers
{
    public class FavoritesController : Controller
    {


        private readonly ApplicationDbContext _appContext;
        private readonly UserManager<ApplicationUser> _userManager;
        [BindProperty]
        public ApplicationUser CurrentUser { get; set; }
        [BindProperty]
        public Hotel SelectedHotel { get; set; }

        public FavoritesController(ApplicationDbContext appContext, UserManager<ApplicationUser> userManager)
        {

            _appContext = appContext;
            _userManager = userManager;
        }


        [Authorize]
        public async Task<IActionResult> GetHotelId(int id)
        {
            CurrentUser = await _userManager.GetUserAsync(User);
            string currentUserId = CurrentUser.Id;

            var SelectedHotel = _appContext.Hotels.Where(h => h.HotelId == id)
                                    .Include(h => h.HotelFacilities)
                                    .ThenInclude(hf => hf.Facility)
                                    .FirstOrDefault();

            var hotelIdList = _appContext.HotelUsers
                                       .Where(x => x.UserId == currentUserId)
                                       .Select(x => x.HotelId)
                                       .ToList();

            var hotelUsersList = _appContext.HotelUsers
                                       .Where(x => x.UserId == currentUserId)
                                       .ToList();

            if (hotelIdList.Contains(id))
            {
                var oldHotelUser = _appContext.HotelUsers
                                   .Where(hu => hu.UserId == currentUserId)
                                   .Where(hu => hu.HotelId == id)
                                   .FirstOrDefault();
                _appContext.HotelUsers.Remove(oldHotelUser);
                _appContext.SaveChanges();
            }
            else
            {
                var newHotelUser = new HotelUser
                {
                    UserId = currentUserId,
                    ApplicationUser = CurrentUser,
                    HotelId = id,
                    Hotel = SelectedHotel
                };
                _appContext.HotelUsers.Add(newHotelUser);
                _appContext.SaveChanges();
            }
            return RedirectToAction("Index");
        }

        [Authorize]
        public async Task<IActionResult> Favorites()
        {

            CurrentUser = await _userManager.GetUserAsync(User);
            ViewBag.User = CurrentUser;
            string currentUserId = CurrentUser.Id;
            var newHotelUserList = _appContext.HotelUsers
                                    .Where(x => x.UserId == currentUserId)
                                    .Include(hu => hu.Hotel)
                                    .ThenInclude(h => h.HotelFacilities)
                                    .ThenInclude(hf => hf.Facility)
                                    .ToList();

            return View(newHotelUserList);
        }
    }
}
