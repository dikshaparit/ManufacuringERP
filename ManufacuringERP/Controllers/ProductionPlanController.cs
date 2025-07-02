using Microsoft.AspNetCore.Mvc;
using ManufacturingERP.Entity.Models;
using ManufacturingERP.Repository;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc.Rendering;
using ManufacturingERP.Entity;
using System;

namespace ManufacturingERP.Controllers
{
    public class ProductionPlanController : Controller
    {
        private readonly IProductionPlanRepository _productionPlanRepository;
        private readonly IFinishedGoodsMasterRepository _finishedGoodsMasterRepository;

        public ProductionPlanController(
            IProductionPlanRepository productionPlanRepository,
            IFinishedGoodsMasterRepository finishedGoodsMasterRepository)
        {
            _productionPlanRepository = productionPlanRepository;
            _finishedGoodsMasterRepository = finishedGoodsMasterRepository;
        }

        public async Task<IActionResult> Index()
        {
            var plans = await _productionPlanRepository.GetAllAsync();
            return View(plans);
        }

        public async Task<IActionResult> Details(int id)
        {
            var plan = await _productionPlanRepository.GetByIdAsync(id);
            if (plan == null) return NotFound();
            return View(plan);
        }

        [HttpGet]
        public async Task<IActionResult> Create()
        {
            var finishedGoodsList = await _finishedGoodsMasterRepository.GetAllAsync();
            ViewBag.FinishedGoodsList = new SelectList(finishedGoodsList, "FinishedGoodsMasterId", "FinishedGoodsName");

            var model = new ProductionPlan
            {
                ProductionDate = DateTime.Today,
                IsActive = true
            };

            return View(model);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create(ProductionPlan model)
        {
            if (ModelState.IsValid!=true)
            {
                await _productionPlanRepository.AddAsync(model);
                return RedirectToAction(nameof(Index));
            }

            ViewBag.FinishedGoodsList = new SelectList(await _finishedGoodsMasterRepository.GetAllAsync(), "FinishedGoodsMasterId", "FinishedGoodsName");
            return View(model);
        }

        public async Task<IActionResult> Edit(int id)
        {
            var plan = await _productionPlanRepository.GetByIdAsync(id);
            if (plan == null) return NotFound();

            ViewBag.FinishedGoodsList = new SelectList(await _finishedGoodsMasterRepository.GetAllAsync(), "FinishedGoodsMasterId", "FinishedGoodsName", plan.FinishedGoodsMasterId);
            return View(plan);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(ProductionPlan plan)
        {
            if (ModelState.IsValid!=true)
            {
                await _productionPlanRepository.UpdateAsync(plan);
                return RedirectToAction(nameof(Index));
            }

            ViewBag.FinishedGoodsList = new SelectList(await _finishedGoodsMasterRepository.GetAllAsync(), "FinishedGoodsMasterId", "FinishedGoodsName", plan.FinishedGoodsMasterId);
            return View(plan);
        }

        public async Task<IActionResult> Delete(int? id)
        {
            if (id == null)
            {
                return BadRequest(); // BadRequest if id is missing
            }

            var plan = await _productionPlanRepository.GetByIdAsync(id.Value);
            if (plan == null)
            {
                return NotFound(); // NotFound if no entity found with the id
            }

            return View(plan); // Show confirmation view
        }

        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int? id)
        {
            if (id == null)
            {
                return BadRequest();
            }

            var plan = await _productionPlanRepository.GetByIdAsync(id.Value);
            if (plan == null)
            {
                return NotFound();
            }

            await _productionPlanRepository.DeleteAsync(id.Value);
            return RedirectToAction(nameof(Index));
        }

        // ✅ ADD THESE TWO METHODS FOR "Update Actual Quantity"
        [HttpGet]
        public async Task<IActionResult> UpdateActualQty(int id)
        {
            var plan = await _productionPlanRepository.GetByIdWithFinishedGoodsAsync(id);
            if (plan == null) return NotFound();

            return View(plan);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> UpdateActualQty(ProductionPlan updatedPlan)
        {
            var existingPlan = await _productionPlanRepository.GetByIdAsync(updatedPlan.ProductionPlanId);
            if (existingPlan == null) return NotFound();

            existingPlan.ActualQuantity = updatedPlan.ActualQuantity;

            // Optional: Update balance quantity
            existingPlan.ActualQuantity = updatedPlan.ActualQuantity;
            // No need to set BalanceQuantity if it's a computed property
            await _productionPlanRepository.UpdateAsync(existingPlan);
            await _productionPlanRepository.UpdateAsync(existingPlan);

            return RedirectToAction(nameof(Index));
        }
        [HttpGet]
public async Task<IActionResult> GetPlannedQuantityBalance(int finishedGoodsMasterId)
{
    // Get total planned quantity for the selected finished goods from repository
    int plannedQuantity = await _productionPlanRepository.GetTotalPlannedQuantityByFinishedGoodsIdAsync(finishedGoodsMasterId);

    // Assume you have a max production limit per FinishedGoods, e.g., 1000
    int maxProductionLimit = 1000;

    int balance = maxProductionLimit - plannedQuantity;

    return Json(new { balance = balance < 0 ? 0 : balance });
}
        [HttpGet]
        public async Task<IActionResult> GetBalanceQuantity(int finishedGoodsMasterId)
        {
            if (finishedGoodsMasterId == 0)
                return Json(0);

            int totalPlanned = await _productionPlanRepository.GetTotalPlannedQuantityAsync(finishedGoodsMasterId);
            int totalActual = await _productionPlanRepository.GetTotalActualQuantityAsync(finishedGoodsMasterId);

            int balance = totalPlanned - totalActual;
            if (balance < 0) balance = 0;

            return Json(balance);
        }

    }
}
