using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Http;
using System.Linq;
using ManufacturingERP.Data;
using ManufacturingERP.Entity;

public class AccountController : Controller
{
    private readonly AppDbContext _context;

    public AccountController(AppDbContext context)
    {
        _context = context;
    }

    // ✅ GET: Show Registration Page
    [HttpGet]
    public IActionResult Register()
    {
        return View();
    }

    [HttpPost]
    [ValidateAntiForgeryToken]
    public IActionResult Register(User model)
    {
        if (ModelState.IsValid)
        {
            // 🔹 Check if email already exists
            if (_context.Users.Any(u => u.Email == model.Email))
            {
                ViewBag.Message = "Email already exists!";
                return View(model);
            }

            if (string.IsNullOrEmpty(model.Password))
            {
                ViewBag.Message = "Password cannot be empty.";
                return View(model);
            }

            _context.Users.Add(model);
            _context.SaveChanges();

            TempData["SuccessMessage"] = "Registration successful! You can now log in.";
            return RedirectToAction("Login");
        }
        return View(model);
    }

    // ✅ GET: Show Login Form
    [HttpGet]
    public IActionResult Login()
    {
        return View();
    }

    [HttpPost]
    [ValidateAntiForgeryToken]
    public IActionResult Login(User model)
    {
        if (string.IsNullOrEmpty(model.Email) || string.IsNullOrEmpty(model.Password))
        {
            ViewBag.Message = "Email and Password are required.";
            return View(model);
        }

        // 🔹 Find user by email
        var user = _context.Users.FirstOrDefault(u => u.Email.ToLower() == model.Email.ToLower());

        if (user != null && user.Password == model.Password) // 🔹 Simple password comparison
        {
            // ✅ Store user details in session
            HttpContext.Session.SetInt32("UserId", user.Id);
            HttpContext.Session.SetString("UserEmail", user.Email);
            HttpContext.Session.SetString("UserName", user.FirstName + " " + user.LastName);

            TempData["SuccessMessage"] = "Login successful!";
            return RedirectToAction("Index", "Vendor"); // 🔹 Redirect after login
        }
        else
        {
            ViewBag.Message = "Invalid email or password.";
        }

        return View(model);
    }

    // ✅ Logout
    public IActionResult Logout()
    {
        HttpContext.Session.Clear();
        return RedirectToAction("Login", "Account");
    }
}
