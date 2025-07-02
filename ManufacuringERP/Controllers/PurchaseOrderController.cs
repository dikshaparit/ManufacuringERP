using ManufacturingERP.Entity;
using ManufacturingERP.Repository.Interface;
using ManufacturingERP.Repository;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ManufacturingERP.Controllers
{
    public class PurchaseOrderController : Controller
    {
        private readonly IPurchaseOrderRepository _purchaseOrderRepository;
        private readonly IVendorRepository _vendorRepository;

        public PurchaseOrderController(
            IPurchaseOrderRepository purchaseOrderRepository,
            IVendorRepository vendorRepository)
        {
            _purchaseOrderRepository = purchaseOrderRepository;
            _vendorRepository = vendorRepository;
        }

        // GET: /PurchaseOrder/
        public async Task<IActionResult> Index()
        {
            var purchaseOrders = await _purchaseOrderRepository.GetAllAsync();
            return View(purchaseOrders);
        }

        // GET: /PurchaseOrder/Details/5
        public async Task<IActionResult> Details(int id)
        {
            var purchaseOrder = await _purchaseOrderRepository.GetByIdWithItemsAsync(id);
            if (purchaseOrder == null)
            {
                return NotFound();
            }
            return View(purchaseOrder);
        }

        // GET: /PurchaseOrder/Create
        public async Task<IActionResult> Create()
        {
            var vendors = await _vendorRepository.GetAllVendorsAsync();

            // ✅ Construct a SelectListItem manually to show both VendorId and VendorName
            ViewBag.Vendors = vendors.Select(v => new SelectListItem
            {
                Value = v.VendorId.ToString(), // This is the foreign key value
                Text = v.CompanyName           // This will be displayed in the dropdown
            }).ToList();
            return View();
        }

        // POST: /PurchaseOrder/Create
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create(PurchaseOrder purchaseOrder)
        {
            if (ModelState.IsValid != true)
            {
                // ✅ Generate unique POCode if not provided
                purchaseOrder.POCode = GeneratePOCode();

                // ✅ Verify and log MaterialType for each item
                if (purchaseOrder.PurchaseOrderItems != null && purchaseOrder.PurchaseOrderItems.Any())
                {
                    foreach (var item in purchaseOrder.PurchaseOrderItems)
                    {
                        Console.WriteLine(item.MaterialType); // ✅ Check this in debug or logs
                    }
                }
                else
                {
                    ModelState.AddModelError("", "At least one Purchase Order Item is required.");

                    // Reload dropdowns before returning view
                    await LoadDropdownData();
                    return View(purchaseOrder);
                }

                // ✅ Add purchase order via repository
                await _purchaseOrderRepository.AddAsync(purchaseOrder);
                return RedirectToAction(nameof(Index));
            }

            // ✅ Re-populate ViewBag if ModelState is invalid
            await LoadDropdownData();
            return View(purchaseOrder);
        }


        // ✅ Helper method to load dropdown data
        private async Task LoadDropdownData()
        {
            // Fetch Vendors for dropdown
            var vendors = await _vendorRepository.GetAllVendorsAsync();
            ViewBag.Vendors = vendors.Select(v => new SelectListItem
            {
                Value = v.VendorId.ToString(), // This is the foreign key value
                Text = v.CompanyName           // This will be displayed in the dropdown
            }).ToList();
        }

        // ✅ Helper method to generate a unique PO Code
        private string GeneratePOCode()
        {
            return "PO-" + DateTime.Now.ToString("yyyyMMddHHmmss");
        }

        // GET: /PurchaseOrder/Edit/5
        public async Task<IActionResult> Edit(int id)
        {
            var purchaseOrder = await _purchaseOrderRepository.GetByIdAsync(id);
            if (purchaseOrder == null)
            {
                return NotFound();
            }

            await LoadDropdownData();
            return View(purchaseOrder);
        }

        // POST: /PurchaseOrder/Edit/5

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, PurchaseOrder purchaseOrder)
        {
            if (id != purchaseOrder.PurchaseOrderId)
            {
                return NotFound();
            }

            if (ModelState.IsValid != true)
            {
                if (purchaseOrder.PurchaseOrderItems == null || !purchaseOrder.PurchaseOrderItems.Any())
                {
                    ModelState.AddModelError("", "At least one Purchase Order Item is required.");

                    // Reload dropdowns before returning view
                    await LoadDropdownData();
                    return View(purchaseOrder);
                }

                // ✅ Fetch the existing PurchaseOrder from DB (including existing items)
                var existingOrder = await _purchaseOrderRepository.GetByIdWithItemsAsync(id);
                if (existingOrder == null)
                {
                    return NotFound();
                }

                // ✅ Update parent fields (add Status here)
                existingOrder.VendorId = purchaseOrder.VendorId;
                existingOrder.OrderDate = purchaseOrder.OrderDate;
                existingOrder.ExpectedDeliveryDate = purchaseOrder.ExpectedDeliveryDate;
                existingOrder.Status = purchaseOrder.Status; // ✅ Add this line to update status

                // ✅ Handle child items
                // 1. Remove deleted items
                var itemsToDelete = existingOrder.PurchaseOrderItems
                    .Where(existingItem => !purchaseOrder.PurchaseOrderItems.Any(newItem => newItem.PurchaseOrderItemId == existingItem.PurchaseOrderItemId))
                    .ToList();

                foreach (var item in itemsToDelete)
                {
                    existingOrder.PurchaseOrderItems.Remove(item);
                }

                // 2. Update existing items and add new items
                foreach (var item in purchaseOrder.PurchaseOrderItems)
                {
                    var existingItem = existingOrder.PurchaseOrderItems
                        .FirstOrDefault(i => i.PurchaseOrderItemId == item.PurchaseOrderItemId);

                    if (existingItem != null)
                    {
                        // Update existing item
                        existingItem.MaterialType = item.MaterialType;
                        existingItem.MaterialName = item.MaterialName;
                        existingItem.Quantity = item.Quantity;
                        existingItem.Unit = item.Unit;
                        existingItem.Price = item.Price;
                    }
                    else
                    {
                        // Add new item
                        existingOrder.PurchaseOrderItems.Add(new PurchaseOrderItem
                        {
                            MaterialType = item.MaterialType,
                            MaterialName = item.MaterialName,
                            Quantity = item.Quantity,
                            Unit = item.Unit,
                            Price = item.Price
                        });
                    }
                }

                
                // ✅ Save changes through repository
                await _purchaseOrderRepository.UpdateAsync(existingOrder);

                return RedirectToAction(nameof(Index));
            }

            // If we got here, something went wrong; reload dropdowns
            await LoadDropdownData();
            return View(purchaseOrder);
        }


        // GET: /PurchaseOrder/Delete/5
        public async Task<IActionResult> Delete(int id)
        {
            var purchaseOrder = await _purchaseOrderRepository.GetByIdWithItemsAsync(id);
            if (purchaseOrder == null)
            {
                return NotFound();
            }
            return View(purchaseOrder);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int PurchaseOrderId)
        {
            var purchaseOrder = await _purchaseOrderRepository.GetByIdAsync(PurchaseOrderId);
            if (purchaseOrder == null)
            {
                return NotFound();
            }

            await _purchaseOrderRepository.DeleteAsync(PurchaseOrderId);
            return RedirectToAction(nameof(Index));
        }
        

    }
}
