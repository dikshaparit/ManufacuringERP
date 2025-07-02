using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using ManufacturingERP.Entity.Models;
using System.Collections.Generic;

namespace ManufacturingERP.Entity
{
    public class RawMaterial
    {
        [Key]
        public int RawMaterialId { get; set; }

        [Required]
        public string MaterialType { get; set; } = "Unknown"; // ✅ Default value

        [Required]
        public string MaterialName { get; set; } = "Unknown"; // ✅ Default value

        [Required]
        public int VendorId { get; set; } // Foreign Key for Vendor

        public string? VendorName { get; set; }

        [Required]
        public double Quantity { get; set; }

        [Required]
        public string Unit { get; set; } = "Unknown"; // ✅ Default value

        public DateTime CreatedDate { get; set; } = DateTime.Now;
        public DateTime? ModifiedDate { get; set; }

        // Navigation Property
        public Vendor Vendor { get; set; }

        // ✅ Handle CSV string for MaterialType
        [NotMapped]
        public List<string> SelectedMaterialTypes
        {
            get => string.IsNullOrEmpty(MaterialType) ? new List<string>() : MaterialType.Split(',').ToList();
            set => MaterialType = string.Join(",", value);
        }

        // Future: Related Purchase Orders
        // public ICollection<PurchaseOrder> PurchaseOrders { get; set; }
        // Existing properties...

        // ✅ Navigation Property to FinishedGoodsItem (for reverse relationship)
        public ICollection<FinishedGoodsItem> FinishedGoodsItems { get; set; }

    }
}
