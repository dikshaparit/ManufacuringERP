using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using ManufacturingERP.Data;
using ManufacuringERP.Entity;
using Microsoft.EntityFrameworkCore;

namespace ManufacuringERP.Data.Data
{
    internal class DbContext
    {
        private DbContextOptions<AppDbContext> options;

        public DbContext(DbContextOptions<AppDbContext> options)
        {
            this.options = options;
        }

        internal void OnModelCreating(ModelBuilder modelBuilder)
        {
            throw new NotImplementedException();
        }
    }
}
