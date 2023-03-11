using System;

namespace Doctors_Forum_Server.Repositories
{
    public interface IRepository<T> where T : class
    {
        Task<IEnumerable<T>> FindAll();
        Task<T?> FindOne(int id);
        Task Update(T entity);
        Task<T> Create(T entity);
        Task AddRange(List<T> entityList);
        Task Delete(int id);
    }
}
