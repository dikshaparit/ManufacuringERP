using ManufacturingERP.Entity;
using System.Collections.Generic;
using System.Threading.Tasks;
using System.Web.Mvc;

namespace ManufacturingERP.Repository.Interface
{
    public interface IPurchaseOrderRepository
    {
        // Get all purchase orders
        Task<IEnumerable<PurchaseOrder>> GetAllAsync();

        // Get a purchase order by ID
        Task<PurchaseOrder> GetByIdAsync(int id);

        // Get a purchase order with items by ID
        Task<PurchaseOrder> GetByIdWithItemsAsync(int id); // ✅ Add this line

        // Get a purchase order with GRN by ID
        Task<PurchaseOrder> GetByIdWithGRNAsync(int id); // ✅ Add this line

        // Add a new purchase order
        Task AddAsync(PurchaseOrder purchaseOrder);

        // Update an existing purchase order
        Task UpdateAsync(PurchaseOrder purchaseOrder);

        // Delete a purchase order by ID
        Task DeleteAsync(int id);

        // Get GRN details for a Purchase Order by ID
        Task<IEnumerable<GRN>> GetGRNsByPurchaseOrderIdAsync(int purchaseOrderId); // ✅ Add this line

        // Get all items for a purchase order, including GRN items if present
        // Get only GRNItems associated with a given PurchaseOrderId
        Task<IEnumerable<GRNItem>> GetGRNItemsByPurchaseOrderIdAsync(int purchaseOrderId);
        // ✅ Add this line
        // Get a purchase order by ID
        Task<PurchaseOrder> GetByPurchaseOrderIdAsync(int purchaseOrderId);
        Task<PurchaseOrderItem> GetPurchaseOrderItemByIdAsync(int purchaseOrderItemId);

        Task<decimal> GetTotalPriceByPurchaseOrderItemIdAsync(int purchaseOrderId);

        /// </summary>
        Task<List<SelectListItem>> GetPurchaseOrderDropdownAsync();
        Task<PurchaseOrder> GetByPOCodeAsync(string poCode);
    }
}
