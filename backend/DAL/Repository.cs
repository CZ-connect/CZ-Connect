using System.Data;
using Microsoft.EntityFrameworkCore;
using System.Linq.Expressions;
using Microsoft.Data.SqlClient;

namespace CZConnect.DAL;

public class Repository<TDbContext> : IRepository where TDbContext : DbContext
{
    private TDbContext _db;

    public Repository(TDbContext context) =>
        _db = context;
    
    public Task<List<T>> AllAsync<T>() where T : class
    {
        return _db.Set<T>().ToListAsync();
    }

    public Task<List<T>> AllAsync<T>(Expression<Func<T, bool>>? filter = null) where T : class
    {
        IQueryable<T> query = _db.Set<T>();
        if (filter != null)
        {
            query = query.Where(filter);
        }
        return query.ToListAsync();
    }

    public ValueTask<T?> SelectByIdAsync<T>(long id) where T : class
    {
        return _db.Set<T>().FindAsync(id);
    }

    public async Task CreateAsync<T>(T entity) where T : class
    {
        _db.Set<T>().Add(entity);
        await _db.SaveChangesAsync();
    }

    public async Task UpdateAsync<T>(T entity) where T : class
    {
        _db.Entry(entity).State = EntityState.Modified;
        _db.Set<T>().Update(entity);
        await _db.SaveChangesAsync();
    }

    public async Task DeleteAsync<T>(T entity) where T : class
    {
        _db.Set<T>().Remove(entity);
        await _db.SaveChangesAsync();
    }

    public Task<List<T>> ExecuteStoredProcedureAsync<T>(string storedProcedureName, params SqlParameter[] parameters) where T : class
    {
        return _db.Set<T>().FromSqlRaw(storedProcedureName, parameters).ToListAsync();
    }

}