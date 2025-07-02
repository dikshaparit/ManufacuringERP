using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using ManufacturingERP.Entity.Models;

namespace ManufacturingERP.Entity
{
    public class GRN
    {
        [Key]
        public int GRNId { get; set; }

        [Required]
        public string? GRNCode { get; set; }  // Auto-generated code like "GRN0001"

        [Required]
        public int VendorId { get; set; }  // Taken from PurchaseOrder (no FK needed)

        [Required]
        public string? POCode { get; set; }  // Auto-fetched from PurchaseOrder

        [Required]
        [DataType(DataType.Date)]
        public DateTime GRNDate { get; set; }

        [Required]
        public string? Status { get; set; }  // e.g., Received, Pending, Cancelled

        public Vendor Vendor { get; set; } // Add this navigation property
        // Navigation property to GRN Items
        // ✅ Add this if you want to query by PurchaseOrderId
        public int PurchaseOrderId { get; set; }

        public virtual ICollection<GRNItem> GRNItems { get; set; }
    }

    public class GRNItem
    {
        [Key]
        public int GRNItemId { get; set; }

        [Required]
        public int GRNId { get; set; }

        [ForeignKey("GRNId")]
        public virtual GRN GRN { get; set; }

        [Required]
        public string MaterialType { get; set; }  // Fetched from POItem

        [Required]
        public string MaterialName { get; set; }  // Fetched from POItem

     
       

        [Required]
        public string Unit { get; set; }  // Fetched from POItem

        public int Quantity { get; set; }
        public int ActualQuantity { get; set; }

        [NotMapped]
        public int PendingQuantity { get; set; }

        public decimal OriginalQuantity { get; set; } // from PurchaseOrderItem
        // ✅ Add if you want to reference original PurchaseOrderItem
        public int? PurchaseOrderItemId { get; set; }

        [ForeignKey("PurchaseOrderItemId")]
        public virtual PurchaseOrderItem PurchaseOrderItem { get; set; }

        // ✅ Add these new properties if needed
        
    }
}