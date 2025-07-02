using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using ManufacturingERP.Data;
using ManufacuringERP.Entity.Model;
using ManufacuringERP.Repository.Interface;
using Microsoft.EntityFrameworkCore;

namespace ManufacuringERP.Repository.Implementation
{
    public class InventoryRepository : IInventoryRepository
    {
        private readonly AppDbContext _context;

        public InventoryRepository(AppDbContext context)
        {
            _context = context;
        }

        public IEnumerable<Inventory> GetAll()
        {
            return _context.Inventories.Include(i => i.MaterialName).ToList();
        }

        public Inventory GetById(int id)
        {
            return _context.Inventories
                           .Include(i => i.MaterialName)
                           .FirstOrDefault(i => i.InventoryId == id);
        }

        public void Add(Inventory inventory)
        {
            _context.Inventories.Add(inventory);
            _context.SaveChanges();
        }

        public void Update(Inventory inventory)
        {
            _context.Inventories.Update(inventory);
            _context.SaveChanges();
        }

        public void Delete(int id)
        {
            var inventory = _context.Inventories.Find(id);
            if (inventory != null)
            {
                _context.Inventories.Remove(inventory);
                _context.SaveChanges();
            }
        }
    }

}
