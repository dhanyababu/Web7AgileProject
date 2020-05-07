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


        //[Authorize]
        //public IActionResult GetHotelId(int id)
        //{
        //    TempData["id"] = id;

        //    //HttpContext.Session.SetInt32("SelectedHotelId", id);
        //    return RedirectToAction("Index");
        //}



        [Authorize]
        public async Task<IActionResult> GetHotelId(int id)

        {
            //bool IsFavorite = false;

            CurrentUser = await _userManager.GetUserAsync(User);
            string currentUserId = CurrentUser.Id;

            //int selectedHotelId = 0;

            //if (Int32.TryParse(TempData["id"]?.ToString(), out int result))
            //{
            //    selectedHotelId = result;
            //}

            //if (selectedHotelId != 0)
            //{
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
            //if (hotelIdList.Count() == 0)
            //{

            //    var newHotelUser = new HotelUser
            //    {
            //        UserId = currentUserId,
            //        ApplicationUser = CurrentUser,
            //        HotelId = id,
            //        Hotel = SelectedHotel
            //    };
            //    _appContext.HotelUsers.Add(newHotelUser);
            //    _appContext.SaveChanges();
            //}
            //else
            //{
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
            //for (int i = 0; i < hotelUsersObjectList.Count; i++)
            //{
            //    if (hotelUsersObjectList[i].HotelId == id)
            //    {
            //        _appContext.HotelUsers.Remove(hotelUsersObjectList[i]);
            //        _appContext.SaveChanges();
            //        break;
            //    }
            //    else if (hotelUsersObjectList[i].HotelId != id)
            //    {
            //        var newHotelUser = new HotelUser
            //        {
            //            UserId = currentUserId,
            //            ApplicationUser = CurrentUser,
            //            HotelId = id,
            //            Hotel = SelectedHotel
            //        };
            //        _appContext.HotelUsers.Add(newHotelUser);
            //        _appContext.SaveChanges();
            //        break;
            //    }
            //}
            //}


            //foreach (var item in hotelUsersObjectList)
            //{
            //    if (item.HotelId == id && item.UserId == currentUserId)
            //    {
            //        _appContext.HotelUsers.Remove(item);
            //        _appContext.SaveChanges();
            //        break;
            //    }
            //    else
            //    {
            //        var newHotelUser = new HotelUser
            //        {
            //            UserId = currentUserId,
            //            ApplicationUser = CurrentUser,
            //            HotelId = id,
            //            Hotel = SelectedHotel
            //        };
            //        _appContext.HotelUsers.Add(newHotelUser);
            //        _appContext.SaveChanges();
            //        break;
            //    }
            //}


            //var newHotelUser = new HotelUser
            //{
            //    UserId = currentUserId,
            //    ApplicationUser = CurrentUser,
            //    HotelId = id,
            //    Hotel = SelectedHotel
            //};

            //var oldHotelUserList = _appContext.HotelUsers.ToList();

            //if (!oldHotelUserList.Contains(newHotelUser))
            //{
            //    IsFavorite = true;
            //    ViewBag.IsFavorite = IsFavorite;
            //    _appContext.HotelUsers.Add(newHotelUser);
            //    _appContext.SaveChanges();
            //}
            //else
            //{
            //    IsFavorite = false;
            //    ViewBag.IsFavorite = IsFavorite;
            //    _appContext.HotelUsers.Remove(newHotelUser);
            //    _appContext.SaveChanges();
            //}

            //}

            // var newHotelUserList = _appContext.HotelUsers.Where(x => x.UserId == currentUserId).ToList();


            return RedirectToAction("Index");

        }


        [Authorize]
        public async Task<IActionResult> Favorites()
        {

            CurrentUser = await _userManager.GetUserAsync(User);
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
