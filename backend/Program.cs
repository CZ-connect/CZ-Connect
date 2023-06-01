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
    options.UseSqlServer(builder.Configuration.GetConnectionString({{Git}} ??"CZConnectDatabase")));

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
app.UseSwagger();

if (app.Environment.IsDevelopment())
{
    app.UseSwaggerUI();
}
// Run all migrations on runtime
using (var scope = app.Services.CreateScope())
{
    var db = scope.ServiceProvider.GetRequiredService<AppDBContext>();
    db.Database.Migrate();
    app.UseItToSeedSqlServer();
}

app.Run();