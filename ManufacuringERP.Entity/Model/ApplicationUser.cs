using Microsoft.AspNetCore.Identity;
using System;

namespace ManufacturingERP.Entity.Models
{
    public class ApplicationUser : IdentityUser<Guid> // ✅ Ensure Guid is used as the key type
    {
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string ContactNo { get; set; }
    }
}
