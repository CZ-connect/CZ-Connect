using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.SqlServer;
using CZConnect.Models;
using CZConnect.DAL;

var builder = WebApplication.CreateBuilder(args);

// Dependency injection
builder.Services.AddScoped<IRepository, Repository<AppDBContext>>();

builder.Services.AddDbContext<AppDBContext>(options =>
    options.UseSqlServer(builder.Configuration.GetConnectionString("CZConnectDatabase")));
builder.Services.AddScoped<DbInit>();

builder.Services.AddControllers();

var app = builder.Build();
app.UseCors(x => x
    .AllowAnyMethod()
    .AllowAnyHeader()
    .SetIsOriginAllowed(origin => true)
    .AllowCredentials());
app.UseAuthorization();
app.MapControllers();

// Run all migrations on runtime
using (var scope = app.Services.CreateScope())
{
    var db = scope.ServiceProvider.GetRequiredService<AppDBContext>();
    db.Database.Migrate();
    app.UseItToSeedSqlServer(); 
}

app.Run();
