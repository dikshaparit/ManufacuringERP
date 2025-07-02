using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using ManufacturingERP.Entity;
using ManufacturingERP.Entity.Models;

//using ManufacturingERP.Entity.Model;
using ManufacuringERP.Entity.Model;
namespace ManufacuringERP.Repository.Interface
{ 

    public interface IPurchaseOrderTrackRepository
    {
        Task DeleteAsync(int id);
        Task AddAsync(PurchaseOrderTrack model);
        Task<IEnumerable<PurchaseOrder>> GetAllPurchaseOrdersAsync();
        Task<PurchaseOrder> GetPurchaseOrderByIdAsync(int purchaseOrderId);
        Task AddPurchaseOrderTrackAsync(PurchaseOrderTrack track);
        Task<IEnumerable<PurchaseOrderTrack>> GetAllTracksAsync();
        // New method to fetch Vendors by VendorIds
        Task<List<Vendor>> GetVendorsByIdsAsync(List<int> vendorIds);
        Task<IEnumerable<PurchaseOrderTrack>> GetAllWithVendorAsync();  // Add this method to the interface
        Task<PurchaseOrderTrack> GetByIdWithItemsAsync(int id);

        Task<List<PurchaseOrderItem>> GetPurchaseOrderItemsByPurchaseOrderIdAsync(int purchaseOrderId);
        Task<decimal> GetGrandTotalByPurchaseOrderIdAsync(int purchaseOrderId);
        Task<List<GRNItem>> GetGRNItemsByPurchaseOrderIdAsync(int purchaseOrderId);
        Task<int> GetActualQuantityByPOCodeAsync(int purchaseOrderId);
        Task<int> GetActualQuantityByPurchaseOrderIdAsync(int purchaseOrderId);
        Task<PurchaseOrderTrack> GetPurchaseOrderTrackWithVendorAsync(int id);

        Task AddPurchaseOrderTrackItemAsync(PurchaseOrderTrackItem item);

        Task<List<PurchaseOrderTrackItem>> GetPurchaseOrderTrackItemsByTrackIdAsync(int trackId);

        Task<List<PurchaseOrderTrack>> GetAllWithItemsAsync();
        Task<List<GRN>> GetGRNsByPurchaseOrderIdAsync(int purchaseOrderId);
}

}
