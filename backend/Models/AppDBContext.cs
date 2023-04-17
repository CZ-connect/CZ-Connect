using Microsoft.EntityFrameworkCore;
using CZConnect.Models;

namespace CZConnect.Models;

public class AppDBContext : DbContext
{
    public AppDBContext(DbContextOptions options) : base(options) { }

    public DbSet<Referral> Referrals { get; set; }
    public DbSet<Employee> Employees {get; set;}
    public DbSet<ApplicantForm> ApplicantForms { get; set; }

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder
            .Entity<Employee>()
            .Property(e => e.Role)
            .HasConversion(
                v => v.ToString(),                
                v => (EmployeeRoles)Enum.Parse(typeof(EmployeeRoles), v));
    }
}