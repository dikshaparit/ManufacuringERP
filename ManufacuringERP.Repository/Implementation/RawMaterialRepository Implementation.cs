using ManufacturingERP.Data;
using ManufacturingERP.Entity;
using Microsoft.EntityFrameworkCore;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ManufacturingERP.Repository
{
    public class RawMaterialRepository : IRawMaterialRepository
    {
        private readonly AppDbContext _context;

        public RawMaterialRepository(AppDbContext context)
        {
            _context = context;
        }

        public async Task<IEnumerable<RawMaterial>> GetAllAsync()
        {
            return await _context.RawMaterials
                .Include(r => r.Vendor) // ✅ Ensure Vendor is included
                .ToListAsync();
        }

        public async Task<RawMaterial> GetByIdAsync(int id)
        {
            return await _context.RawMaterials
                .Include(r => r.Vendor) // ✅ Include Vendor when fetching a single record
                .FirstOrDefaultAsync(r => r.RawMaterialId == id);
        }

        public async Task AddAsync(RawMaterial rawMaterial)
        {
            await _context.RawMaterials.AddAsync(rawMaterial);
            await _context.SaveChangesAsync();
        }


        public async Task UpdateAsync(RawMaterial rawMaterial)
        {
            _context.RawMaterials.Update(rawMaterial);
            await _context.SaveChangesAsync();
        }

        public async Task DeleteAsync(int id)
        {
            var rawMaterial = await GetByIdAsync(id);
            if (rawMaterial != null)
            {
                _context.RawMaterials.Remove(rawMaterial);
                await _context.SaveChangesAsync();
            }
        }

        // ✅ Fetch all RawMaterials along with Purchase Orders (Only One Declaration)
       

        // ✅ Fetch distinct quantities based on VendorId
        public async Task<IEnumerable<int>> GetQuantitiesByVendorAsync(int vendorId)
        {
            return await _context.RawMaterials
                .Where(r => r.VendorId == vendorId)
                .Select(r => Convert.ToInt32(r.Quantity)) // ✅ Safe conversion to int
                .Distinct()
                .ToListAsync();
        }

    }
}
