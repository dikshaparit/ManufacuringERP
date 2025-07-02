using System.Web.Mvc;
using ManufacturingERP.Entity;

public class GRNCreateViewModel
{
    public GRN GRN { get; set; }

    public List<SelectListItem> PurchaseOrders { get; set; }

    public string CompanyName { get; set; } // ✅ used to display in the view

    public List<GRNItem> GRNItems { get; set; }
}
