using ManufacturingERP.Entity;
using ManufacturingERP.Entity.Models;
using ManufacturingERP.Repository;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace ManufacturingERP.Controllers
{
    public class VendorController : Controller
    {
        private readonly IVendorRepository _vendorRepository;

        public VendorController(IVendorRepository vendorRepository)
        {
            _vendorRepository = vendorRepository;
        }

        // Show Vendor List with Raw Materials
        public async Task<IActionResult> Index()
        {
            var vendors = await _vendorRepository.GetAllVendorsWithRawMaterialsAsync();
            return View(vendors);
        }

        public async Task<IActionResult> Details(int id)
        {
            var vendor = await _vendorRepository.GetVendorByIdAsync(id);
            if (vendor == null)
            {
                return NotFound();
            }
            return View(vendor);
        }

        public IActionResult Create()
        {
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create(Vendor vendor)
        {
            if (ModelState.IsValid)
            {
                // Normalize Status (Trim + Case-Insensitive)
                vendor.Status = vendor.Status?.Trim().ToLower() switch
                {
                    "active" => "Active",
                    "inactive" => "Inactive",
                    _ => "Active" // Default if invalid
                };

                vendor.CreatedDate = DateTime.UtcNow;
                vendor.ModifiedDate = DateTime.UtcNow;

                // Ensure RawMaterials is initialized
                if (vendor.RawMaterials == null)
                {
                    vendor.RawMaterials = new List<RawMaterial>();
                }

                await _vendorRepository.AddVendorAsync(vendor);
                return RedirectToAction(nameof(Index));
            }
            return View(vendor);
        }

        public async Task<IActionResult> Edit(int id)
        {
            var vendor = await _vendorRepository.GetVendorByIdAsync(id);
            if (vendor == null)
            {
                return NotFound();
            }
            return View(vendor);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, Vendor vendor)
        {
            if (id != vendor.VendorId)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                // Normalize Status (Case-Insensitive & Trim)
                vendor.Status = vendor.Status?.Trim().ToLower() switch
                {
                    "active" => "Active",
                    "inactive" => "Inactive",
                    _ => "Active" // Default to Active if invalid
                };

                vendor.ModifiedDate = DateTime.UtcNow;

                // Ensure RawMaterials is initialized
                if (vendor.RawMaterials == null)
                {
                    vendor.RawMaterials = new List<RawMaterial>();
                }

                await _vendorRepository.UpdateVendorAsync(vendor);
                return RedirectToAction(nameof(Index));
            }
            return View(vendor);
        }

        public async Task<IActionResult> Delete(int id)
        {
            var vendor = await _vendorRepository.GetVendorByIdAsync(id);
            if (vendor == null)
            {
                TempData["ErrorMessage"] = "Vendor not found.";
                return RedirectToAction(nameof(Index));
            }

            // Optional: You can pre-check here as well if you want to warn in the view
            var hasRawMaterials = await _vendorRepository.HasRawMaterialsAsync(id);
            if (hasRawMaterials)
            {
                TempData["ErrorMessage"] = "Cannot delete vendor because it is associated with existing raw materials.";
                return RedirectToAction(nameof(Index));
            }

            return View(vendor);
        }

        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            var hasRawMaterials = await _vendorRepository.HasRawMaterialsAsync(id);
            if (hasRawMaterials)
            {
                TempData["ErrorMessage"] = "Cannot delete vendor because it is associated with existing raw materials.";
                return RedirectToAction(nameof(Index));
            }

            await _vendorRepository.DeleteVendorAsync(id);
            TempData["SuccessMessage"] = "Vendor deleted successfully.";
            return RedirectToAction(nameof(Index));
        }

    }
}
