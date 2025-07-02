using System.Collections.Generic;
using System.Threading.Tasks;
using ManufacturingERP.Data;
using ManufacturingERP.Entity;
using Microsoft.EntityFrameworkCore;

namespace ManufacturingERP.Repository
{
    public class ProductionPlanRepository : IProductionPlanRepository
    {
        private readonly AppDbContext _context;

        public ProductionPlanRepository(AppDbContext context)
        {
            _context = context;
        }

        public async Task<IEnumerable<ProductionPlan>> GetAllAsync()
        {
            return await _context.ProductionPlans
                .Include(p => p.FinishedGoodsMaster)  // Correct navigation property here
                .ToListAsync();
        }

        public async Task<ProductionPlan> GetByIdAsync(int id)
        {
            return await _context.ProductionPlans
                .Include(p => p.FinishedGoodsMaster)  // Correct navigation property here
                .FirstOrDefaultAsync(p => p.ProductionPlanId == id);
        }

        public async Task AddAsync(ProductionPlan plan)
        {
            await _context.ProductionPlans.AddAsync(plan);
            await _context.SaveChangesAsync();
        }

        public async Task UpdateAsync(ProductionPlan plan)
        {
            _context.ProductionPlans.Update(plan);
            await _context.SaveChangesAsync();
        }

        public async Task DeleteAsync(int id)
        {
            var plan = await _context.ProductionPlans.FindAsync(id);
            if (plan != null)
            {
                _context.ProductionPlans.Remove(plan);
                await _context.SaveChangesAsync();
            }
        }

        //public async Task<ProductionPlan> GetByIdWithFinishedGoodsAsync(int id)
        //{
        //  return await _context.ProductionPlans
        //    .Include(p => p.FinishedGoodsMaster)
        //  .FirstOrDefaultAsync(p => p.ProductionPlanId == id);
        //}
        public async Task<ProductionPlan> GetByIdWithFinishedGoodsAsync(int id)
        {
            return await _context.ProductionPlans
                .Include(p => p.FinishedGoodsMaster)
                .FirstOrDefaultAsync(p => p.ProductionPlanId == id);
        }
        public async Task<int> GetTotalPlannedQuantityByFinishedGoodsIdAsync(int finishedGoodsMasterId)
        {
            return await _context.ProductionPlans
                                 .Where(p => p.FinishedGoodsMasterId == finishedGoodsMasterId && p.IsActive)
                                 .SumAsync(p => (int?)p.PlannedQuantity) ?? 0;
        }
        public async Task<int> GetTotalPlannedQuantityAsync(int finishedGoodsMasterId)
        {
            return await _context.ProductionPlans
                .Where(p => p.FinishedGoodsMasterId == finishedGoodsMasterId)
                .SumAsync(p => (int?)p.PlannedQuantity) ?? 0;
        }

        public async Task<int> GetTotalActualQuantityAsync(int finishedGoodsMasterId)
        {
            // Assuming actual qty is stored in ProductionPlans or another table.
            // Adjust accordingly.

            return await _context.ProductionPlans
                .Where(p => p.FinishedGoodsMasterId == finishedGoodsMasterId)
                .SumAsync(p => (int?)p.ActualQuantity) ?? 0;
        }

    }
}
