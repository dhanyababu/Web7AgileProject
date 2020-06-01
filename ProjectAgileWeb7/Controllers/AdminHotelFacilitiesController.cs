using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using ProjectAgileWeb7.Data;
using ProjectAgileWeb7.Models;
using System.Linq;
using System.Threading.Tasks;

namespace ProjectAgileWeb7.Controllers
{
    [Authorize(Roles = "Admin")]
    public class AdminHotelFacilitiesController : Controller
    {
        private readonly ApplicationDbContext _context;

        public AdminHotelFacilitiesController(ApplicationDbContext context)
        {
            _context = context;
        }

        public async Task<IActionResult> Index(int? id)
        {
            var applicationDbContext = _context.HotelFacilities
                .Include(h => h.Facility)
                .Include(h => h.Hotel);

            if (id != null)
            {
                applicationDbContext = _context.HotelFacilities
                    .Where(h => h.HotelId == id)
                    .Include(h => h.Facility)
                    .Include(h => h.Hotel);
            }

            return View(await applicationDbContext.ToListAsync());
        }

        public IActionResult Create()
        {
            ViewData["FacilityId"] = new SelectList(_context.Facilities, "FacilityId", "Name");
            ViewData["HotelId"] = new SelectList(_context.Hotels, "HotelId", "Name");
            ViewData["Duplicate"] = false;
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("HotelId,FacilityId")] HotelFacility hotelFacility)
        {
            var isHotelAndFacilitiesExists = _context.HotelFacilities
                .Any(h => h.HotelId == hotelFacility.HotelId &&
                    h.FacilityId == hotelFacility.FacilityId);

            if (ModelState.IsValid && !isHotelAndFacilitiesExists)
            {
                _context.Add(hotelFacility);
                await _context.SaveChangesAsync();
                return RedirectToAction(nameof(Index));
            }

            ViewData["FacilityId"] = new SelectList(_context.Facilities, "FacilityId", "Name", hotelFacility.FacilityId);
            ViewData["HotelId"] = new SelectList(_context.Hotels, "HotelId", "Name", hotelFacility.HotelId);
            ViewData["Duplicate"] = true;
            return View(hotelFacility);
        }

        public async Task<IActionResult> Delete(int? hotelId, int? facilityId)
        {
            if (hotelId == null || facilityId == null)
            {
                return NotFound();
            }

            var hotelFacility = await _context.HotelFacilities
                .Include(h => h.Facility)
                .Include(h => h.Hotel)
                .FirstOrDefaultAsync(m => m.HotelId == hotelId && m.FacilityId == facilityId);
            if (hotelFacility == null)
            {
                return NotFound();
            }

            return View(hotelFacility);
        }

        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int? hotelId, int? facilityId)
        {
            var hotelFacility = await _context.HotelFacilities
                .FirstOrDefaultAsync(h => h.HotelId == hotelId &&
                h.FacilityId == facilityId);

            _context.HotelFacilities.Remove(hotelFacility);
            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(Index));
        }
    }
}
