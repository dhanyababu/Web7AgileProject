using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Options;
using ProjectAgileWeb7.Data;
using ProjectAgileWeb7.Models;
using Microsoft.AspNetCore.Authentication.Google;
using System.Threading.Tasks;
using System;
using System.Globalization;

namespace ProjectAgileWeb7
{
    public class Startup
    {
        public Startup(IConfiguration configuration)
        {
            Configuration = configuration;
        }

        public IConfiguration Configuration { get; }

        // This method gets called by the runtime. Use this method to add services to the container.
        public void ConfigureServices(IServiceCollection services)
        {
            services.AddDbContext<ApplicationDbContext>(options =>
                options.UseSqlServer(
                    Configuration.GetConnectionString("DefaultConnection")));
            services.AddDefaultIdentity<ApplicationUser>(options => options.SignIn.RequireConfirmedAccount = false)
                .AddRoles<IdentityRole>()
                .AddEntityFrameworkStores<ApplicationDbContext>();
            //////services.AddIdentity<ApplicationUser, IdentityRole>(options => options.SignIn.RequireConfirmedAccount = false)
            //////    .AddDefaultTokenProviders()
            //////    .AddDefaultUI()
            //////    .AddRoles<IdentityRole>()
            //////    .AddEntityFrameworkStores<ApplicationDbContext>();
            //services.AddDefaultIdentity<ApplicationUser>(options => options.SignIn.RequireConfirmedAccount = false)
            //    .AddEntityFrameworkStores<ApplicationDbContext>();
            services.AddDistributedMemoryCache();

            services.AddSession();
            services.AddControllersWithViews();
            services.AddScoped<ApplicationDbContext>();

            services.AddAuthentication()
                .AddGoogle(options =>
                {
                    options.ClientId = "346232706638-4mhc073ul7db2is8ickqo6gp7q5th5hu.apps.googleusercontent.com";
                    options.ClientSecret = "dDxbxMoyLuDAJ42-1Fns5p46";
                });
                //.AddFacebook(options =>
                //{
                //    options.AppId = "238960640755122";
                //    options.AppSecret = "6485815bc32dc80d39e48720e4e62bab";
                //});

            services.AddRazorPages().AddRazorRuntimeCompilation();
        }

        // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
        public void Configure(IApplicationBuilder app, IWebHostEnvironment env, IServiceProvider serviceProvider)
        {
            var cultureInfo = new CultureInfo("en-US");
            //cultureInfo.NumberFormat.CurrencySymbol = "€";
            CultureInfo.DefaultThreadCurrentCulture = cultureInfo;
            CultureInfo.DefaultThreadCurrentUICulture = cultureInfo;

            if (env.IsDevelopment())
            {
                app.UseDeveloperExceptionPage();
                app.UseDatabaseErrorPage();
            }
            else
            {
                app.UseExceptionHandler("/Home/Error");
                // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
                app.UseHsts();
            }
            app.UseHttpsRedirection();
            app.UseStaticFiles();
            app.UseSession();

            app.UseRouting();

            app.UseAuthentication();
            app.UseAuthorization();

            app.UseEndpoints(endpoints =>
            {
                endpoints.MapFallbackToController(
                    action: "Index",
                    controller: "Home"
                    );

                endpoints.MapControllerRoute(
                    name: "default",
                    pattern: "{controller=Home}/{action=Index}/{id?}");
                endpoints.MapRazorPages();
            });
            CreateUserRoles(serviceProvider).Wait();
        }

        private async Task CreateUserRoles(IServiceProvider serviceProvider)
        {
            var roleManager = serviceProvider.GetRequiredService<RoleManager<IdentityRole>>();
            var userManager = serviceProvider.GetRequiredService<UserManager<ApplicationUser>>();

            string[] roles = { "Admin", "User" };
            IdentityResult result;

            foreach (var role in roles)
            {
                var roleAlreadyExists = await roleManager.RoleExistsAsync(role);
                if (!roleAlreadyExists)
                {
                    result = await roleManager.CreateAsync(new IdentityRole(role));
                }

                var admin = new ApplicationUser
                {
                    UserName = Configuration["AdminEmail"],
                    Email = Configuration["AdminEmail"]
                };
                var pw = Configuration["AdminPassword"];

                var user = await userManager.FindByNameAsync(Configuration["AdminEmail"]);
                if (user == null)
                {
                    var addAdmin = await userManager.CreateAsync(admin, pw);
                    if (addAdmin.Succeeded)
                    {
                        await userManager.AddToRoleAsync(admin, "Admin");
                    }
                }
            }
        }
    }
}
