using ManufacturingERP.Data;
using ManufacturingERP.Entity;
using ManufacturingERP.Repository;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using static System.Web.Razor.Parser.SyntaxConstants;

namespace ManufacturingERP.Controllers
{
    public class RawMaterialController : Controller
    {
        private readonly IRawMaterialRepository _rawMaterialRepository;
        private readonly IVendorRepository _vendorRepository;

        private static readonly List<string> MaterialTypes = new() { "Steel", "Fabric", "Plastic", "Wood" };
        private static readonly List<string> Units = new() { "Kg", "Meter", "Cm" };

        public RawMaterialController(IRawMaterialRepository rawMaterialRepository, IVendorRepository vendorRepository)
        {
            _rawMaterialRepository = rawMaterialRepository;
            _vendorRepository = vendorRepository;
        }

        public async Task<IActionResult> Index()
        {
            var rawMaterials = await _rawMaterialRepository.GetAllAsync();
            return View(rawMaterials);
        }

        public async Task<IActionResult> Details(int id)
        {
            var rawMaterial = await _rawMaterialRepository.GetByIdAsync(id);

            if (rawMaterial == null)
            {
                return NotFound();
            }

            var vendor = await _vendorRepository.GetVendorByIdAsync(rawMaterial.VendorId);
            ViewBag.VendorName = vendor?.CompanyName ?? "Unknown";

            return View(rawMaterial);
        }


        public async Task<IActionResult> Create()
        {
            await PopulateDropdowns();
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create(RawMaterial rawMaterial, string[] MaterialType)
        {
            if (ModelState.IsValid != true)
            {
                try
                {
                    rawMaterial.MaterialType = string.Join(",", MaterialType); // ✅ Store multiple selected materials as a comma-separated string
                    rawMaterial.CreatedDate = DateTime.Now;

                    await _rawMaterialRepository.AddAsync(rawMaterial);
                    TempData["SuccessMessage"] = "Raw Material added successfully!";

                    return RedirectToAction("Index");
                }
                catch (Exception ex)
                {
                    ViewBag.ErrorMessage = "Error saving data: " + ex.Message;
                }
            }

            await PopulateDropdowns();
            return View(rawMaterial);
        }

        public async Task<IActionResult> Edit(int id)
        {
            var rawMaterial = await _rawMaterialRepository.GetByIdAsync(id);
            if (rawMaterial == null) return NotFound();

            await PopulateDropdowns();
            return View(rawMaterial);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, RawMaterial rawMaterial, string[] MaterialType)
        {
            if (id != rawMaterial.RawMaterialId)
            {
                return NotFound();
            }

            if (ModelState.IsValid != true)
            {
                try
                {
                    var existingRawMaterial = await _rawMaterialRepository.GetByIdAsync(id);
                    if (existingRawMaterial == null)
                    {
                        return NotFound();
                    }

                    existingRawMaterial.MaterialType = string.Join(",", MaterialType); // ✅ Store multiple selected materials as a comma-separated string
                    existingRawMaterial.MaterialName = rawMaterial.MaterialName;
                    existingRawMaterial.VendorId = rawMaterial.VendorId;
                    existingRawMaterial.Quantity = rawMaterial.Quantity;
                    existingRawMaterial.Unit = rawMaterial.Unit;
                    existingRawMaterial.ModifiedDate = DateTime.Now;

                    await _rawMaterialRepository.UpdateAsync(existingRawMaterial);
                    TempData["SuccessMessage"] = "Raw Material updated successfully!";

                    return RedirectToAction("Index");
                }
                catch (Exception ex)
                {
                    ViewBag.ErrorMessage = "Error updating data: " + ex.Message;
                }
            }

            await PopulateDropdowns();
            return View(rawMaterial);
        }

        public async Task<IActionResult> Delete(int id)
        {
            var rawMaterial = await _rawMaterialRepository.GetByIdAsync(id);
            if (rawMaterial == null)
            {
                return NotFound();
            }

            var vendor = await _vendorRepository.GetVendorByIdAsync(rawMaterial.VendorId);
            ViewBag.VendorName = vendor?.CompanyName ?? "Unknown";

            return View(rawMaterial);
        }

        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            var rawMaterial = await _rawMaterialRepository.GetByIdAsync(id);
            if (rawMaterial == null)
            {
                return NotFound();
            }

            await _rawMaterialRepository.DeleteAsync(id);
            TempData["SuccessMessage"] = "Raw Material deleted successfully!";

            return RedirectToAction(nameof(Index));
        }

        private async Task PopulateDropdowns()
        {
            ViewBag.MaterialTypes = MaterialTypes.Select(mt => new SelectListItem
            {
                Value = mt,
                Text = mt
            }).ToList();

            ViewBag.Units = Units.Select(unit => new SelectListItem
            {
                Value = unit,
                Text = unit
            }).ToList();


            var vendors = await _vendorRepository.GetAllVendorsAsync();
            ViewBag.Vendors = vendors.Select(v => new SelectListItem
            {
                Value = v.VendorId.ToString(),
                Text = v.CompanyName
            }).ToList();
        }

    }
}
