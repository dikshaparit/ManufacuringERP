using ManufacturingERP.Entity;
using System.Collections.Generic;
using System.Threading.Tasks;
using System.Web.Mvc;

namespace ManufacturingERP.Repository
{
    public interface IGRNRepository
    {
        Task<IEnumerable<GRN>> GetAllAsync();
        Task<GRN> GetByIdWithItemsAsync(int id);
        Task AddAsync(GRN grn);
        Task AddGRNItemAsync(GRNItem grnItem);
        Task UpdateAsync(GRN grn);
        Task DeleteAsync(int id);
        Task<List<GRNItem>> GetGRNItemsByPurchaseOrderIdAsync(string poCode);
        string GenerateGRNCode();

        /// </summary>
        Task<List<GRNItem>> GetPendingGRNItemsByPurchaseOrderIdAsync(int purchaseOrderId);

        Task<List<SelectListItem>> GetPurchaseOrdersForDropdownAsync();
        Task<PurchaseOrder> GetPurchaseOrderByCodeAsync(string poCode);
        GRN GetByIdWithItems(int id);

        Task<List<GRN>> GetGRNsByPurchaseOrderIdAsync(int purchaseOrderId);
        // Add this method
        Task<IEnumerable<GRN>> GetByPurchaseOrderIdAsync(int purchaseOrderId);

        Task<GRN> GetLastGRNByPurchaseOrderIdAsync(int purchaseOrderId);

    }
}
