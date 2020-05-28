using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.DependencyInjection;
using ProjectAgileWeb7.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ProjectAgileWeb7.Data
{
    public static class DbInitializer
    {
        public static async Task Initialize(IServiceProvider serviceProvider)
        {
            //dbContext.Database.EnsureDeleted();

            using var dbContext = new ApplicationDbContext(serviceProvider.GetRequiredService<DbContextOptions<ApplicationDbContext>>());

            await dbContext.Database.EnsureCreatedAsync();
            try
            {
                if (dbContext.Database.GetPendingMigrations().Count() > 0)
                {
                    dbContext.Database.Migrate();
                }
            }
            catch (Exception)
            {

            }

            if (!dbContext.Hotels.Any())
            {
                var hotels = new Hotel[]
                {
                    new Hotel
                    {
                        Name="Ritz Hotel Paris",
                        Website="https://www.ritzparis.com/en-GB",
                        Address="15 Place Vendôme",
                        ZipCode="75001",
                        City="Paris",
                        Country="France",
                        Description="Located in Paris, 500 m from Opéra Garnier, Ritz Paris features a selection of bars and restaurants, a garden and a business centre.",
                        Stars=5,
                        DistanceFromCenter=6.3,
                        Latitude="48.868164",
                        Longitude="2.328888",
                        ImageUrl="~/pictures/ritz.jpg"
                    },
                    new Hotel
                    {
                        Name="Corinthia Hotel London",
                        Website="https://www.corinthia.com/london/",
                        Address="Whitehall Place",
                        ZipCode="SW1A 2BD",
                        City="London",
                        Country="United Kingdom",
                        Description="The luxurious Corinthia Hotel is located in one of London’s most prestigious areas, moments from Trafalgar Square and Whitehall. It features elegant restaurants, 2 bars, a florist and the world's first hotel concession for Harrods.",
                        Stars=5,
                        DistanceFromCenter=1.6,
                        Latitude="51.506753",
                        Longitude="-0.124422",
                        ImageUrl="~/pictures/corinthia.jpg"
                    },
                    new Hotel
                    {
                        Name="Eden Hotel Amsterdam",
                        Website="https://www.edenhotelamsterdam.com/en/",
                        Address="Amstelstraat 17",
                        ZipCode="1017 DA",
                        City="Amsterdam",
                        Country="Netherlands",
                        Description="Located in the heart of the city center, Eden Hotel Amsterdam offers warm-colored rooms. The famous Rembrandt Square is right around the corner. The central station is 10 minutes away by tram.",
                        Stars=4,
                        DistanceFromCenter=0.9,
                        Latitude="52.366983",
                        Longitude="4.898774",
                        ImageUrl="~/pictures/eden.jpg"
                    },
                     new Hotel
                     {
                        Name="Paris France Hotel",
                        Website="https://www.paris-france-hotel.com/",
                        Address="72 Rue De Turbigo",
                        ZipCode="75003",
                        City="Paris",
                        Country="France",
                        Description="Built in 1910 during the Belle Epoque period, this hotel is in a great location in central Paris, with easy access to the city’s tourist attractions.",
                        Stars=3,
                        DistanceFromCenter=3.1,
                        Latitude="48.866954",
                        Longitude="2.360468",
                        ImageUrl="~/pictures/france.jpg"
                     },
                     new Hotel
                     {
                        Name="Athenee Palace Hilton",
                        Website="https://www.hilton.com/en/hotels/buhhitw-athenee-palace-hilton-bucharest/",
                        Address="56 Calea Victoriei",
                        ZipCode="010083",
                        City="Bucharest",
                        Country="Romania",
                        Description="Centrally located on Victoriei Street in the heart of Bucharest, Grand Hotel Continental is steps away from the National Art Museum and close to the Athenaeum, Universitate‎ Metro Station, and business district.",
                        Stars=5,
                        DistanceFromCenter=0.2,
                        Latitude="44.441230",
                        Longitude="26.095909",
                        ImageUrl="~/pictures/bucharest.jpg"
                     },
                     new Hotel
                     {
                        Name="Saint Ten Hotel",
                        Website="https://saintten.com/",
                        Address="Svetog Save 10",
                        ZipCode="11000",
                        City="Belgrade",
                        Country="Serbia",
                        Description="Set in the Vračar District of Belgrade, about 300 m from the Temple of St. Sava, the luxurious Saint Ten Hotel is housed in a cultural heritage building and offers an on-site restaurant.",
                        Stars=5,
                        DistanceFromCenter=1.9,
                        Latitude="44.801582",
                        Longitude="20.467130",
                        ImageUrl="~/pictures/belgrade.jpg"
                     }
                };

                dbContext.Hotels.AddRange(hotels);
                await dbContext.SaveChangesAsync();
            }

            if (!dbContext.Facilities.Any())
            {
                var facilities = new Facility[]
                {
                    new Facility { Name="Wi-fi", Symbol="wifi" },
                    new Facility { Name="Parking", Symbol="parking" },
                    new Facility { Name= "Breakfast", Symbol="utensils" },
                    new Facility { Name="Room service", Symbol="concierge-bell" },
                    new Facility { Name="Fitness center", Symbol="dumbbell" }, 
                    new Facility { Name="Pool", Symbol="swimming-pool" },
                    new Facility { Name="Sauna", Symbol="hot-tub" }
                };

                dbContext.Facilities.AddRange(facilities);
                await dbContext.SaveChangesAsync();
            }

            if (!dbContext.Rooms.Any())
            {
                Random random = new Random();
                int totalNumberOfRooms = 100;
                var roomsList = new List<Room>();
                var numberOfHotels = dbContext.Hotels.Count();
                var roomDescriptionArray = new[]
                { 
                    "A traditionally decorated room with a TV, tea and coffee-making facilities and a private shower." ,
                    "This double room is fully fitted with air-conditioning, flat screen TV, direct dial telephone, high-speed WiFi, hairdryer and a safe. The modern bathroom features a powerful shower.",
                    "This room includes a satellite TV, tea and coffee-making facilities, a hairdryer and a private bathroom.",
                    "This triple room has air conditioning, electric kettle, free wi-fi and hairdryer."
                };
                var numberOfBedsArray = new[] { 1, 1, 2, 2 };
                var capacityArray = new[] { 1, 2, 2, 3 };
                var roomImagesArray = new[]
                {
                    "~/pictures/single.jpg",
                    "~/pictures/double.jpg",
                    "~/pictures/twin.jpg",
                    "~/pictures/triple.jpg",
                };

                for (int i = 0; i < totalNumberOfRooms; i++)
                {
                    var index = random.Next(Enum.GetNames(typeof(RoomType)).Length);
                    var randomHotel = random.Next(1, numberOfHotels + 1);
                    roomsList.Add(new Room
                    {
                        RoomType = (RoomType)index,
                        RoomPrice = ((index + 1) * 200) + ((randomHotel + 1) * 50),
                        RoomDescription = roomDescriptionArray[index],
                        NumberOfBeds = numberOfBedsArray[index],
                        Capacity = capacityArray[index],
                        RoomImageUrl = roomImagesArray[index],
                        HotelId = randomHotel
                    });
                }

                dbContext.Rooms.AddRange(roomsList);
                await dbContext.SaveChangesAsync();
            }

            if (!dbContext.HotelFacilities.Any())
            {
                var hotelFacilities = new HotelFacility[]
                {
                    new HotelFacility { HotelId=1, FacilityId=1},
                    new HotelFacility { HotelId=1, FacilityId=3},
                    new HotelFacility { HotelId=1, FacilityId=5},
                    new HotelFacility { HotelId=1, FacilityId=6},
                    new HotelFacility { HotelId=1, FacilityId=7},
                    new HotelFacility { HotelId=2, FacilityId=1},
                    new HotelFacility { HotelId=2, FacilityId=2},
                    new HotelFacility { HotelId=2, FacilityId=3},
                    new HotelFacility { HotelId=2, FacilityId=6},
                    new HotelFacility { HotelId=2, FacilityId=7},
                    new HotelFacility { HotelId=3, FacilityId=1},
                    new HotelFacility { HotelId=3, FacilityId=2},
                    new HotelFacility { HotelId=3, FacilityId=3},
                    new HotelFacility { HotelId=3, FacilityId=4},
                    new HotelFacility { HotelId=4, FacilityId=1},
                    new HotelFacility { HotelId=4, FacilityId=4},
                    new HotelFacility { HotelId=5, FacilityId=1},
                    new HotelFacility { HotelId=5, FacilityId=2},
                    new HotelFacility { HotelId=5, FacilityId=3},
                    new HotelFacility { HotelId=6, FacilityId=1},
                    new HotelFacility { HotelId=6, FacilityId=5},
                    new HotelFacility { HotelId=6, FacilityId=7},
                };

                dbContext.HotelFacilities.AddRange(hotelFacilities);
                await dbContext.SaveChangesAsync();
            }
        }
    }
}
