using Microsoft.EntityFrameworkCore;
using ProjectAgileWeb7.Models;
using System;
using System.Collections.Generic;
using System.Linq;

namespace ProjectAgileWeb7.Data
{
    public static class DbInitializer
    {
        public static void Initialize(ApplicationDbContext dbContext)
        {
            //dbContext.Database.EnsureDeleted();
            dbContext.Database.EnsureCreated();
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
                        Description="Located in Paris, 500 m from Opéra Garnier, Ritz Paris features a selection of bars and restaurants, a fitness center and a spa and wellness center which includes a pool, sauna and massage facilities.",
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
                        Description="The luxurious Corinthia Hotel is located in one of London’s most prestigious areas, moments from Trafalgar Square and Whitehall. It features elegant restaurants, 2 bars, a florist, London’s largest spa and the world's first hotel concession for Harrods.",
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
                        Description="Located in the heart of the city center, Eden Hotel Amsterdam offers warm-colored rooms and free WiFi. The famous Rembrandt Square is right around the corner. The central station is 10 minutes away by tram.",
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
                    }
                };

                dbContext.Hotels.AddRange(hotels);
                dbContext.SaveChanges();
            }

            if (!dbContext.Facilities.Any())
            {
                var facilities = new Facility[]
                {
                    new Facility
                    {
                        Name="Room service",
                        IsFree=false,
                        Price= 30
                    },
                    new Facility
                    {
                        Name= "Breakfast",
                        IsFree=false,
                        Price=25
                    },
                    new Facility
                    {
                        Name="Parking",
                        IsFree=true,
                        Price=0
                    },
                    new Facility
                    {
                        Name="Wi-fi",
                        IsFree=true,
                         Price=0
                    },
                    new Facility
                    {
                        Name="Fitness center",
                        IsFree=true,
                         Price=0

                    },
                    new Facility
                    {
                        Name="Pool",
                        IsFree=true,
                         Price=0
                    },
                    new Facility
                    {
                        Name="Sauna",
                        IsFree=true,
                         Price=0
                    }

                };

                dbContext.Facilities.AddRange(facilities);

                dbContext.SaveChanges();
            }

            if (!dbContext.Rooms.Any())
            {
                Random random = new Random();
                int totalNumberOfRooms = 100;
                var roomsList = new List<Room>();
                var numberOfHotels = dbContext.Hotels.Count();
                var roomDescriptionArray = new[]
                { "A traditionally decorated room with a TV, tea and coffee-making facilities and a private shower." ,
                "This double room is fully fitted with air-conditioning, flat screen TV, direct dial telephone, high-speed WiFi, hairdryer and a safe. The modern bathroom features a powerful shower.",
                "This room includes a satellite TV, tea and coffee-making facilities, a hairdryer and a private bathroom.",
                "This triple room has air conditioning, electric kettle, free wi-fi and hairdryer."
                };
                var numberOfBedsArray = new[] { 1, 1, 2, 2 };
                var capacityArray = new[] { 1, 2, 2, 3 };

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
                        IsAvailable = true,
                        HotelId = randomHotel
                    });
                }

                dbContext.Rooms.AddRange(roomsList);
                dbContext.SaveChanges();
            }

            if (!dbContext.HotelFacilities.Any())
            {

                var hotelFacilities = new HotelFacility[]
                {
                new HotelFacility
                {
                    HotelId=1,
                    FacilityId=1
                },
                new HotelFacility
                {
                    HotelId=1,
                    FacilityId=3
                },
                new HotelFacility
                {
                    HotelId=2,
                    FacilityId=5
                },
                new HotelFacility
                {
                    HotelId=3,
                    FacilityId=6
                },
                new HotelFacility
                {
                    HotelId=3,
                    FacilityId=1
                },
                new HotelFacility
                {
                    HotelId=3,
                    FacilityId=7
                },
                new HotelFacility
                {
                    HotelId=3,
                    FacilityId=4
                },
                new HotelFacility
                {
                    HotelId=3,
                    FacilityId=3
                },
                new HotelFacility
                {
                    HotelId=4,
                    FacilityId=1
                }
                };

                dbContext.HotelFacilities.AddRange(hotelFacilities);
                dbContext.SaveChanges();
            }
        }
    }
}
