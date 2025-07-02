using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using ManufacturingERP.Entity.Models;
using ManufacuringERP.Entity.Model;

namespace ManufacturingERP.Entity
{
    public class PurchaseOrder
    {
        public readonly object TotalPrice;
        public readonly dynamic GRNCode;
        public readonly dynamic GRNDate;

        //public readonly object TotalPrice;

        [Key]
        public int PurchaseOrderId { get; set; }

        public string POCode { get; set; } // Purchase Order Code (with Year 25 at the end)

        [Required]
        public int VendorId { get; set; } // Vendor who placed the order

        [ForeignKey("VendorId")]
        public virtual Vendor Vendor { get; set; } // Navigation Property

        [Required]
        public DateTime OrderDate { get; set; } // Order Date

        [Required]
        public DateTime ExpectedDeliveryDate { get; set; } // Expected Delivery Date

        public string? Status { get; set; }

        // Parent-Child Relationship with PurchaseOrderItems
        public virtual ICollection<PurchaseOrderItem> PurchaseOrderItems { get; set; } = new List<PurchaseOrderItem>();

        // Parent-Child Relationship with GRNs (Goods Receipt Notes)
        public virtual ICollection<GRN> GRNs { get; set; } = new List<GRN>();

        
        [NotMapped]
        public decimal GrandTotal
        {
            get
            {
                return PurchaseOrderItems?.Sum(item => item.TotalPrice) ?? 0;
            }
        
        }

    }

    public class PurchaseOrderItem
    {
        [Key]
        public int PurchaseOrderItemId { get; set; }

        [Required]
        public int PurchaseOrderId { get; set; } // Foreign Key

        [ForeignKey("PurchaseOrderId")]
       // public virtual PurchaseOrder PurchaseOrder { get; set; } // Navigation Property

        [Required]
        public string MaterialType { get; set; } // DropDown: Steel, Plastic, Fabric, Wood

        [Required]
        public string MaterialName { get; set; } // Material name (e.g., specific name of the material)

        [Required]
        public string Unit { get; set; }

        [Required]
        [Range(1, int.MaxValue, ErrorMessage = "Quantity must be greater than zero.")]
        public int Quantity { get; set; } // Ordered quantity

        [Required]
        [Column(TypeName = "decimal(18,2)")]
        public decimal Price { get; set; } // Unit Price

        [NotMapped]
        public decimal TotalPrice => Quantity * Price; // Computed Total Price

        public decimal GrandTotal { get; }
      
        public virtual PurchaseOrder PurchaseOrder { get; set; }
        // Foreign Key to link PurchaseOrderItem with GRNItem
        public virtual ICollection<GRNItem> GRNItems { get; set; } = new List<GRNItem>();


    }
}