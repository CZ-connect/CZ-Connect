using Microsoft.EntityFrameworkCore;
using CZConnect.Models;

namespace CZConnect.Models;

public class AppDBContext : DbContext
{
    public AppDBContext(DbContextOptions options) : base(options) { }

    public DbSet<Referral> Referrals { get; set; }
    public DbSet<ApplicantForm> ApplicantForms { get; set; }

    protected override void OnModelCreating(ModelBuilder modelBuilder){
        modelBuilder.Entity<Referral>().HasData(
            new Referral { id = 1, status = "Aangemeld", participantName = "Coen", participantEmail = "cmberge@avans.nl" , registrationDate = DateTime.Now },
            new Referral { id = 2, status = "Aangenomen", participantName = "Marijn 1", participantEmail = "m1@avans.nl" , registrationDate = DateTime.Now },
            new Referral { id = 3, status = "Afgewezen", participantName = "Marijn 2", participantEmail = "m2@avans.nl" , registrationDate = DateTime.Now },
            new Referral { id = 4, status = "Aangemeld", participantName = "Jos", participantEmail = "jos@avans.nl" , registrationDate = DateTime.Now },
            new Referral { id = 5, status = "Aangenomen", participantName = "Jedrek", participantEmail = "jedrek@avans.nl" , registrationDate = DateTime.Now },
            new Referral { id = 6, status = "Afgewezen", participantName = "William", participantEmail = "wballeko@avans.nl" , registrationDate = DateTime.Now }
        );
    }
}