using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using ManufacturingERP.Entity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using ManufacturingERP.Data;

namespace ManufacturingERP.Controllers
{
    public class FinishedGoodsMasterController : Controller
    {
        private readonly AppDbContext _context;

        public FinishedGoodsMasterController(AppDbContext context)
        {
            _context = context;
        }

        // GET: FinishedGoodsMaster
        public async Task<IActionResult> Index()
        {
            var data = await _context.FinishedGoodsMasters
                .Include(f => f.FinishedGoodsItems)
                .ToListAsync();
            return View(data);
        }

        // GET: FinishedGoodsMaster/Create
        public async Task<IActionResult> Create()
        {
            // Get the last FinishedGoodsCode from the database
            var lastCode = await _context.FinishedGoodsMasters
                .OrderByDescending(fg => fg.FinishedGoodsMasterId)
                .Select(fg => fg.FinishedGoodsCode)
                .FirstOrDefaultAsync();

            int nextNumber = 1;

            if (!string.IsNullOrEmpty(lastCode) && lastCode.StartsWith("FG"))
            {
                var numberPart = lastCode.Substring(2);
                if (int.TryParse(numberPart, out int lastNumber))
                {
                    nextNumber = lastNumber + 1;
                }
            }

            var generatedCode = "FG" + nextNumber.ToString("D3"); // FG001, FG002, ...

            // Prepare RawMaterials as SelectListItem for dropdown in view
            var rawMaterials = await _context.RawMaterials
                .Select(rm => new SelectListItem
                {
                    Value = rm.RawMaterialId.ToString(),
                    Text = rm.MaterialName
                }).ToListAsync();

            ViewBag.RawMaterials = rawMaterials;

            return View(new FinishedGoodsMaster
            {
                FinishedGoodsCode = generatedCode,
                CreatedDate = DateTime.Now,
                FinishedGoodsItems = new List<FinishedGoodsItem>()
            });
        }

        // POST: FinishedGoodsMaster/Create
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create(FinishedGoodsMaster master)
        {
            if (ModelState.IsValid!=true)
            {
                master.CreatedDate = DateTime.Now;

                // Auto-generate FinishedGoodsCode if not provided
                if (string.IsNullOrEmpty(master.FinishedGoodsCode))
                {
                    master.FinishedGoodsCode = "FG" + DateTime.Now.Ticks;
                }

                // Remove empty FinishedGoodsItems (e.g. those with no RawMaterialId)
                master.FinishedGoodsItems = master.FinishedGoodsItems
                    .Where(item => item.RawMaterialId > 0 && item.PlannedQuantity > 0)
                    .ToList();

                _context.FinishedGoodsMasters.Add(master);
                await _context.SaveChangesAsync();
                return RedirectToAction(nameof(Index));
            }

            // If validation fails, repopulate RawMaterials for the dropdown
            var rawMaterials = await _context.RawMaterials
                .Select(rm => new SelectListItem
                {
                    Value = rm.RawMaterialId.ToString(),
                    Text = rm.MaterialName
                }).ToListAsync();

            ViewBag.RawMaterials = rawMaterials;

            return View(master);
        
}
        // GET: FinishedGoodsMaster/Edit/5
        public async Task<IActionResult> Edit(int id)
        {
            var master = await _context.FinishedGoodsMasters
                .Include(f => f.FinishedGoodsItems)
                .FirstOrDefaultAsync(m => m.FinishedGoodsMasterId == id);

            if (master == null)
            {
                return NotFound();
            }

            ViewBag.RawMaterials = await _context.RawMaterials.ToListAsync();
            return View(master);
        }

        // POST: FinishedGoodsMaster/Edit/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, FinishedGoodsMaster master)
        {
            if (id != master.FinishedGoodsMasterId)
                return NotFound();

            if (ModelState.IsValid)
            {
                try
                {
                    // Remove old child items
                    var existingItems = _context.FinishedGoodsItems
                        .Where(x => x.FinishedGoodsMasterId == id);
                    _context.FinishedGoodsItems.RemoveRange(existingItems);

                    // Add updated child items
                    foreach (var item in master.FinishedGoodsItems)
                    {
                        item.FinishedGoodsMasterId = id;
                        var material = await _context.RawMaterials.FindAsync(item.RawMaterialId);
                        item.MaterialName = material?.MaterialName;
                    }

                    _context.FinishedGoodsItems.AddRange(master.FinishedGoodsItems);

                    // Update parent
                    _context.FinishedGoodsMasters.Update(master);
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!FinishedGoodsMasterExists(master.FinishedGoodsMasterId))
                        return NotFound();
                    else
                        throw;
                }
                return RedirectToAction(nameof(Index));
            }

            ViewBag.RawMaterials = await _context.RawMaterials.ToListAsync();
            return View(master);
        }

        // GET: FinishedGoodsMaster/Delete/5
        public async Task<IActionResult> Delete(int id)
        {
            var master = await _context.FinishedGoodsMasters
                .Include(f => f.FinishedGoodsItems)
                .FirstOrDefaultAsync(m => m.FinishedGoodsMasterId == id);

            if (master == null)
                return NotFound();

            return View(master);
        }

        // POST: FinishedGoodsMaster/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            var master = await _context.FinishedGoodsMasters
                .Include(f => f.FinishedGoodsItems)
                .FirstOrDefaultAsync(m => m.FinishedGoodsMasterId == id);

            if (master != null)
            {
                _context.FinishedGoodsItems.RemoveRange(master.FinishedGoodsItems);
                _context.FinishedGoodsMasters.Remove(master);
                await _context.SaveChangesAsync();
            }

            return RedirectToAction(nameof(Index));
        }

        private bool FinishedGoodsMasterExists(int id)
        {
            return _context.FinishedGoodsMasters.Any(e => e.FinishedGoodsMasterId == id);
        }
        // GET: FinishedGoodsMaster/Details/5
        public async Task<IActionResult> Details(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var master = await _context.FinishedGoodsMasters
                .Include(f => f.FinishedGoodsItems)
                .FirstOrDefaultAsync(m => m.FinishedGoodsMasterId == id);

            if (master == null)
            {
                return NotFound();
            }

            return View(master);
        }

    }
}
