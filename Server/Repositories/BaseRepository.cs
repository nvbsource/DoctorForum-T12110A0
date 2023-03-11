using System;
using Doctors_Forum_Server.Data;
using Microsoft.EntityFrameworkCore;

namespace Doctors_Forum_Server.Repositories
{
    public class BaseRepository<T> : IRepository<T> where T : class
    {
        public readonly ApplicationContext _context;
        public BaseRepository(ApplicationContext context)
        {
            _context = context;
        }

        public async Task<IEnumerable<T>> FindAll()
        {
            return await _context.Set<T>().ToListAsync();
        }

        public async Task<T?> FindOne(int id)
        {
            return await _context.Set<T>().FindAsync(id);
        }

        public async Task Update(T entity)
        {
            _context.Set<T>().Update(entity);
            await _context.SaveChangesAsync();
        }

        public async Task<T> Create(T entity)
        {
            await _context.Set<T>().AddAsync(entity);
            await _context.SaveChangesAsync();
            return entity;
        }

        public async Task Delete(int id)
        {
            var entity = await _context.Set<T>().FindAsync(id);
            if (entity != null)
            {
                _context.Set<T>().Remove(entity);
                await _context.SaveChangesAsync();
            }
        }

        public async Task AddRange(List<T> entityList)
        {
            await _context.Set<T>().AddRangeAsync(entityList);
            await _context.SaveChangesAsync();
        }
    }
}
