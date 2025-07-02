using System;
using System.Collections.Generic;

namespace ManufacturingERP.Entity
{
    // Parent Entity: FinishedGoodsMaster
    public class FinishedGoodsMaster
    {        
        public int FinishedGoodsMasterId { get; set; }

        public string FinishedGoodsCode { get; set; }

        public string FinishedGoodsName { get; set; }

        public DateTime CreatedDate { get; set; }
        public string Status { get; set; } // Expected: "Active" or "Inactive"

        // Navigation Property: One FinishedGoodsMaster has many FinishedGoodsItems
        public ICollection<FinishedGoodsItem> FinishedGoodsItems { get; set; }
        

        // Navigation Property: One FinishedGoodsMaster has many ProductionPlans
      //  public ICollection<ProductionPlan> ProductionPlans { get; set; }

    }

    // Child Entity: FinishedGoodsItem
    public class FinishedGoodsItem
    {
        public int FinishedGoodsItemId { get; set; }

        // Foreign Key to FinishedGoodsMaster
        public int FinishedGoodsMasterId { get; set; }

        // Foreign Key to RawMaterial
        public int RawMaterialId { get; set; }

        // Optional: Denormalized Material Name for display
        public string MaterialName { get; set; }

        public decimal PlannedQuantity { get; set; }

        // Navigation Property
        public FinishedGoodsMaster FinishedGoodsMaster { get; set; }
        public RawMaterial RawMaterial { get; set; }

    }
}
