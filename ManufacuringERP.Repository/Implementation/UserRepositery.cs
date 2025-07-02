
using Microsoft.EntityFrameworkCore;
using System.Threading.Tasks;
using System.Linq;
using ManufacturingERP.Data;
using ManufacuringERP.Entity;
using ManufacturingERP.Entity;

namespace ManufacturingERP.Repository
{
    public class UserRepository : IUserRepository
    {
        private readonly AppDbContext _context;

        public UserRepository(AppDbContext context)
        {
            _context = context;
        }

        // Register User (Saves to Database)
        public async Task<bool> RegisterUser(User user)
        {
            if (user != null)
            {
                _context.Users.Add(user);
                await _context.SaveChangesAsync();
                return true;
            }
            return false;
        }

        // Validate User for Login
        public User ValidateUser(string email, string password)
        {
            return _context.Users.FirstOrDefault(u => u.Email == email && u.Password == password);
        }
    }
}
