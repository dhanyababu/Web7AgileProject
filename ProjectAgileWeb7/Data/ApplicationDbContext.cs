using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;
using ProjectAgileWeb7.Models;

namespace ProjectAgileWeb7.Data
{
    public class ApplicationDbContext : IdentityDbContext<User>
    {
        //public DbSet<User> Users { get; set; }

        public ApplicationDbContext(DbContextOptions options)
            : base(options)
        {
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);

            //modelBuilder.ApplyConfiguration(new RoleConfiguration());
        }
    }
}
