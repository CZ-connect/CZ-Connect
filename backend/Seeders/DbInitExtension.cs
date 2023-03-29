
using CZConnect.Models;

internal static class DbInitExtension
{
    public static IApplicationBuilder UseItToSeedSqlServer(this IApplicationBuilder app)
    {
        ArgumentNullException.ThrowIfNull(app, nameof(app));

        using var scope = app.ApplicationServices.CreateScope();
        var services = scope.ServiceProvider;
        try
        {
            var context = services.GetRequiredService<AppDBContext>();
            DbInit.Initialize(context);
        }
        catch (Exception ex)
        {
            throw ex;
        }

        return app;
    }
}