using System.Linq.Expressions;
using Microsoft.Data.SqlClient;

namespace CZConnect.DAL
{
    public interface IRepository
    {
        Task<List<T>> AllAsync<T>() where T : class;
        Task<List<T>> AllAsync<T>(Expression<Func<T, bool>>? filter = null) where T : class;
        ValueTask<T?> SelectByIdAsync<T>(long id) where T : class;
        Task CreateAsync<T>(T entity) where T : class;
        Task UpdateAsync<T>(T entity) where T : class;
        Task DeleteAsync<T>(T entity) where T : class;
        Task<List<T>> ExecuteStoredProcedureAsync<T>(string storedProcedureName, params SqlParameter[] parameters) where T : class;
        Task<T?> FindByAsync<T>(Expression<Func<T, bool>> filter) where T : class;
    }
}