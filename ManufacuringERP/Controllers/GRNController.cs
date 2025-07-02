using iTextSharp.text.pdf;
using iTextSharp.text;
using ManufacturingERP.Entity;
using ManufacturingERP.Repository;
using ManufacturingERP.Repository.Interface;
using ManufacuringERP.Repository.Interface;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using iTextSharp.text;
using iTextSharp.text.pdf;
using System.IO;
using System.Threading.Tasks;

namespace ManufacturingERP.Controllers
{
    public class GRNController : Controller
    {
        private readonly IGRNRepository _grnRepository;
        private readonly IVendorRepository _vendorRepository;
        private readonly IPurchaseOrderRepository _purchaseOrderRepository;

        public GRNController(IGRNRepository grnRepository, IVendorRepository vendorRepository, IPurchaseOrderRepository purchaseOrderRepository)
        {
            _grnRepository = grnRepository;
            _vendorRepository = vendorRepository;
            _purchaseOrderRepository = purchaseOrderRepository;

        }

        public async Task<IActionResult> Index()
        {
            var grns = await _grnRepository.GetAllAsync();
            return View(grns);
        }

        public async Task<IActionResult> Details(int id)
        {
            var grn = await _grnRepository.GetByIdWithItemsAsync(id);
            if (grn == null)
                return NotFound();

            // Populate Vendor if not already included
            if (grn.Vendor == null)
                grn.Vendor = await _vendorRepository.GetVendorByIdAsync(grn.VendorId);

            // Populate OriginalQuantity for each GRNItem from the corresponding PurchaseOrderItem
            foreach (var item in grn.GRNItems)
            {
                var purchaseOrderItem = await _purchaseOrderRepository.GetPurchaseOrderItemByIdAsync(item.PurchaseOrderItemId.Value);

                if (purchaseOrderItem != null)
                {
                    item.OriginalQuantity = purchaseOrderItem.Quantity;
                }
                else
                {
                    item.OriginalQuantity = 0; // Fallback value
                }
            }

            return View(grn);
        }

        [HttpGet]
        public async Task<IActionResult> Create(int? purchaseOrderId)
        {
            // 1. Build your PO dropdown once
            ViewBag.PurchaseOrders = (await _purchaseOrderRepository.GetAllAsync())
                .Select(po => new SelectListItem
                {
                    Value = po.PurchaseOrderId.ToString(),
                    Text = po.POCode
                })
                .ToList();

            // 2. Initialize the GRN header
            var grn = new GRN
            {
                GRNCode = _grnRepository.GenerateGRNCode(),
                GRNDate = DateTime.Now,
                Status = "Pending",
                GRNItems = new List<GRNItem>()
            };

            // 3. If they've chosen a PO, load _only_ the pending quantities
            if (purchaseOrderId.HasValue)
            {
                var po = await _purchaseOrderRepository.GetByIdAsync(purchaseOrderId.Value);
                if (po != null)
                {
                    grn.PurchaseOrderId = po.PurchaseOrderId;
                    grn.POCode = po.POCode;
                    grn.VendorId = po.VendorId;

                    // ← here’s the key line:
                    grn.GRNItems = await _grnRepository
                        .GetPendingGRNItemsByPurchaseOrderIdAsync(po.PurchaseOrderId);
                }
            }

            return View(grn);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create(GRN grn)
        {
            if (ModelState.IsValid != true)
            {
                await _grnRepository.AddAsync(grn);
                return RedirectToAction(nameof(Index));
            }

            var purchaseOrders = (await _purchaseOrderRepository.GetAllAsync())
                .Select(po => new SelectListItem
                {
                    Value = po.PurchaseOrderId.ToString(),
                    Text = po.POCode
                });

            ViewBag.PurchaseOrders = purchaseOrders;

            return View(grn);
        }

        [HttpGet]
        public async Task<IActionResult> Edit(int id)
        {
            var grn = await _grnRepository.GetByIdWithItemsAsync(id);
            if (grn == null)
                return NotFound();

            // Ensure PO dropdown for view if you allow editing PO
            var purchaseOrders = (await _purchaseOrderRepository.GetAllAsync())
                .Select(po => new SelectListItem
                {
                    Value = po.PurchaseOrderId.ToString(),
                    Text = po.POCode,
                    Selected = (po.PurchaseOrderId == grn.PurchaseOrderId)
                });

            ViewBag.PurchaseOrders = purchaseOrders;

            return View(grn);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(GRN grn)
        {
            // Check if the model is valid
            if (ModelState.IsValid != true)
            {
                // Ensure that GRNCode is not null
                if (grn.GRNCode == null)
                {
                    grn.GRNCode = "GRN-" + Guid.NewGuid().ToString(); // Generate a unique GRNCode if it's null
                }

                // Update the GRN entity in the repository
                await _grnRepository.UpdateAsync(grn);

                // Redirect to the Index page after successful update
                return RedirectToAction(nameof(Index));
            }

            // If model is invalid, prepare the purchase orders for the view
            var purchaseOrders = (await _purchaseOrderRepository.GetAllAsync())
                .Select(po => new SelectListItem
                {
                    Value = po.PurchaseOrderId.ToString(),
                    Text = po.POCode,
                    Selected = (po.PurchaseOrderId == grn.PurchaseOrderId)
                });

            // Pass purchase orders to the ViewBag for dropdown in the view
            ViewBag.PurchaseOrders = purchaseOrders;

            // Return the same view with the current GRN object if the model is not valid
            return View(grn);
        }

        // Controller: GRNController.cs

        // GET: /GRN/Delete/5
        public async Task<IActionResult> Delete(int id)
        {
            var grn = await _grnRepository.GetByIdWithItemsAsync(id);
            if (grn == null)
            {
                return NotFound();
            }

            // Optionally load related data like Vendor
            grn.Vendor = await _vendorRepository.GetVendorByIdAsync(grn.VendorId);

            return View(grn); // Returns the Delete.cshtml view
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int GRNId)
        {
            var grn = await _grnRepository.GetByIdWithItemsAsync(GRNId); // You can also use GetByIdWithItemsAsync if needed
            if (grn == null)
            {
                return NotFound();
            }

            await _grnRepository.DeleteAsync(GRNId);
            return RedirectToAction(nameof(Index));
        }
        public IActionResult DownloadPdf(int id)
        {
            var grn = _grnRepository.GetByIdWithItems(id);

            if (grn == null)
                return NotFound();

            using (var memoryStream = new MemoryStream())
            {
                Document document = new Document(PageSize.A4, 25, 25, 30, 30);
                PdfWriter.GetInstance(document, memoryStream).CloseStream = false;
                document.Open();

                var titleFont = FontFactory.GetFont("Arial", 16, Font.BOLD);
                var labelFont = FontFactory.GetFont("Arial", 12, Font.BOLD);
                var valueFont = FontFactory.GetFont("Arial", 12, Font.NORMAL);

                // Title
                document.Add(new Paragraph("GRN Details", titleFont));
                document.Add(new Paragraph(" "));

                // GRN Details Section
                PdfPTable detailsTable = new PdfPTable(2);
                detailsTable.WidthPercentage = 100;
                detailsTable.SpacingAfter = 10;

                void AddDetailRow(string label, string value)
                {
                    var labelCell = new PdfPCell(new Phrase(label, labelFont))
                    {
                        BorderWidth = 1,
                        BackgroundColor = new BaseColor(230, 230, 230),
                        Padding = 5
                    };
                    var valueCell = new PdfPCell(new Phrase(value, valueFont))
                    {
                        BorderWidth = 1,
                        Padding = 5
                    };

                    detailsTable.AddCell(labelCell);
                    detailsTable.AddCell(valueCell);
                }

                AddDetailRow("GRN Code", grn.GRNCode);
                AddDetailRow("PO Code", grn.POCode);
                AddDetailRow("Vendor", grn.Vendor?.CompanyName ?? "-");
                AddDetailRow("GRN Date", grn.GRNDate.ToShortDateString());
                AddDetailRow("Status", grn.Status);

                document.Add(detailsTable);

                // GRN Items Table
                PdfPTable itemTable = new PdfPTable(7);
                itemTable.WidthPercentage = 100;
                itemTable.SpacingBefore = 10f;
                itemTable.SetWidths(new float[] { 2, 2, 1, 2, 2, 2, 2 });

                string[] headers = {
            "Material Type", "Material Name", "Unit",
            "Original Quantity", "GRN Quantity", "Actual Quantity", "Pending Quantity"
        };

                foreach (var header in headers)
                {
                    var headerCell = new PdfPCell(new Phrase(header, labelFont))
                    {
                        BackgroundColor = new BaseColor(200, 200, 200),
                        Padding = 5,
                        BorderWidth = 1
                    };
                    itemTable.AddCell(headerCell);
                }

                foreach (var item in grn.GRNItems)
                {
                    var originalQty = item.PurchaseOrderItem?.Quantity ?? 0;
                    var pendingQty = item.Quantity - item.ActualQuantity;

                    itemTable.AddCell(new PdfPCell(new Phrase(item.MaterialType, valueFont)) { Padding = 5 });
                    itemTable.AddCell(new PdfPCell(new Phrase(item.MaterialName, valueFont)) { Padding = 5 });
                    itemTable.AddCell(new PdfPCell(new Phrase(item.Unit, valueFont)) { Padding = 5 });
                    itemTable.AddCell(new PdfPCell(new Phrase(originalQty.ToString(), valueFont)) { Padding = 5 });
                    itemTable.AddCell(new PdfPCell(new Phrase(item.Quantity.ToString(), valueFont)) { Padding = 5 });
                    itemTable.AddCell(new PdfPCell(new Phrase(item.ActualQuantity.ToString(), valueFont)) { Padding = 5 });
                    itemTable.AddCell(new PdfPCell(new Phrase(pendingQty.ToString(), valueFont)) { Padding = 5 });
                }

                document.Add(itemTable);
                document.Close();

                memoryStream.Position = 0;
                return File(memoryStream.ToArray(), "application/pdf", $"GRN_{grn.GRNCode}.pdf");
            }
        }
    }
}