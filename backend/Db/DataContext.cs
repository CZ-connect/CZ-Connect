using Microsoft.EntityFrameworkCore;
using CZConnect.Models;

namespace CZConnect.Db;

public class DataContext : DbContext
{
    public DataContext(DbContextOptions<DataContext> options) : base(options) { }

    public DbSet<Referral> Referrals { get; set; }
    public DbSet<Employee> Employees { get; set; }
}