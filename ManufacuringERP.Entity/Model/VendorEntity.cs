using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace ManufacturingERP.Entity.Models
{
    public class Vendor
    {
        public int VendorId { get; set; }

        [Required]
        public string VendorName { get; set; }

        [Required, EmailAddress]
        public string Email { get; set; }

        [Required]
        public string PhoneNumber { get; set; }

        public string Address { get; set; }
        public string CompanyName { get; set; }
        public string Status { get; set; }

        public DateTime? CreatedDate { get; set; } = DateTime.UtcNow;
        public DateTime? ModifiedDate { get; set; }

        // ✅ Computed Property to show "VendorId - VendorName"
        [NotMapped]
        public string VendorIdAndName => $"{VendorId} - {VendorName}";

        // Ensure RawMaterials is initialized to avoid null reference errors
        public ICollection<RawMaterial> RawMaterials { get; set; } = new List<RawMaterial>();
        public ICollection<PurchaseOrder> PurchaseOrders { get; set; } = new List<PurchaseOrder>();
    }
}
