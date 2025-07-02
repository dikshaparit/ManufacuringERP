using ManufacturingERP.Entity.Models;
using System.Collections.Generic;
using System.Threading.Tasks;

public interface IVendorRepository
{
    Task<IEnumerable<Vendor>> GetAllVendorsAsync();
    Task<Vendor> GetVendorByIdAsync(int id);
    Task AddVendorAsync(Vendor vendor);
    Task UpdateVendorAsync(Vendor vendor);
    Task DeleteVendorAsync(int id);
    Task<bool> HasRawMaterialsAsync(int vendorId);

    // New method to get vendors with their raw materials
    Task<IEnumerable<Vendor>> GetAllVendorsWithRawMaterialsAsync();

    Task<IEnumerable<Vendor>> GetAllVendorsWithPurchaseOrderAsync();
}
