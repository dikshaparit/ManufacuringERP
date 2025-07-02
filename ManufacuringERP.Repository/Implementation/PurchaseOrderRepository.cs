using ManufacturingERP.Data;
using ManufacturingERP.Entity;
using ManufacturingERP.Repository.Interface;
using Microsoft.EntityFrameworkCore;
using System.Collections.Generic;
using System.Threading.Tasks;
using System.Web.Mvc;

namespace ManufacturingERP.Repository.Implementation
{
    public class PurchaseOrderRepository : IPurchaseOrderRepository
    {
        private readonly AppDbContext _context;

        public PurchaseOrderRepository(AppDbContext context)
        {
            _context = context;
        }

        // Get All Purchase Orders with Vendor and Items
        public async Task<IEnumerable<PurchaseOrder>> GetAllAsync()
        {
            return await _context.PurchaseOrders
                .Include(po => po.Vendor)
                .Include(po => po.PurchaseOrderItems)
                .ToListAsync();
        }

        // Get Purchase Order by Id (updated to include child items)
        public async Task<PurchaseOrder> GetByIdAsync(int id)
        {
            return await _context.PurchaseOrders
                .Include(po => po.PurchaseOrderItems) // ✅ Include child items
                .FirstOrDefaultAsync(po => po.PurchaseOrderId == id);
        }

        // Get Purchase Order by Id with Vendor and Items (detailed)
        public async Task<PurchaseOrder> GetByIdWithItemsAsync(int id)
        {
            return await _context.PurchaseOrders
                .Include(po => po.Vendor)
                .Include(po => po.PurchaseOrderItems)
                .FirstOrDefaultAsync(po => po.PurchaseOrderId == id);
        }

        // Get Purchase Order by Id with GRN (GRN details)
        public async Task<PurchaseOrder> GetByIdWithGRNAsync(int id)
        {
            return await _context.PurchaseOrders
                .Include(po => po.Vendor)
                .Include(po => po.PurchaseOrderItems)
                .Include(po => po.GRNs) // Assuming GRN is a navigation property in PurchaseOrder
                .FirstOrDefaultAsync(po => po.PurchaseOrderId == id);
        }

        // Add new Purchase Order
        public async Task AddAsync(PurchaseOrder purchaseOrder)
        {
            await _context.PurchaseOrders.AddAsync(purchaseOrder);
            await _context.SaveChangesAsync();
        }

        // Update Purchase Order
        public async Task UpdateAsync(PurchaseOrder purchaseOrder)
        {
            _context.PurchaseOrders.Update(purchaseOrder);
            await _context.SaveChangesAsync();
        }

        // Delete Purchase Order and related Items
        public async Task DeleteAsync(int id)
        {
            var purchaseOrder = await GetByIdWithItemsAsync(id);
            if (purchaseOrder != null)
            {
                _context.PurchaseOrders.Remove(purchaseOrder);
                await _context.SaveChangesAsync();
            }
        }

        // Get GRNs by PurchaseOrderId including GRNItems and their PurchaseOrderItem
        public async Task<IEnumerable<GRN>> GetGRNsByPurchaseOrderIdAsync(int purchaseOrderId)
        {
            return await _context.GRNs
                .Where(grn => grn.PurchaseOrderId == purchaseOrderId)
                .Include(grn => grn.GRNItems)
                    .ThenInclude(grnItem => grnItem.PurchaseOrderItem) // optional: include PurchaseOrderItem
                .ToListAsync();
        }

        // Get only GRNItems associated with a given PurchaseOrderId
        public async Task<IEnumerable<GRNItem>> GetGRNItemsByPurchaseOrderIdAsync(int purchaseOrderId)
        {
            return await _context.GRNItems
                .Include(item => item.GRN)
                .Include(item => item.PurchaseOrderItem)
                .Where(item => item.GRN.PurchaseOrderId == purchaseOrderId)
                .ToListAsync();
        }
        // Implementing GetByPurchaseOrderIdAsync
        // Get PurchaseOrder by PurchaseOrderId
        public async Task<PurchaseOrder> GetByPurchaseOrderIdAsync(int purchaseOrderId)
        {
            return await _context.PurchaseOrders
                                 .Include(po => po.PurchaseOrderItems)
                                 .FirstOrDefaultAsync(po => po.PurchaseOrderId == purchaseOrderId);
        }

        // Get PurchaseOrderItem by PurchaseOrderItemId
        public async Task<PurchaseOrderItem> GetPurchaseOrderItemByIdAsync(int purchaseOrderItemId)
        {
            return await _context.PurchaseOrderItems
                .FirstOrDefaultAsync(poi => poi.PurchaseOrderItemId == purchaseOrderItemId);
        }

        public async Task<List<SelectListItem>> GetPurchaseOrderDropdownAsync()
        {
            return await _context.PurchaseOrders
                .Select(po => new SelectListItem
                {
                    Value = po.PurchaseOrderId.ToString(),
                    Text = po.POCode
                })
                .ToListAsync();
        }
       

        public async Task<decimal> GetTotalPriceByPurchaseOrderItemIdAsync(int purchaseOrderId)
        {
            return await _context.PurchaseOrderItems
                 .Where(item => item.PurchaseOrderId == purchaseOrderId)
                 .SumAsync(item => item.TotalPrice);
        }
        public async Task<PurchaseOrder> GetByPOCodeAsync(string poCode)
        {
            return await _context.PurchaseOrders
                .Include(po => po.PurchaseOrderItems) // include related items
                .FirstOrDefaultAsync(po => po.POCode == poCode);
        }
    }
}
