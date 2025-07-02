using Microsoft.AspNetCore.Mvc;

namespace ManufacturingERP.Controllers
{
    public class HomeController : Controller
    {
        public IActionResult Index()
        {
            return View();
        }

    }
}
