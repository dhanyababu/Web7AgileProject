using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Claims;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore.Internal;
using Newtonsoft.Json;
using ProjectAgileWeb7.Data;
using ProjectAgileWeb7.Models;

namespace ProjectAgileWeb7.Controllers
{
    public class CheckoutController : Controller
    {
        private readonly ApplicationDbContext _appContext;
        private readonly UserManager<ApplicationUser> _userManager;

        public CheckoutController(ApplicationDbContext appContext,
            UserManager<ApplicationUser> userManager)
        {
            _appContext = appContext;
            _userManager = userManager;
        }

        public IActionResult Index()
        {
            return View();
        }

        [Authorize]
        public async Task<IActionResult> Checkout()
        {
            var claimsIdentity = (ClaimsIdentity)User.Identity;
            var identityClaim = claimsIdentity.FindFirst(ClaimTypes.NameIdentifier);

            var booking = new Booking()
            {
                RoomId = Convert.ToInt32(HttpContext.Session.GetInt32("roomId")),
                CheckIn = Convert.ToDateTime(JsonConvert.DeserializeObject(HttpContext.Session.GetString("CheckInDate"))),
                CheckOut = Convert.ToDateTime(JsonConvert.DeserializeObject(HttpContext.Session.GetString("CheckOutDate"))),
                Status = Status.Pending,
                UserId = identityClaim.Value
            };
            _appContext.Bookings.Add(booking);
            await _appContext.SaveChangesAsync();

            HttpContext.Session.SetInt32("bookingId", booking.Id);            

            return View();
        }


        [HttpPost]
        [AutoValidateAntiforgeryToken]
        [Authorize]
        public IActionResult Checkout(Payment payment)        {

            if (ModelState.IsValid)
            {
                var bookingId = Convert.ToInt32(HttpContext.Session.GetInt32("bookingId"));
                var booking = _appContext.Bookings.FirstOrDefault(b => b.Id == bookingId);
                var numberOfNights = Convert.ToDecimal((booking.CheckOut - booking.CheckIn).TotalDays);
                var roomId = _appContext.Bookings.Where(b => b.Id == bookingId).Select(b => b.RoomId).FirstOrDefault();
                var roomPrice = _appContext.Rooms.Where(r => r.RoomId == roomId).Select(r => r.RoomPrice).FirstOrDefault();
                var total = roomPrice * numberOfNights;

                var newPayment = new Payment()
                {
                    BookingId = bookingId,
                    Status = Status.Pending,
                    Date = DateTime.Now.Date,
                    Amount = total,
                    Type = payment.Type,
                    CardNumber = payment.CardNumber.Substring(12),
                    CVV = payment.CVV.Substring(0, 1),
                    ExpirationDate = payment.ExpirationDate,
                    CardHolderFirstName = payment.CardHolderFirstName,
                    CardHolderLastName = payment.CardHolderLastName
                };
                _appContext.Payments.Add(newPayment);
                _appContext.SaveChanges();               

                return RedirectToAction("PaymentCheckout", newPayment);
            }
            else
            {
                return View();
            }
        }

        [Authorize]
        public IActionResult PaymentCheckout(Payment payment)
        {
            if (payment != null)
            {
                var bookingFromDb = _appContext.Bookings.FirstOrDefault(b => b.Id == payment.BookingId);
                bookingFromDb.Status = Status.Accepted;
                _appContext.Update(bookingFromDb);

                var paymentFromDb = _appContext.Payments.FirstOrDefault(p => p == payment);
                paymentFromDb.Status = Status.Accepted;
                _appContext.Update(paymentFromDb);

                for (DateTime date = bookingFromDb.CheckIn; date < bookingFromDb.CheckOut; date = date.AddDays(1))
                {
                    _appContext.BookedRooms.Add(new BookingPerDay { RoomId = bookingFromDb.RoomId, Date = date });
                }

                _appContext.SaveChanges();
                return RedirectToAction("BookingConfirmation", paymentFromDb);
            }
            return View();
        }

        [Authorize]
        public IActionResult BookingConfirmation(Payment payment)
        {
            var claimsIdentity = (ClaimsIdentity)User.Identity;
            var identityClaim = claimsIdentity.FindFirst(ClaimTypes.NameIdentifier);

            var user = _appContext.ApplicationUsers.FirstOrDefault(u => u.Id == identityClaim.Value);
            var bookingId = _appContext.Payments.Where(p => p == payment).Select(p => p.BookingId).FirstOrDefault();
            var booking = _appContext.Bookings.FirstOrDefault(b => b.Id == bookingId);
            var room = _appContext.Rooms.FirstOrDefault(r => r.RoomId == booking.RoomId);
            var hotel = _appContext.Hotels.FirstOrDefault(h => h.HotelId == room.HotelId);

            var bookingConfVM = new BookingConfirmationViewModel()
            {   
                User = user,
                Payment = payment,
                Booking = booking,
                Room = room,
                Hotel = hotel
            };

            return View(bookingConfVM);
        }
    }
}