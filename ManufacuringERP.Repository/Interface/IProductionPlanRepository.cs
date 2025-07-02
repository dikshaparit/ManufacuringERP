using System.Collections.Generic;
using System.Threading.Tasks;
using ManufacturingERP.Entity;

namespace ManufacturingERP.Repository
{
    public interface IProductionPlanRepository
    {
        Task<IEnumerable<ProductionPlan>> GetAllAsync();
        Task<ProductionPlan> GetByIdAsync(int id);
       //Task<ProductionPlan> GetByIdWithFinishedGoodsAsync(int id); // ✅ New method
        Task AddAsync(ProductionPlan plan);
        Task UpdateAsync(ProductionPlan plan);
        Task DeleteAsync(int id);
        Task<ProductionPlan> GetByIdWithFinishedGoodsAsync(int id);
        Task<int> GetTotalPlannedQuantityByFinishedGoodsIdAsync(int finishedGoodsMasterId);
        Task<int> GetTotalPlannedQuantityAsync(int finishedGoodsMasterId);
        Task<int> GetTotalActualQuantityAsync(int finishedGoodsMasterId);

    }
}
