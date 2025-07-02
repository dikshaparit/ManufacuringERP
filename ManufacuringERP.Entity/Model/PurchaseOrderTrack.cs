    using System;
    using System.Collections.Generic;
    using System.ComponentModel.DataAnnotations.Schema;
    using System.ComponentModel.DataAnnotations;
    using System.Linq;
    using System.Text;
    using System.Threading.Tasks;
    using ManufacturingERP.Entity;
    using ManufacturingERP.Entity.Models;

    namespace ManufacuringERP.Entity.Model
    {
        public class PurchaseOrderTrack
        {
            public int PurchaseOrderTrackId { get; set; }

            // Foreign Key to PurchaseOrder
            public int PurchaseOrderId { get; set; }
            public PurchaseOrder PurchaseOrder { get; set; }

            public string POCode { get; set; } // Fetched from PurchaseOrder

            public int VendorId { get; set; }  // Fetched from PurchaseOrder
            public Vendor Vendor { get; set; }

            public DateTime OrderDate { get; set; } // Fetched from PurchaseOrder
            public DateTime ExpectedDelivery { get; set; } // Fetched from PurchaseOrder

        
            // Original ordered quantity from PurchaseOrderItems
            public decimal PurchaseOrderQuantity { get; set; }
            // Total price for the original quantity (from PurchaseOrderItems)
            public decimal PurchaseOrderTotalPrice { get; set; }

            // Actual received quantity from GRNItems
            public decimal GRNQuantity { get; set; }

            public string? Unit { get; set; }

            // Add this property for unit price
            public decimal UnitPrice { get; set; }
            // Computed: Price per unit
            public decimal GRNUnitPrice
            {
                get
                {
                    if (PurchaseOrderQuantity == 0) return 0;
                    return PurchaseOrderTotalPrice / PurchaseOrderQuantity;
                }
            }

            // Computed: Total value of the received quantity
            public decimal GRNTotalPrice
            {
                get
                {
                    return GRNQuantity * GRNUnitPrice;
                }
            }

            // Computed: Remaining balance value
            public decimal Balance
            {
                get
                {
                    return PurchaseOrderQuantity - GRNQuantity;
                }
            }

            // Navigation to child items
            public List<PurchaseOrderTrackItem> PurchaseOrderTrackItems { get; set; } = new List<PurchaseOrderTrackItem>();
        }

    public class PurchaseOrderTrackItem
    {
        public int PurchaseOrderTrackItemId { get; set; }

        // Foreign Key to parent
        public int PurchaseOrderTrackId { get; set; }
        public PurchaseOrderTrack PurchaseOrderTrack { get; set; }

        // Foreign Key to GRN
        public int GRNId { get; set; }  // FK to GRN
        public GRN GRN { get; set; }

        [Display(Name = "GRN Code")]
        public string GRNCode { get; set; }

        [Display(Name = "GRN Date")]
        [DataType(DataType.Date)]
        public DateTime? GRNDate { get; set; }  // GRN Date (nullable DateTime)

        [Display(Name = "Material Type")]
        public string MaterialType { get; set; }  // Fetched from POItem

        [Required]
        public string MaterialName { get; set; }  // Fetched from POItem

        [Required]
        public string? Unit { get; set; }  // Fetched from POItem
                                          // This is just for display, not stored in DB
       // Add this property:
    public decimal? UnitPrice { get; set; }
        public decimal OriginalQuantity { get; set; }
        public int Quantity { get; set; }
        public int ActualQuantity { get; set; }

        [NotMapped]
        public int PendingQuantity => Quantity - ActualQuantity; // Calculate dynamically
    }
}




