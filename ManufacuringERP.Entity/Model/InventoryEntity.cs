using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using ManufacturingERP.Entity;

namespace ManufacuringERP.Entity.Model
{
    public class Inventory
    {
        public int InventoryId { get; set; }
        // Inventory properties
        public string MaterialName { get; set; }//DropDwon:Steel,Fabric,Wood,Plastic
        public decimal Quantity { get; set; }
        public string Unit { get; set; } // Kg, Liter, Piece, etc.
        public string Location { get; set; }
        public string Status { get; set; } // Available, Reserved, Out of Stock
        public DateTime? CreatedDate { get; set; }
        public DateTime? ModifiedDate { get; set; }
        public string CreatedBy { get; set; }
        public string? ModifiedBy { get; set; }
    }

}
