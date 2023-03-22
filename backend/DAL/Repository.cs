using System.Collections.Generic;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using CZConnect.Models;

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

    public Task<List<T>> SelectMultipleByIdAsync<T>(long id) where T : class
    {
       return this._db.Set<T>().ToListAsync();
    }
}