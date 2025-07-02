using ManufacturingERP.Entity;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace ManufacturingERP.Repository
{
    public interface IFinishedGoodsMasterRepository
    {
        Task<IEnumerable<FinishedGoodsMaster>> GetAllAsync();
        Task<FinishedGoodsMaster> GetByIdAsync(int id);
        Task AddAsync(FinishedGoodsMaster master);
        Task UpdateAsync(FinishedGoodsMaster master);
        Task DeleteAsync(int id);

        // Optional: Add child item management if needed separately
        Task<List<RawMaterial>> GetRawMaterialsAsync(); // For dropdowns

        //Task<IEnumerable<ProductionPlan>> GetProductionPlansByFinishedGoodsIdAsync(int finishedGoodsMasterId);

    }
}
