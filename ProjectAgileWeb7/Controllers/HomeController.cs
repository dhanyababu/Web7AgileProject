using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using ProjectAgileWeb7.Data;
using ProjectAgileWeb7.Models;
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
        public IActionResult Search(HotelsViewModel hotelsVievModel)
        {
            if (hotelsVievModel.searchKeyword != null)
            {
                hotelsVievModel.Hotels = _appContext.Hotels.Include(h => h.HotelFacilities).Include(h => h.Rooms)
                    .Where(h => h.City == hotelsVievModel.searchKeyword
                             || h.Name == hotelsVievModel.searchKeyword
                             || h.Name.Contains(hotelsVievModel.searchKeyword)
                             || h.City.Contains(hotelsVievModel.searchKeyword));
            }
            else
            {
                return RedirectToAction("Index");
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
