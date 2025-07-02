using ManufacturingERP.Data;
using ManufacturingERP.Entity;
using Microsoft.EntityFrameworkCore;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ManufacturingERP.Repository
{
    public class FinishedGoodsMasterRepository : IFinishedGoodsMasterRepository
    {
        private readonly AppDbContext _context;

        public FinishedGoodsMasterRepository(AppDbContext context)
        {
            _context = context;
        }

        public async Task<IEnumerable<FinishedGoodsMaster>> GetAllAsync()
        {
            return await _context.FinishedGoodsMasters
                .Include(f => f.FinishedGoodsItems)
                .ToListAsync();
        }

        public async Task<FinishedGoodsMaster> GetByIdAsync(int id)
        {
            return await _context.FinishedGoodsMasters
                .Include(f => f.FinishedGoodsItems)
                .FirstOrDefaultAsync(f => f.FinishedGoodsMasterId == id);
        }

        public async Task AddAsync(FinishedGoodsMaster master)
        {
            if (master != null)
            {
                _context.FinishedGoodsMasters.Add(master);
                await _context.SaveChangesAsync();
            }
        }

        public async Task UpdateAsync(FinishedGoodsMaster master)
        {
            var existing = await _context.FinishedGoodsMasters
                .Include(f => f.FinishedGoodsItems)
                .FirstOrDefaultAsync(f => f.FinishedGoodsMasterId == master.FinishedGoodsMasterId);

            if (existing != null)
            {
                // Update parent
                existing.FinishedGoodsCode = master.FinishedGoodsCode;
                existing.FinishedGoodsName = master.FinishedGoodsName;
                existing.CreatedDate = master.CreatedDate;

                // Update child items
                _context.FinishedGoodsItems.RemoveRange(existing.FinishedGoodsItems); // remove old
                await _context.SaveChangesAsync();

                existing.FinishedGoodsItems = master.FinishedGoodsItems; // add new
                await _context.SaveChangesAsync();
            }
        }

        public async Task DeleteAsync(int id)
        {
            var master = await _context.FinishedGoodsMasters
                .Include(f => f.FinishedGoodsItems)
                .FirstOrDefaultAsync(f => f.FinishedGoodsMasterId == id);

            if (master != null)
            {
                _context.FinishedGoodsItems.RemoveRange(master.FinishedGoodsItems);
                _context.FinishedGoodsMasters.Remove(master);
                await _context.SaveChangesAsync();
            }
        }

        // Get raw materials for dropdown
        public async Task<List<RawMaterial>> GetRawMaterialsAsync()
        {
            return await _context.RawMaterials.ToListAsync();
        }
       // public async Task<IEnumerable<ProductionPlan>> GetProductionPlansByFinishedGoodsIdAsync(int finishedGoodsMasterId)
       // {
            //return await _context.ProductionPlans
              //  .Where(p => p.FinishedGoodsMasterId == finishedGoodsMasterId)
               // .ToListAsync();
       // }

    }
}
