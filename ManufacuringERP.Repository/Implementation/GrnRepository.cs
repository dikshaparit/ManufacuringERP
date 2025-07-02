using ManufacturingERP.Data;
using ManufacturingERP.Entity;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Web.Mvc;

namespace ManufacturingERP.Repository
{
    public class GRNRepository : IGRNRepository
    {
        private readonly AppDbContext _context;

        public GRNRepository(AppDbContext context)
        {
            _context = context;
        }

        public async Task<IEnumerable<GRN>> GetAllAsync()
        {
            return await _context.GRNs
                .Include(g => g.Vendor)
                .ToListAsync();
        }

        public async Task<GRN> GetByIdWithItemsAsync(int id)
        {
            return await _context.GRNs
                .Include(g => g.GRNItems)
                .FirstOrDefaultAsync(g => g.GRNId == id);
        }

        public async Task AddAsync(GRN grn)
        {
            await _context.GRNs.AddAsync(grn);
            await _context.SaveChangesAsync();
        }

        public async Task AddGRNItemAsync(GRNItem grnItem)
        {
            await _context.GRNItems.AddAsync(grnItem);
            await _context.SaveChangesAsync();
        }

        public async Task UpdateAsync(GRN grn)
        {
            if (grn.GRNCode == null)
            {
                grn.GRNCode = "GRN-" + Guid.NewGuid().ToString();
            }

            _context.GRNs.Update(grn);
            await _context.SaveChangesAsync();
        }

        public async Task DeleteAsync(int id)
        {
            var grn = await _context.GRNs
                .Include(g => g.GRNItems)
                .FirstOrDefaultAsync(g => g.GRNId == id);

            if (grn != null)
            {
                _context.GRNs.Remove(grn);
                await _context.SaveChangesAsync();
            }
        }

        public async Task<List<GRNItem>> GetGRNItemsByPurchaseOrderIdAsync(string poCode)
        {
            var purchaseOrder = await _context.PurchaseOrders
                .Include(po => po.PurchaseOrderItems)
                .FirstOrDefaultAsync(po => po.POCode == poCode);

            if (purchaseOrder != null)
            {
                return purchaseOrder.PurchaseOrderItems.Select(item => new GRNItem
                {
                    MaterialType = item.MaterialType,
                    MaterialName = item.MaterialName,
                    Quantity = item.Quantity,
                    Unit = item.Unit,
                    ActualQuantity = 0
                }).ToList();
            }

            return new List<GRNItem>();
        }

        /// <summary>
        /// For each PurchaseOrderItem under this PO, returns a GRNItem whose
        /// Quantity = (PO.Quantity − total ActualQuantity already received).
        /// Items with zero or negative pending are filtered out.
        /// </summary>
        public async Task<List<GRNItem>> GetPendingGRNItemsByPurchaseOrderIdAsync(int purchaseOrderId)
        {
            // 1) Load PO items for this order
            var poItems = await _context.PurchaseOrderItems
                .Where(p => p.PurchaseOrderId == purchaseOrderId)
                .ToListAsync();

            // 2) Extract just the IDs into a List<int>
            var poItemIds = poItems
                .Select(p => p.PurchaseOrderItemId)
                .ToList();

            // 3) Now EF can translate this Contains
            var grnItems = await _context.GRNItems
                .Where(g => g.PurchaseOrderItemId.HasValue
                            && poItemIds.Contains(g.PurchaseOrderItemId.Value))
                .ToListAsync();

            // 4) Build your pending list
            var pendingItems = poItems
                .Select(poItem =>
                {
                    var totalActual = grnItems
                        .Where(g => g.PurchaseOrderItemId == poItem.PurchaseOrderItemId)
                        .Sum(g => g.ActualQuantity);

                    var pendingQty = poItem.Quantity - totalActual;

                    return new GRNItem
                    {
                        PurchaseOrderItemId = poItem.PurchaseOrderItemId,
                        MaterialType = poItem.MaterialType,
                        MaterialName = poItem.MaterialName,
                        Unit = poItem.Unit,
                        Quantity = pendingQty,
                        ActualQuantity = 0,
                        //PendingQuantity = pendingQty
                    };
                })
                .Where(i => i.Quantity > 0)
                .ToList();

            return pendingItems;
        }

        public string GenerateGRNCode()
        {
            var lastGRN = _context.GRNs.OrderByDescending(g => g.GRNId).FirstOrDefault();
            int nextNumber = (lastGRN != null) ? lastGRN.GRNId + 1 : 1;
            return $"GRN{nextNumber.ToString("D4")}";
        }

        public async Task<List<SelectListItem>> GetPurchaseOrdersForDropdownAsync()
        {
            return await _context.PurchaseOrders
                .Include(po => po.Vendor)
                .Select(po => new SelectListItem
                {
                    Value = po.POCode,
                    Text = po.Vendor.CompanyName
                })
                .ToListAsync();
        }

        public async Task<PurchaseOrder> GetPurchaseOrderByCodeAsync(string poCode)
        {
            return await _context.PurchaseOrders
                .FirstOrDefaultAsync(po => po.POCode == poCode);
        }
        public GRN GetByIdWithItems(int id)
        {
            return _context.GRNs
                .Include(g => g.Vendor)
                .Include(g => g.GRNItems)
                    .ThenInclude(i => i.PurchaseOrderItem)
                .FirstOrDefault(g => g.GRNId == id);
        }


        public async Task<List<GRN>> GetGRNsByPurchaseOrderIdAsync(int purchaseOrderId)
        {
            return await _context.GRNs
                .Include(g => g.GRNItems)
                .Where(g => g.PurchaseOrderId == purchaseOrderId)
                .ToListAsync();
        }
        public async Task<IEnumerable<GRN>> GetByPurchaseOrderIdAsync(int purchaseOrderId)
        {
            return await _context.GRNs
                .Where(g => g.PurchaseOrderId == purchaseOrderId)
                .Include(g => g.GRNItems) // Optional, if you want GRN items too
                .ToListAsync();
        }
        public async Task<GRN> GetLastGRNByPurchaseOrderIdAsync(int purchaseOrderId)
        {
            return await _context.GRNs
                .Include(g => g.GRNItems)
                .Where(g => g.PurchaseOrderId == purchaseOrderId)
                .FirstOrDefaultAsync();
        }

    }
}
