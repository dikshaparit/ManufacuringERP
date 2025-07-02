using Microsoft.EntityFrameworkCore;
using ManufacturingERP.Entity;
using ManufacturingERP.Entity.Models;
using ManufacuringERP.Entity.Model;
using System;

namespace ManufacturingERP.Data
{
    public class AppDbContext : DbContext
    {
        public AppDbContext(DbContextOptions<AppDbContext> options) : base(options) { }

        public DbSet<User> Users { get; set; }
        public DbSet<RawMaterial> RawMaterials { get; set; }
        public DbSet<Vendor> Vendors { get; set; }
        public DbSet<PurchaseOrder> PurchaseOrders { get; set; }
        public DbSet<PurchaseOrderItem> PurchaseOrderItems { get; set; }
        public DbSet<Inventory> Inventories { get; set; }
        public DbSet<GRN> GRNs { get; set; }
        public DbSet<GRNItem> GRNItems { get; set; }

        public DbSet<PurchaseOrderTrack> PurchaseOrderTracks { get; set; }
        public DbSet<PurchaseOrderTrackItem> PurchaseOrderTrackItems { get; set; }

        public DbSet<FinishedGoodsMaster> FinishedGoodsMasters { get; set; }
        public DbSet<FinishedGoodsItem> FinishedGoodsItems { get; set; }

        // ✅ NEW: Production Plan
        public DbSet<ProductionPlan> ProductionPlans { get; set; }
        // Add this DbSet for actual production data
      

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);

            // ✅ Configure relationship between FinishedGoodsItem and RawMaterial
            modelBuilder.Entity<FinishedGoodsItem>()
                .HasOne(f => f.RawMaterial)
                .WithMany(r => r.FinishedGoodsItems)
                .HasForeignKey(f => f.RawMaterialId);

            // ✅ Config for PurchaseOrderTrack
            modelBuilder.Entity<PurchaseOrderTrack>()
                .HasKey(pt => pt.PurchaseOrderTrackId);

            modelBuilder.Entity<PurchaseOrderTrack>()
                .HasOne(pt => pt.PurchaseOrder)
                .WithMany()
                .HasForeignKey(pt => pt.PurchaseOrderId)
                .OnDelete(DeleteBehavior.Restrict);

            modelBuilder.Entity<PurchaseOrderTrack>()
                .HasOne(pt => pt.Vendor)
                .WithMany()
                .HasForeignKey(pt => pt.VendorId)
                .OnDelete(DeleteBehavior.Restrict);

            modelBuilder.Entity<PurchaseOrderTrack>()
                .Property(pt => pt.PurchaseOrderTotalPrice)
                .HasColumnType("decimal(18,2)");

            modelBuilder.Entity<PurchaseOrderTrackItem>()
                .HasKey(poi => poi.PurchaseOrderTrackItemId);

            modelBuilder.Entity<PurchaseOrderTrackItem>()
                .HasOne(poi => poi.PurchaseOrderTrack)
                .WithMany(pt => pt.PurchaseOrderTrackItems)
                .HasForeignKey(poi => poi.PurchaseOrderTrackId)
                .OnDelete(DeleteBehavior.Cascade);

            // ✅ Config for FinishedGoodsMaster
            modelBuilder.Entity<FinishedGoodsMaster>()
                .HasKey(fg => fg.FinishedGoodsMasterId);

            modelBuilder.Entity<FinishedGoodsMaster>()
                .Property(fg => fg.FinishedGoodsCode)
                .IsRequired();

            modelBuilder.Entity<FinishedGoodsMaster>()
                .Property(fg => fg.FinishedGoodsName)
                .IsRequired();

            // ✅ Config for FinishedGoodsItem
            modelBuilder.Entity<FinishedGoodsItem>()
                .HasKey(fgi => fgi.FinishedGoodsItemId);

            modelBuilder.Entity<FinishedGoodsItem>()
                .HasOne(fgi => fgi.FinishedGoodsMaster)
                .WithMany(fg => fg.FinishedGoodsItems)
                .HasForeignKey(fgi => fgi.FinishedGoodsMasterId)
                .OnDelete(DeleteBehavior.Cascade);

            modelBuilder.Entity<FinishedGoodsItem>()
                .Property(fgi => fgi.PlannedQuantity)
                .HasColumnType("decimal(18,2)");

            // ✅ Config for ProductionPlan
            modelBuilder.Entity<ProductionPlan>()
                .HasKey(pp => pp.ProductionPlanId);

            modelBuilder.Entity<ProductionPlan>()
                .Property(pp => pp.ProductionDate)
                .IsRequired();

            modelBuilder.Entity<ProductionPlan>()
                .Property(pp => pp.Shift)
                .HasMaxLength(50)
                .IsRequired();

            modelBuilder.Entity<ProductionPlan>()
                .Property(pp => pp.PlannedQuantity)
                .HasColumnType("int");

            modelBuilder.Entity<ProductionPlan>()
                .Property(pp => pp.ActualQuantity)
                .HasColumnType("int");

        

            modelBuilder.Entity<ProductionPlan>()
                .HasOne(pp => pp.FinishedGoodsMaster)
                .WithMany()
                .HasForeignKey(pp => pp.FinishedGoodsMasterId)
                .OnDelete(DeleteBehavior.Restrict);
        }

        public enum UnitEnum
        {
            Kg,
            Meter,
            Cm
        }
    }
}
