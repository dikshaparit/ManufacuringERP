using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using ManufacturingERP.Data;
using ManufacturingERP.Entity;
using ManufacturingERP.Entity.Models;

//using ManufacturingERP.Entity.Model;
using ManufacuringERP.Entity.Model;
using ManufacuringERP.Repository.Interface;
using Microsoft.EntityFrameworkCore;
namespace ManufacuringERP.Repository.Implementation
{
    

    public class PurchaseOrderTrackRepository : IPurchaseOrderTrackRepository
    {
        private readonly AppDbContext _context;

        public PurchaseOrderTrackRepository(AppDbContext context)
        {
            _context = context;
        }

        public async Task<IEnumerable<PurchaseOrder>> GetAllPurchaseOrdersAsync()
        {
            return await _context.PurchaseOrders.ToListAsync();
        }

        public async Task<PurchaseOrder> GetPurchaseOrderByIdAsync(int purchaseOrderId)
        {
            return await _context.PurchaseOrders
                .Include(po => po.Vendor)
                .FirstOrDefaultAsync(po => po.PurchaseOrderId == purchaseOrderId);
        }

        public async Task AddPurchaseOrderTrackAsync(PurchaseOrderTrack track)
        {
            _context.PurchaseOrderTracks.Add(track);
            await _context.SaveChangesAsync();
        }

        public async Task<IEnumerable<PurchaseOrderTrack>> GetAllTracksAsync()
        {
            return await _context.PurchaseOrderTracks
                .Include(t => t.PurchaseOrder)
                .ToListAsync();
        }
        public async Task<List<Vendor>> GetVendorsByIdsAsync(List<int> vendorIds)
        {
            return await _context.Vendors
                .Where(v => vendorIds.Contains(v.VendorId))
                .ToListAsync();
        }
        public async Task<IEnumerable<PurchaseOrderTrack>> GetAllWithVendorAsync()
        {
            return await _context.PurchaseOrderTracks
                                 .Include(po => po.Vendor)  // This loads the related Vendor entity
                                 .ToListAsync();
        }

        // ✅ Add this below:
        public async Task<decimal> GetTotalPriceByPurchaseOrderIdAsync(int purchaseOrderId)
        {
            return await _context.PurchaseOrderItems
                .Where(item => item.PurchaseOrderId == purchaseOrderId)
                .SumAsync(item => item.TotalPrice);
        }
        public async Task<decimal> GetGrandTotalByPurchaseOrderIdAsync(int purchaseOrderId)
        {
            var totalPrice = await _context.PurchaseOrderItems
                .Where(item => item.PurchaseOrderId == purchaseOrderId)
                .SumAsync(item => item.TotalPrice); // Sum of all TotalPrice values from PurchaseOrderItems

            return totalPrice;
        }

        public async Task<List<PurchaseOrderItem>> GetPurchaseOrderItemsByPurchaseOrderIdAsync(int purchaseOrderId)
        {
            // Fetch PurchaseOrderItems for the given PurchaseOrderId
            return await _context.PurchaseOrderItems
                                 .Where(item => item.PurchaseOrderId == purchaseOrderId)
                                 .ToListAsync();
        }
        public async Task<PurchaseOrderTrack> GetByIdWithItemsAsync(int id)
        {
            return await _context.PurchaseOrderTracks
                //.Include(p => p.PurchaseOrderTrackItems)
                .FirstOrDefaultAsync(p => p.PurchaseOrderTrackId == id);
        }
        public async Task DeleteAsync(int id)
        {
            var entity = await _context.PurchaseOrderTracks.FindAsync(id);
            if (entity != null)
            {
                _context.PurchaseOrderTracks.Remove(entity);
                await _context.SaveChangesAsync();
            }
        }
        // Implement the method to fetch GRNItems by PurchaseOrderId
        public async Task<List<GRNItem>> GetGRNItemsByPurchaseOrderIdAsync(int purchaseOrderId)
        {
            return await _context.GRNItems
                .Where(g => g.PurchaseOrderItem.PurchaseOrderId == purchaseOrderId)
                .ToListAsync();
        }
        public async Task<int> GetActualQuantityByPOCodeAsync(int purchaseOrderId)
        {
            // Query the GRNItems table and sum up the ActualQuantity based on PurchaseOrderId
            var actualQuantity = await _context.GRNItems
                .Where(g => g.PurchaseOrderItem.PurchaseOrderId == purchaseOrderId)
                .SumAsync(g => g.ActualQuantity);

            return actualQuantity;
        }
        public async Task<int> GetActualQuantityByPurchaseOrderIdAsync(int purchaseOrderId)
        {
            var actualQuantity = await _context.GRNItems
                .Where(g => g.PurchaseOrderItem.PurchaseOrderId == purchaseOrderId)
                .SumAsync(g => (int?)g.ActualQuantity ?? 0);

            return actualQuantity;
        }
        public async Task AddAsync(PurchaseOrderTrack model)
        {
            _context.PurchaseOrderTracks.Add(model); // Includes children if they are populated
            await _context.SaveChangesAsync();
        }


        public async Task<PurchaseOrderTrack> GetPurchaseOrderTrackWithVendorAsync(int id)
        {
            return await _context.PurchaseOrderTracks
                                 .Include(p => p.Vendor)  // Assuming there is a navigation property
                                 .FirstOrDefaultAsync(p => p.PurchaseOrderTrackId == id);
        }
        public async Task AddPurchaseOrderTrackItemAsync(PurchaseOrderTrackItem item)
        {
            _context.PurchaseOrderTrackItems.Add(item);
            await _context.SaveChangesAsync();
        }

        public async Task<List<PurchaseOrderTrackItem>> GetPurchaseOrderTrackItemsByTrackIdAsync(int trackId)
    {
        return await _context.PurchaseOrderTrackItems
            .Where(item => item.PurchaseOrderTrackId == trackId)
            .ToListAsync();
    }
        public async Task<List<PurchaseOrderTrack>> GetAllWithItemsAsync()
        {
            return await _context.PurchaseOrderTracks
                .Include(track => track.PurchaseOrderTrackItems)
                .Include(track => track.Vendor)
                .AsNoTracking()
                .ToListAsync();
        }
        public async Task<List<PurchaseOrderTrack>> GetAllPurchaseOrderTracksAsync()
        {
            return await _context.PurchaseOrderTracks
                .Include(t => t.PurchaseOrderTrackItems)
                .Include(t => t.PurchaseOrder) // Optional: to show POCode or Vendor
                .ToListAsync();
        }
        public async Task<List<GRN>> GetGRNsByPurchaseOrderIdAsync(int purchaseOrderId)
        {
            return await _context.GRNs
                .Include(g => g.GRNItems)
                .Where(g => g.PurchaseOrderId == purchaseOrderId)
                .ToListAsync();
        }


    }

}
