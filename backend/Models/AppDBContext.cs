using Microsoft.EntityFrameworkCore;
using CZConnect.Models;

namespace CZConnect.Models;

public class AppDBContext : DbContext
{
    public AppDBContext(DbContextOptions options) : base(options) { }

    public DbSet<Referral> Referrals { get; set; }
    public DbSet<ApplicantForm> ApplicantForms { get; set; }
}