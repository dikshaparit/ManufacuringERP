using ManufacturingERP.Entity;
using ManufacturingERP.Entity.Models;
using System.Collections.Generic;
using System.Threading.Tasks;

public interface IRawMaterialRepository
{
    Task<IEnumerable<RawMaterial>> GetAllAsync();
    Task<RawMaterial> GetByIdAsync(int id);
    Task AddAsync(RawMaterial rawMaterial);
    Task UpdateAsync(RawMaterial rawMaterial);
    Task DeleteAsync(int id);
  
    Task<IEnumerable<int>> GetQuantitiesByVendorAsync(int vendorId); // ✅ Add this

}