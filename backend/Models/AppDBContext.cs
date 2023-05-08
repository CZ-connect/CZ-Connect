using Microsoft.EntityFrameworkCore;

namespace CZConnect.Models;

public class AppDBContext : DbContext
{
    public AppDBContext(DbContextOptions options) : base(options) { }
    public DbSet<Referral> Referrals { get; set; }
    public DbSet<Employee> Employees { get; set;}
    public DbSet<ApplicantForm> ApplicantForms { get; set; }
    
    public DbSet<GraphData> GraphData { get; set; }

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder
            .Entity<Employee>()
            .Property(e => e.Role)
            .HasConversion(
                v => v.ToString(),                
                v => (EmployeeRole)Enum.Parse(typeof(EmployeeRole), v));

        modelBuilder
            .Entity<Referral>()
            .Property(r => r.Status)
            .HasConversion(
                v => v.ToString(),                
                v => (ReferralStatus)Enum.Parse(typeof(ReferralStatus), v));
    } 

  
    
}