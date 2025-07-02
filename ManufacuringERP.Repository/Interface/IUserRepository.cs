using ManufacturingERP.Entity;
using ManufacturingERP.Repository;
using ManufacuringERP.Entity;

namespace ManufacturingERP.Repository
{
    public interface IUserRepository
    {
        Task<bool> RegisterUser(User user);  // Saves user in DB
        User ValidateUser(string email, string password);  // Validates login
    }
}
