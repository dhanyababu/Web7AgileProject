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
            dbContext.Database.EnsureDeleted();
            dbContext.Database.EnsureCreated();


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
                        ImageUrl="https://q-cf.bstatic.com/images/hotel/max1280x900/195/195274734.jpg"
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
                        ImageUrl="https://r-cf.bstatic.com/images/hotel/max1280x900/188/188474168.jpg"
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
                        ImageUrl="https://r-cf.bstatic.com/images/hotel/max1024x768/177/177954582.jpg"
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
                var rooms = new Room[]
                {
                    new Room
                    {
                         RoomType= RoomType.Single,
                         RoomPrice=500,
                         RoomDescription="A traditionally decorated room with a TV, tea and coffee-making facilities and a private shower.",
                         NumberOfBeds=1,
                         Capacity=1,
                         IsAvailable=true
                    },
                    new Room
                    {
                         RoomType= RoomType.Double,
                         RoomPrice=800,
                         RoomDescription="This double room is fully fitted with air-conditioning, flat screen TV, direct dial telephone, high-speed WiFi, hairdryer and a safe. The modern bathroom features a powerful shower.",
                         NumberOfBeds=1,
                         Capacity=2,
                         IsAvailable=true
                    },
                    new Room
                    {
                         RoomType= RoomType.Twin,
                         RoomPrice=750,
                         RoomDescription="This room includes a satellite TV, tea and coffee-making facilities, a hairdryer and a private bathroom.",
                         NumberOfBeds=2,
                         Capacity=2,
                         IsAvailable=true
                    },
                    new Room
                    {
                         RoomType= RoomType.Triple,
                         RoomPrice=800,
                         RoomDescription="This triple room has air conditioning, electric kettle, free wi-fi and hairdryer.",
                         NumberOfBeds=2,
                         Capacity=3,
                         IsAvailable=true
                    }

                };

                dbContext.Rooms.AddRange(rooms);
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
                }
                };

                dbContext.HotelFacilities.AddRange(hotelFacilities);
                dbContext.SaveChanges();
            }

            if (!dbContext.HotelRooms.Any())
            {
                Random random = new Random();
                int numberOfHotels = dbContext.Hotels.Count();
                int numberOfRooms = dbContext.Rooms.Count();
                var hotelRooms = new List<HotelRoom>();
                //var hotelRooms1 = new HotelRoom[100];

                for (int i = 1; i < numberOfHotels + 1; i++)
                {
                    for (int j = 1; j < numberOfRooms + 1; j++)
                    {
                        var hotelRoom = new HotelRoom
                        {
                            HotelId = i,
                            RoomId = j
                        };
                        hotelRooms.Add(hotelRoom);
                    }
                }


                dbContext.HotelRooms.AddRange(hotelRooms);
                dbContext.SaveChanges();
            }



        }
    }
}
