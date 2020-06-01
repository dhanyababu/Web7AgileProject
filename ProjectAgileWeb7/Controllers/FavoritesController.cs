using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using ProjectAgileWeb7.Data;
using ProjectAgileWeb7.Models;
using System.Collections.Generic;
using System.Linq;
using System.Security.Claims;
using System.Threading.Tasks;

namespace ProjectAgileWeb7.Controllers
{
    [Authorize]
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

        public async Task<IActionResult> GetHotelIdFromIndex(int id)
        {
            CurrentUser = await _userManager.GetUserAsync(User);
            string currentUserId = CurrentUser.Id;

            CheckIfHotelIsFavorite(id, currentUserId);
            return RedirectToAction("Index");
        }

        public async Task<IActionResult> GetHotelIdFromFavorites(int id)
        {
            CurrentUser = await _userManager.GetUserAsync(User);
            string currentUserId = CurrentUser.Id;

            CheckIfHotelIsFavorite(id, currentUserId);
            return RedirectToAction("Favorites");
        }

        private void CheckIfHotelIsFavorite(int id, string currentUserId)
        {
            SelectedHotel = _appContext.Hotels.Where(h => h.HotelId == id)
                                    .Include(h => h.HotelFacilities)
                                    .ThenInclude(hf => hf.Facility)
                                    .FirstOrDefault();

            List<int> hotelIdList = GetHotelIdList(currentUserId);

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
        }

        public IActionResult Favorites()
        {
            string currentUserId = GetCurrentUserId();
            var currentUser = _appContext.ApplicationUsers.Where(u => u.Id == currentUserId).FirstOrDefault();
            ViewBag.User = currentUser;
            var newHotelsList = _appContext.HotelUsers
                                    .Where(x => x.UserId == currentUserId)
                                    .Include(hu => hu.Hotel)
                                    .ThenInclude(h => h.HotelFacilities)
                                    .ThenInclude(hf => hf.Facility)
                                    .Select(x => x.Hotel)
                                    .ToList();
            List<int> hotelIdList = GetHotelIdList(currentUserId);
            var newHotelViewModel = new HotelsViewModel
            {
                Hotels = newHotelsList,
                FavoriteHotels = hotelIdList
            };

            return View(newHotelViewModel);
        }

        private List<int> GetHotelIdList(string currentUserId)
        {
            return _appContext.HotelUsers
                                       .Where(x => x.UserId == currentUserId)
                                       .Select(x => x.HotelId)
                                       .ToList();
        }

        private string GetCurrentUserId()
        {
            var claimIdentity = (ClaimsIdentity)User.Identity;
            var identityClaimUser = claimIdentity.FindFirst(ClaimTypes.NameIdentifier);
            string currentUserId = identityClaimUser?.Value;
            return currentUserId;
        }
    }
}
