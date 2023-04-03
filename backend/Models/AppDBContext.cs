using Microsoft.EntityFrameworkCore;
using CZConnect.Models;

namespace CZConnect.Models;

public class AppDBContext : DbContext
{
    public AppDBContext(DbContextOptions options) : base(options) { }

    public DbSet<Referral> Referrals { get; set; }
    public DbSet<Employee> Employees {get; set;}
    public DbSet<ApplicantForm> ApplicantForms { get; set; }

    protected override void OnModelCreating(ModelBuilder modelBuilder){
        modelBuilder.Entity<Referral>().HasData(
            new Referral { id = 1, status = "Afgerond", employeeName = "CZ-Medewerker", participantName = "Coen", participantEmail = "cmberge@avans.nl" , registrationDate = DateTime.Now },
            new Referral { id = 2, status = "In afwachting", employeeName = "CZ-Medewerker", participantName = "Marijn 1", participantEmail = "m1@avans.nl" , registrationDate = DateTime.Now },
            new Referral { id = 3, status = "Afgerond", employeeName = "CZ-Medewerker", participantName = "Marijn 2", participantEmail = "m2@avans.nl" , registrationDate = DateTime.Now },
            new Referral { id = 4, status = "Afgerond", employeeName = "CZ-Medewerker", participantName = "Jos", participantEmail = "jos@avans.nl" , registrationDate = DateTime.Now },
            new Referral { id = 5, status = "Afgerond", employeeName = "CZ-Medewerker", participantName = "Jedrek", participantEmail = "jedrek@avans.nl" , registrationDate = DateTime.Now },
            new Referral { id = 6, status = "In afwachting", employeeName = "CZ-Medewerker", participantName = "William", participantEmail = "wballeko@avans.nl" , registrationDate = DateTime.Now }
        );
    }
}