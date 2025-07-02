using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace ManufacturingERP.Entity
{
    public class ProductionPlan
    {
        [Key]
        public int ProductionPlanId { get; set; }

        [Required]
        [DataType(DataType.Date)]
        public DateTime ProductionDate { get; set; }

        [Required]
        [StringLength(50)]
        public string Shift { get; set; } // e.g., Morning, Evening, Night

        public int FinishedGoodsMasterId { get; set; }

        [ForeignKey("FinishedGoodsMasterId")]
        public FinishedGoodsMaster FinishedGoodsMaster { get; set; }

        [Required]
        public int PlannedQuantity { get; set; }

        public int ActualQuantity { get; set; }

        [NotMapped]
        public int BalanceQuantity => PlannedQuantity - ActualQuantity;

        [Required]
       
        //public string Status { get; set; } // e.g., Planned, In Progress, Not Started

        public bool IsActive { get; set; } // Used for the switch button
       
    }
}
