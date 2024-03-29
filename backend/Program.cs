using System.Text.Json.Serialization;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.SqlServer;
using CZConnect.Models;
using CZConnect.DAL;
using System.Text.Json.Serialization;
using Microsoft.Extensions.DependencyInjection;

var builder = WebApplication.CreateBuilder(args);

// Dependency injection
builder.Services.AddScoped<IRepository, Repository<AppDBContext>>();
builder.Services.AddDbContext<AppDBContext>(options =>
    options.UseSqlServer(builder.Configuration.GetConnectionString("CZConnectDatabase")));


builder.Services.AddScoped<DbInit>();
builder.Services.AddSwaggerGen();
builder.Services.AddControllers().AddJsonOptions(options =>
    options.JsonSerializerOptions.Converters
        .Add(new JsonStringEnumConverter()));


var app = builder.Build();

//todo remove this
app.UseCors(x => x
    .AllowAnyMethod()
    .AllowAnyHeader()
    .SetIsOriginAllowed(origin => true)
    .AllowCredentials());
app.UseAuthorization();
app.MapControllers();

if (app.Environment.IsDevelopment())
{

    app.UseSwaggerUI();
    using var scope = app.Services.CreateScope();
    try
    {
        var db = scope.ServiceProvider.GetRequiredService<AppDBContext>();
        db.Database.Migrate(); // your existing line to apply migrations
        app.UseItToSeedSqlServer(); // your existing line to seed the database
        
        
        var data = db.Set<Employee>().FirstOrDefault();

        Console.WriteLine("Connection successful.");
      
    }
    catch (Exception ex)
    {
        
        Console.WriteLine($"Connection failed: {ex.Message}");
   
       // throw new Exception(ex.Message + ""+ ex.Data);
    }

}



app.Run();