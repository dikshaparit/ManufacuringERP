using ManufacturingERP.Data;
using ManufacuringERP.Entity.Model;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System;
using System.Linq;
using System.Threading.Tasks;

namespace ManufacturingERP.Controllers
{
    public class InventoryController : Controller
    {
        private readonly AppDbContext _context;

        public InventoryController(AppDbContext context)
        {
            _context = context;
        }

        // GET: Inventory
        public async Task<IActionResult> Index()
        {
            var inventory = await _context.Inventories.ToListAsync();
            return View(inventory);
        }

        // GET: Inventory/Details/5
        public async Task<IActionResult> Details(int? id)
        {
            if (id == null) return NotFound();

            var inventory = await _context.Inventories
                .FirstOrDefaultAsync(m => m.InventoryId == id);

            if (inventory == null) return NotFound();

            return View(inventory);
        }

        // GET: Inventory/Create
        public IActionResult Create()
        {
            return View();
        }

        // POST: Inventory/Create
        // POST: Inventory/Create
        [HttpPost]
        [ValidateAntiForgeryToken]
        public IActionResult Create(Inventory inventory)
        {
            if (ModelState.IsValid !=true)
            {
                inventory.CreatedDate = DateTime.Now;
                inventory.CreatedBy = "Admin"; // Replace with logged-in user's name or email

                _context.Inventories.Add(inventory);
                _context.SaveChanges();
                return RedirectToAction(nameof(Index));
            }
            return View(inventory);
        }


        // GET: Inventory/Edit/5
        // GET: Inventory/Edit/5
        public async Task<IActionResult> Edit(int? id)
        {
            if (id == null)
                return NotFound();

            var inventory = await _context.Inventories.FindAsync(id);
            if (inventory == null)
                return NotFound();

            return View(inventory);
        }

        // POST: Inventory/Edit/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, Inventory inventory)
        {
            if (id != inventory.InventoryId)
                return NotFound();

            if (ModelState.IsValid != true)
            {
                try
                {
                    // Fetch the existing record from the database
                    var existingInventory = await _context.Inventories.FindAsync(id);
                    if (existingInventory == null)
                        return NotFound();

                    // Update fields
                    existingInventory.MaterialName = inventory.MaterialName;
                    existingInventory.Quantity = inventory.Quantity;
                    existingInventory.Unit = inventory.Unit;
                    existingInventory.Location = inventory.Location;
                    existingInventory.Status = inventory.Status;

                    // Set modified values
                    existingInventory.ModifiedDate = DateTime.Now;
                    existingInventory.ModifiedBy = "Admin"; // Replace with logged-in user's name or email

                    _context.Update(existingInventory);
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!InventoryExists(inventory.InventoryId))
                        return NotFound();
                    else
                        throw;
                }
                return RedirectToAction(nameof(Index));
            }

            return View(inventory);
        }


        // GET: Inventory/Delete/5
        public async Task<IActionResult> Delete(int? id)
        {
            if (id == null)
                return NotFound();

            var inventory = await _context.Inventories
                .FirstOrDefaultAsync(m => m.InventoryId == id);

            if (inventory == null)
                return NotFound();

            return View(inventory);
        }

        // POST: Inventory/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            var inventory = await _context.Inventories.FindAsync(id);
            if (inventory != null)
            {
                _context.Inventories.Remove(inventory);
                await _context.SaveChangesAsync();
            }

            return RedirectToAction(nameof(Index));
        }

        private bool InventoryExists(int id)
        {
            return _context.Inventories.Any(e => e.InventoryId == id);
        }
    }
}
