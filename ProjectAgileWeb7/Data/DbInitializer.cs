using ProjectAgileWeb7.Models;
using System.Linq;

namespace ProjectAgileWeb7.Data
{
    public static class DbInitializer
    {
        public static void Initialize(ApplicationDbContext dbContext)
        {
            //dbContext.Database.EnsureDeleted();
            dbContext.Database.EnsureCreated();

            if (!dbContext.Hotels.Any())
            {
                var hotels = new Hotel[]
                {
                    new Hotel
                    {
                        Name="Ritz Paris",
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
                        ImageUrl="~/images/ritz.jpg",
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
                        ImageUrl="~/images/corinthia.jpg"
                    }
                };

                dbContext.Hotels.AddRange(hotels);
                dbContext.SaveChanges();
            }
        }
    }
}
