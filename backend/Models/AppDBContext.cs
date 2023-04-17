using Microsoft.EntityFrameworkCore;
using CZConnect.Models;

namespace CZConnect.Models;

public class AppDBContext : DbContext
{
    public AppDBContext(DbContextOptions options) : base(options) { }

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder
            .Entity<Referral>()
            .Property(r => r.Status)
            .HasConversion(
                v => v.ToString(),                
                v => (ReferralStatus)Enum.Parse(typeof(ReferralStatus), v));
    } 

    public DbSet<Referral> Referrals { get; set; }
    public DbSet<Employee> Employees {get; set;}
    public DbSet<ApplicantForm> ApplicantForms { get; set; }

}