using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using ProjectAgileWeb7.Data;
using ProjectAgileWeb7.Models;

namespace ProjectAgileWeb7.Controllers
{
    public class AdminHotelFacilitiesController : Controller
    {
        private readonly ApplicationDbContext _context;

        public AdminHotelFacilitiesController(ApplicationDbContext context)
        {
            _context = context;
        }

        // GET: AdminHotelFacilities
        public async Task<IActionResult> Index(int? id)
        {
            var applicationDbContext = _context.HotelFacilities.Include(h => h.Facility).Include(h => h.Hotel);

            if (id != null)
            {
                applicationDbContext = _context.HotelFacilities.Where(h => h.HotelId == id).Include(h => h.Facility).Include(h => h.Hotel);
            }
            
            return View(await applicationDbContext.ToListAsync());
        }

        // GET: AdminHotelFacilities/Create
        public IActionResult Create()
        {
            ViewData["FacilityId"] = new SelectList(_context.Facilities, "FacilityId", "Name");
            ViewData["HotelId"] = new SelectList(_context.Hotels, "HotelId", "Name");
            return View();
        }

        // POST: AdminHotelFacilities/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("HotelId,FacilityId")] HotelFacility hotelFacility)
        {
            if (ModelState.IsValid)
            {
                _context.Add(hotelFacility);
                await _context.SaveChangesAsync();
                return RedirectToAction(nameof(Index));
            }
            ViewData["FacilityId"] = new SelectList(_context.Facilities, "FacilityId", "Name", hotelFacility.FacilityId);
            ViewData["HotelId"] = new SelectList(_context.Hotels, "HotelId", "Name", hotelFacility.HotelId);
            return View(hotelFacility);
        }

        // GET: AdminHotelFacilities/Delete/5
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

        // POST: AdminHotelFacilities/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            var hotelFacility = await _context.HotelFacilities.FindAsync(id);
            _context.HotelFacilities.Remove(hotelFacility);
            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(Index));
        }

        private bool HotelFacilityExists(int id)
        {
            return _context.HotelFacilities.Any(e => e.HotelId == id);
        }
    }
}
