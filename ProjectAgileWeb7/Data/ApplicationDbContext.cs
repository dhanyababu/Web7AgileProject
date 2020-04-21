using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;
using ProjectAgileWeb7.Models;


namespace ProjectAgileWeb7.Data
{
    public class ApplicationDbContext : IdentityDbContext<ApplicationUser>
    {
        public DbSet<ApplicationUser> ApplicationUsers { get; set; }

        public ApplicationDbContext()
        {

        }
        public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options)
            : base(options)
        {
        }

        public DbSet<Hotel> Hotels { get; set; }
        public DbSet<Room> Rooms { get; set; }
        public DbSet<Facility> Facilities { get; set; }

        public DbSet<HotelFacility> HotelFacilities { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);
            modelBuilder.Entity<HotelFacility>()
                .HasKey(hf => new { hf.HotelId, hf.FacilityId });
            modelBuilder.Entity<HotelFacility>()
                .HasOne(hf => hf.Hotel)
                .WithMany(h => h.HotelFacilities)
                .HasForeignKey(hf => hf.HotelId);
            modelBuilder.Entity<HotelFacility>()
                .HasOne(hf => hf.Facility)
                .WithMany(f => f.HotelFacilities)
                .HasForeignKey(hf => hf.FacilityId);
        }
    }
}
