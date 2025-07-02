using ManufacturingERP.Data;
using ManufacturingERP.Repository;
using ManufacturingERP.Repository.Implementation;
using ManufacturingERP.Repository.Interface;
using ManufacuringERP.Repository; // If needed for legacy repo compatibility
using ManufacuringERP.Repository.Implementation;
using ManufacuringERP.Repository.Interface;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;

var builder = WebApplication.CreateBuilder(args);

// ------------------------------------------
// ✅ Configure Database Connection
// ------------------------------------------
builder.Services.AddDbContext<AppDbContext>(options =>
    options.UseSqlServer(builder.Configuration.GetConnectionString("DefaultConnection")));

// ------------------------------------------
// ✅ Register Application Repositories
// ------------------------------------------
builder.Services.AddScoped<IRawMaterialRepository, RawMaterialRepository>();
builder.Services.AddScoped<IVendorRepository, VendorRepository>();
builder.Services.AddScoped<IPurchaseOrderRepository, PurchaseOrderRepository>();
builder.Services.AddScoped<IInventoryRepository, InventoryRepository>();
builder.Services.AddScoped<IGRNRepository, GRNRepository>();
builder.Services.AddScoped<IPurchaseOrderTrackRepository, PurchaseOrderTrackRepository>();
builder.Services.AddScoped<IFinishedGoodsMasterRepository, FinishedGoodsMasterRepository>();
builder.Services.AddScoped<IProductionPlanRepository, ProductionPlanRepository>(); 

// ------------------------------------------
// ✅ Add MVC Services, Razor & Session
// ------------------------------------------
builder.Services.AddControllersWithViews();
builder.Services.AddRazorPages();

builder.Services.AddDistributedMemoryCache();
builder.Services.AddSession(options =>
{
    options.IdleTimeout = TimeSpan.FromMinutes(30);
    options.Cookie.HttpOnly = true;
    options.Cookie.IsEssential = true;
});

// ------------------------------------------
// ✅ Configure HSTS (Security)
// ------------------------------------------
builder.Services.AddHsts(options =>
{
    options.Preload = true;
    options.IncludeSubDomains = true;
    options.MaxAge = TimeSpan.FromDays(365);
});

var app = builder.Build();

// ------------------------------------------
// ✅ Middleware Configuration
// ------------------------------------------
if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Home/Error");
    app.UseHsts();
}

app.UseHttpsRedirection();
app.UseStaticFiles();
app.UseRouting();

app.UseSession();

app.UseAuthentication();
app.UseAuthorization();

// ✅ Automatically apply pending migrations
using (var scope = app.Services.CreateScope())
{
    var dbContext = scope.ServiceProvider.GetRequiredService<AppDbContext>();
    dbContext.Database.Migrate();
}

// ------------------------------------------
// ✅ Endpoint Routing Configuration
// ------------------------------------------
app.UseEndpoints(endpoints =>
{
    // Default route
    endpoints.MapControllerRoute(
        name: "default",
        pattern: "{controller=Home}/{action=Index}/{id?}");

    endpoints.MapControllerRoute(
        name: "rawmaterial",
        pattern: "RawMaterial/{action=Index}/{id?}",
        defaults: new { controller = "RawMaterial" });

    endpoints.MapControllerRoute(
        name: "vendor",
        pattern: "Vendor/{action=Index}/{id?}",
        defaults: new { controller = "Vendor" });

    endpoints.MapControllerRoute(
        name: "purchaseorder",
        pattern: "PurchaseOrder/{action=Index}/{id?}",
        defaults: new { controller = "PurchaseOrder" });

    endpoints.MapControllerRoute(
        name: "inventory",
        pattern: "Inventory/{action=Index}/{id?}",
        defaults: new { controller = "Inventory" });

    endpoints.MapControllerRoute(
        name: "account",
        pattern: "Account/{action=Login}/{id?}",
        defaults: new { controller = "Account" });

    endpoints.MapControllerRoute(
        name: "register",
        pattern: "Account/{action=Register}/{id?}",
        defaults: new { controller = "Account" });

    endpoints.MapControllerRoute(
        name: "grn",
        pattern: "GRN/{action=Index}/{id?}",
        defaults: new { controller = "GRN" });

    endpoints.MapControllerRoute(
        name: "productionplan",
        pattern: "ProductionPlan/{action=Index}/{id?}",
        defaults: new { controller = "ProductionPlan" }); // ✅ ProductionPlan route

    endpoints.MapRazorPages();
});

// ✅ Run the Application
app.Run();
