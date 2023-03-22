using Microsoft.EntityFrameworkCore;
using System.Linq.Expressions;

namespace CZConnect.DAL;

public class Repository<TDbContext> : IRepository where TDbContext : DbContext
{
    private TDbContext _db;

    public Repository(TDbContext context) =>
        this._db = context;
    
    public Task<List<T>> AllAsync<T>() where T : class
    {
        return this._db.Set<T>().ToListAsync();
    }

    public Task<List<T>> AllAsync<T>(Expression<Func<T, bool>>? filter = null) where T : class
    {
        IQueryable<T> query = this._db.Set<T>();
        if (filter != null)
        {
            query = query.Where(filter);
        }
        return query.ToListAsync();
    }

    public ValueTask<T?> SelectByIdAsync<T>(long id) where T : class
    {
        return this._db.Set<T>().FindAsync(id);
    }

    public async Task CreateAsync<T>(T entity) where T : class
    {
        this._db.Set<T>().Add(entity);
        await this._db.SaveChangesAsync();
    }

    public async Task UpdateAsync<T>(T entity) where T : class
    {
        this._db.Set<T>().Update(entity);
        await this._db.SaveChangesAsync();
    }

    public async Task DeleteAsync<T>(T entity) where T : class
    {
        this._db.Set<T>().Remove(entity);
        await this._db.SaveChangesAsync();
    }
}