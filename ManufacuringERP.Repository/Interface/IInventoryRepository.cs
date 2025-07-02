using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using ManufacuringERP.Entity.Model;

namespace ManufacuringERP.Repository.Interface
{
    public interface IInventoryRepository
    {
        // Get all Inventory items
        IEnumerable<Inventory> GetAll();

        // Get Inventory by Id
        Inventory GetById(int id);

        // Add new Inventory
        void Add(Inventory inventory);

        // Update existing Inventory
        void Update(Inventory inventory);

        // Delete Inventory
        void Delete(int id);
    }

}
