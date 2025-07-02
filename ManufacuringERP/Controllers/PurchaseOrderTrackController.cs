using ManufacturingERP.Data;
using ManufacuringERP.Entity.Model;
using ManufacuringERP.Repository.Interface;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using System.Linq;
using System.Threading.Tasks;
using System.Collections.Generic;
using ManufacturingERP.Repository.Interface;
using ManufacturingERP.Repository;
using ManufacturingERP.Entity;

public class PurchaseOrderTrackController : Controller
{
    private readonly IPurchaseOrderTrackRepository _trackRepository;
    private readonly IPurchaseOrderRepository _purchaseOrderRepository;
    private readonly IGRNRepository _grnRepository;
    private readonly AppDbContext _context;

    public PurchaseOrderTrackController(
        IPurchaseOrderTrackRepository trackRepository,
        IPurchaseOrderRepository purchaseOrderRepository,
        IGRNRepository grnRepository,
        AppDbContext context)
    {
        _trackRepository = trackRepository;
        _purchaseOrderRepository = purchaseOrderRepository;
        _grnRepository = grnRepository;
        _context = context;
    }

    public async Task<IActionResult> Index()
    {
        var tracks = await _context.PurchaseOrderTracks
            .Include(p => p.Vendor)
            .Include(p => p.PurchaseOrderTrackItems)
            .Include(p => p.PurchaseOrder)   // Make sure PurchaseOrder is included
            .ToListAsync();

        foreach (var track in tracks)
        {
            track.GRNQuantity = track.PurchaseOrderTrackItems?.Sum(i => i.ActualQuantity) ?? 0;
        }

        return View(tracks);
    }



    [HttpGet]
    public async Task<IActionResult> Create(int? purchaseOrderId)
    {
        var purchaseOrders = await _trackRepository.GetAllPurchaseOrdersAsync();
        ViewBag.PurchaseOrders = new SelectList(purchaseOrders, "PurchaseOrderId", "POCode");

        var model = new PurchaseOrderTrack
        {
            PurchaseOrderTrackItems = new List<PurchaseOrderTrackItem>()
        };

        if (purchaseOrderId.HasValue)
        {
            model.PurchaseOrderId = purchaseOrderId.Value;
            var purchaseOrder = await _context.PurchaseOrders.FindAsync(purchaseOrderId.Value);

            if (purchaseOrder != null)
                model.VendorId = purchaseOrder.VendorId;

            var grns = await _context.GRNs
                .Include(g => g.GRNItems)
                .Where(g => g.PurchaseOrderId == purchaseOrderId.Value)
                .OrderBy(g => g.GRNDate)
                .ToListAsync();

            var poItems = await _context.PurchaseOrderItems
                .Where(p => p.PurchaseOrderId == purchaseOrderId.Value)
                .ToListAsync();

            var allGRNItems = grns
                .SelectMany(grn => grn.GRNItems.Select(item => new
                {
                    grn.GRNCode,
                    grn.GRNDate,
                    item.MaterialType,
                    item.MaterialName,
                    item.Unit,
                    item.Quantity,
                    item.ActualQuantity
                }))
                .OrderBy(x => x.GRNDate)
                .ToList();

            var grouped = allGRNItems
                .GroupBy(i => new { i.MaterialType, i.MaterialName, i.Unit })
                .ToList();

            foreach (var group in grouped)
            {
                foreach (var item in group)
                {
                    model.PurchaseOrderTrackItems.Add(new PurchaseOrderTrackItem
                    {
                        GRNCode = item.GRNCode,
                        GRNDate = item.GRNDate,
                        MaterialType = item.MaterialType,
                        MaterialName = item.MaterialName,
                        Unit = item.Unit,
                        OriginalQuantity = poItems
                            .FirstOrDefault(p =>
                                p.MaterialType == item.MaterialType &&
                                p.MaterialName == item.MaterialName &&
                                p.Unit == item.Unit)?.Quantity ?? 0,
                        Quantity = item.Quantity,
                        ActualQuantity = item.ActualQuantity // Show ActualQuantity here
                    });
                }
            }
        }

        await PopulateVendorsDropdown(model.VendorId);
        return View(model);
    }

    [HttpPost]
    [ValidateAntiForgeryToken]
    public async Task<IActionResult> Create(PurchaseOrderTrack model)
    {
        if (!ModelState.IsValid!=true)
        {
            var purchaseOrders = await _trackRepository.GetAllPurchaseOrdersAsync();
            ViewBag.PurchaseOrders = new SelectList(purchaseOrders, "PurchaseOrderId", "POCode", model.PurchaseOrderId);
            await PopulateVendorsDropdown(model.VendorId);
            return View(model);
        }

        await _trackRepository.AddAsync(model);
        return RedirectToAction(nameof(Index));
    }

    private async Task PopulateVendorsDropdown(int? selectedVendorId = null)
    {
        var vendors = await _context.Vendors
            .OrderBy(v => v.CompanyName)
            .ToListAsync();

        ViewData["VendorId"] = new SelectList(vendors, "VendorId", "CompanyName", selectedVendorId);
    }

    [HttpGet]
    public async Task<IActionResult> GetPurchaseOrderDetails(int purchaseOrderId)
    {
        var purchaseOrder = await _purchaseOrderRepository.GetByIdWithItemsAsync(purchaseOrderId);
        if (purchaseOrder == null)
        {
            return NotFound();
        }

        // Use PurchaseOrderItems instead of Items
        var totalPrice = purchaseOrder.PurchaseOrderItems.Sum(i => i.Quantity * i.Price);

        var quantity = purchaseOrder.PurchaseOrderItems.Sum(i => i.Quantity);
        var unitPrice = quantity != 0 ? totalPrice / quantity : 0;

        var grns = await _grnRepository.GetGRNsByPurchaseOrderIdAsync(purchaseOrderId);
        var grnItems = grns.SelectMany(g => g.GRNItems).ToList();
        var grnQuantity = grnItems.Sum(i => i.Quantity);

        var grnTotalValue = grnQuantity * unitPrice;
        var balance = totalPrice - grnTotalValue;

        return Json(new
        {
            vendorId = purchaseOrder.VendorId,
            orderDate = purchaseOrder.OrderDate.ToString("yyyy-MM-dd"),
            expectedDelivery = purchaseOrder.ExpectedDeliveryDate.ToString("yyyy-MM-dd"), // Use ExpectedDeliveryDate
            totalPrice = totalPrice,
            quantity = quantity,
            grnQuantity = grnQuantity,
            unitPrice = unitPrice,
            grnTotalValue = grnTotalValue,
            balance = balance
        });
    }


    [HttpGet]
    public async Task<IActionResult> GetPurchaseOrderAndGRNData(int purchaseOrderId)
    {
        var purchaseOrder = await _purchaseOrderRepository.GetByIdAsync(purchaseOrderId);

        if (purchaseOrder == null)
            return NotFound("Purchase Order not found.");

        var purchaseOrderItems = purchaseOrder.PurchaseOrderItems ?? new List<PurchaseOrderItem>();

        var grns = await _grnRepository.GetGRNsByPurchaseOrderIdAsync(purchaseOrderId);

        decimal poTotalPrice = purchaseOrder.TotalPrice != null
            ? (decimal)purchaseOrder.TotalPrice
            : 0m;

        decimal poQuantity = purchaseOrderItems.Sum(i => Convert.ToDecimal(i.Quantity));

        decimal grnTotalQuantity = 0m;
        foreach (var grn in grns)
        {
            if (grn.GRNItems != null)
            {
                grnTotalQuantity += grn.GRNItems.Sum(i => Convert.ToDecimal(i.ActualQuantity));
            }
        }

        decimal unitPrice = poQuantity > 0 ? poTotalPrice / poQuantity : 0m;
        decimal grnTotalPrice = unitPrice * grnTotalQuantity;
        decimal balance = poTotalPrice - grnTotalPrice;

        return Json(new
        {
            purchaseOrderId,
            totalPrice = poTotalPrice,
            quantity = poQuantity,
            grnQuantity = grnTotalQuantity,
            grnUnitPrice = unitPrice,
            grnTotalPrice = grnTotalPrice,
            balance
        });
    }

    public async Task<IActionResult> Details(int id)
    {
        var track = await _context.PurchaseOrderTracks
            .Include(t => t.Vendor)
            .Include(t => t.PurchaseOrderTrackItems)
            .FirstOrDefaultAsync(t => t.PurchaseOrderTrackId == id);

        if (track == null)
            return NotFound();

        // Manually calculate GRNQuantity
        track.GRNQuantity = track.PurchaseOrderTrackItems?.Sum(i => i.ActualQuantity) ?? 0;

        // Do NOT assign GRNTotalPrice or Balance here if they're computed in the model

        return View(track);
    }


    public async Task<IActionResult> Delete(int id)
    {
        var track = await _trackRepository.GetByIdWithItemsAsync(id);
        if (track == null)
            return NotFound();

        return View(track);
    }

    [HttpPost, ActionName("Delete")]
    [ValidateAntiForgeryToken]
    public async Task<IActionResult> DeleteConfirmed(int id)
    {
        await _trackRepository.DeleteAsync(id);
        return RedirectToAction(nameof(Index));
    }

    [HttpGet]
    public async Task<JsonResult> GetActualQuantityByPOCode(int purchaseOrderId)
    {
        var actualQuantity = await _trackRepository.GetActualQuantityByPurchaseOrderIdAsync(purchaseOrderId);
        return Json(actualQuantity);
    }

    [HttpGet]
    public async Task<IActionResult> GetTrackItemsByPO(int purchaseOrderId)
    {
        var grns = await _context.GRNs
            .Include(g => g.GRNItems)
            .Where(g => g.PurchaseOrderId == purchaseOrderId)
            .ToListAsync();

        var poItems = await _context.PurchaseOrderItems
            .Where(p => p.PurchaseOrderId == purchaseOrderId)
            .ToListAsync();

        var result = grns.Select(g => new
        {
            grnCode = g.GRNCode,
            grnDate = g.GRNDate.ToString("yyyy-MM-dd"),
            items = g.GRNItems.Select(item =>
            {
                var poItem = poItems.FirstOrDefault(p =>
                    p.MaterialType == item.MaterialType &&
                    p.MaterialName == item.MaterialName &&
                    p.Unit == item.Unit);

                decimal unitPrice = 0;

                return new
                {
                    item.MaterialType,
                    item.MaterialName,
                    item.Unit,
                    originalQuantity = poItem?.Quantity ?? 0,
                    unitPrice = unitPrice,
                    quantity = item.Quantity,
                    actualQuantity = item.ActualQuantity,
                    totalGRNValue = item.Quantity * unitPrice
                };
            }).ToList()
        });

        return Json(result);
    }
}
