using ManufacturingERP.Entity.Models;
using ManufacturingERP.Data;
using ManufacturingERP.Entity;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Threading.Tasks;

public class VendorRepository : IVendorRepository
{
    private readonly AppDbContext _context;

    public VendorRepository(AppDbContext context)
    {
        _context = context;
    }

    public async Task<IEnumerable<Vendor>> GetAllVendorsAsync()
    {
        return await _context.Vendors
            .Include(v => v.RawMaterials) // Ensure RawMaterials are included
            .ToListAsync();
    }

    public async Task<Vendor> GetVendorByIdAsync(int id)
    {
        return await _context.Vendors
            .Include(v => v.RawMaterials)  // Ensure RawMaterials are included
            .FirstOrDefaultAsync(v => v.VendorId == id);
    }

    public async Task AddVendorAsync(Vendor vendor)
    {
        // Normalize Status field
        vendor.Status = vendor.Status?.Trim().ToLower() switch
        {
            "active" => "Active",
            "inactive" => "Inactive",
            _ => "Active" // Default value
        };

        vendor.CreatedDate = vendor.CreatedDate ?? DateTime.UtcNow;
        vendor.ModifiedDate = DateTime.UtcNow;

        // Ensure RawMaterials is initialized
        if (vendor.RawMaterials == null)
        {
            vendor.RawMaterials = new List<RawMaterial>();
        }

        await _context.Vendors.AddAsync(vendor);
        await _context.SaveChangesAsync();
    }

    public async Task UpdateVendorAsync(Vendor vendor)
    {
        // Normalize Status field
        vendor.Status = vendor.Status?.Trim().ToLower() switch
        {
            "active" => "Active",
            "inactive" => "Inactive",
            _ => "Active"
        };

        vendor.ModifiedDate = DateTime.UtcNow;

        // Attach entity if not already tracked
        var existingVendor = await _context.Vendors
            .Include(v => v.RawMaterials)
            .FirstOrDefaultAsync(v => v.VendorId == vendor.VendorId);

        if (existingVendor != null)
        {
            _context.Entry(existingVendor).CurrentValues.SetValues(vendor);
            existingVendor.RawMaterials = vendor.RawMaterials; // Ensure RawMaterials are updated
        }
        else
        {
            _context.Vendors.Update(vendor);
        }

        await _context.SaveChangesAsync();
    }

    public async Task DeleteVendorAsync(int id)
    {
        var vendor = await _context.Vendors.FindAsync(id);
        if (vendor != null)
        {
            _context.Vendors.Remove(vendor);
            await _context.SaveChangesAsync();
        }
    }
    public async Task<bool> HasRawMaterialsAsync(int vendorId)
    {
        return await _context.RawMaterials.AnyAsync(rm => rm.VendorId == vendorId);
    }

    public async Task<IEnumerable<Vendor>> GetAllVendorsWithRawMaterialsAsync()
    {
        return await _context.Vendors
            .Include(v => v.RawMaterials) // Ensure RawMaterials are loaded
            .ToListAsync();
    }
    public async Task<IEnumerable<Vendor>> GetAllVendorsWithPurchaseOrderAsync()
    {
        return await _context.Vendors
            .Include(v => v.RawMaterials) // Ensure RawMaterials are loaded
            .ToListAsync();
    }

}


