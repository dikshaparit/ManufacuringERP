USE [master]
GO
/****** Object:  Database [ERP]    Script Date: 01-07-2025 02:06:01 PM ******/
CREATE DATABASE [ERP]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'ERP', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS01\MSSQL\DATA\ERP.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'ERP_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS01\MSSQL\DATA\ERP_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ERP].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ERP] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ERP] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ERP] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ERP] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ERP] SET ARITHABORT OFF 
GO
ALTER DATABASE [ERP] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [ERP] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ERP] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ERP] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ERP] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ERP] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ERP] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ERP] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ERP] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ERP] SET  DISABLE_BROKER 
GO
ALTER DATABASE [ERP] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ERP] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ERP] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ERP] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ERP] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ERP] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ERP] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ERP] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [ERP] SET  MULTI_USER 
GO
ALTER DATABASE [ERP] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ERP] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ERP] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [ERP] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
USE [ERP]
GO
/****** Object:  Table [dbo].[__EFMigrationsHistory]    Script Date: 01-07-2025 02:06:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[__EFMigrationsHistory](
	[MigrationId] [nvarchar](150) NOT NULL,
	[ProductVersion] [nvarchar](32) NOT NULL,
 CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY CLUSTERED 
(
	[MigrationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FinishedGoodsItems]    Script Date: 01-07-2025 02:06:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FinishedGoodsItems](
	[FinishedGoodsItemId] [int] IDENTITY(1,1) NOT NULL,
	[FinishedGoodsMasterId] [int] NOT NULL,
	[RawMaterialId] [int] NOT NULL,
	[MaterialName] [nvarchar](255) NULL,
	[PlannedQuantity] [decimal](18, 2) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[FinishedGoodsItemId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FinishedGoodsMasters]    Script Date: 01-07-2025 02:06:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FinishedGoodsMasters](
	[FinishedGoodsMasterId] [int] IDENTITY(1,1) NOT NULL,
	[FinishedGoodsCode] [nvarchar](100) NOT NULL,
	[FinishedGoodsName] [nvarchar](200) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[Status] [nvarchar](20) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[FinishedGoodsMasterId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GRNItems]    Script Date: 01-07-2025 02:06:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GRNItems](
	[GRNItemId] [int] IDENTITY(1,1) NOT NULL,
	[GRNId] [int] NOT NULL,
	[PurchaseOrderItemId] [int] NULL,
	[MaterialType] [varchar](50) NULL,
	[MaterialName] [nvarchar](100) NOT NULL,
	[Quantity] [int] NULL,
	[Unit] [varchar](50) NULL,
	[ActualQuantity] [int] NULL,
	[PendingQuantity] [int] NULL,
	[OriginalQuantity] [decimal](18, 2) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[GRNItemId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GRNs]    Script Date: 01-07-2025 02:06:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GRNs](
	[GRNId] [int] IDENTITY(1,1) NOT NULL,
	[GRNCode] [nvarchar](50) NOT NULL,
	[PurchaseOrderId] [int] NULL,
	[GRNDate] [datetime] NOT NULL,
	[Status] [nvarchar](50) NOT NULL,
	[VendorId] [int] NOT NULL,
	[POCode] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK__GRNs__BC0E8C42292CF636] PRIMARY KEY CLUSTERED 
(
	[GRNId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Inventories]    Script Date: 01-07-2025 02:06:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Inventories](
	[InventoryId] [int] IDENTITY(1,1) NOT NULL,
	[MaterialName] [nvarchar](100) NOT NULL,
	[Quantity] [decimal](18, 2) NOT NULL,
	[Unit] [nvarchar](50) NOT NULL,
	[Location] [nvarchar](200) NOT NULL,
	[Status] [nvarchar](50) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[ModifiedDate] [datetime] NULL,
	[CreatedBy] [nvarchar](100) NOT NULL,
	[ModifiedBy] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[InventoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Inventory]    Script Date: 01-07-2025 02:06:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Inventory](
	[InventoryId] [int] IDENTITY(1,1) NOT NULL,
	[MaterialName] [nvarchar](100) NOT NULL,
	[Quantity] [decimal](18, 2) NOT NULL,
	[Unit] [nvarchar](50) NOT NULL,
	[Location] [nvarchar](200) NOT NULL,
	[Status] [nvarchar](50) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[ModifiedDate] [datetime] NULL,
	[CreatedBy] [nvarchar](100) NOT NULL,
	[ModifiedBy] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[InventoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Login]    Script Date: 01-07-2025 02:06:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Login](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Email] [nvarchar](255) NOT NULL,
	[PasswordHash] [nvarchar](500) NOT NULL,
	[RememberMe] [bit] NULL,
	[LoginTime] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductionPlans]    Script Date: 01-07-2025 02:06:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductionPlans](
	[ProductionPlanId] [int] IDENTITY(1,1) NOT NULL,
	[ProductionDate] [date] NOT NULL,
	[Shift] [nvarchar](50) NOT NULL,
	[FinishedGoodsMasterId] [int] NOT NULL,
	[PlannedQuantity] [int] NOT NULL,
	[ActualQuantity] [int] NULL,
	[IsActive] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ProductionPlanId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PurchaseOrderItems]    Script Date: 01-07-2025 02:06:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PurchaseOrderItems](
	[PurchaseOrderItemId] [int] IDENTITY(1,1) NOT NULL,
	[PurchaseOrderId] [int] NOT NULL,
	[MaterialType] [varchar](255) NULL,
	[Unit] [nvarchar](max) NOT NULL,
	[Quantity] [int] NOT NULL,
	[Price] [decimal](18, 2) NOT NULL,
	[MaterialName] [nvarchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[PurchaseOrderItemId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PurchaseOrders]    Script Date: 01-07-2025 02:06:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PurchaseOrders](
	[PurchaseOrderId] [int] IDENTITY(1,1) NOT NULL,
	[POCode] [nvarchar](max) NULL,
	[VendorId] [int] NOT NULL,
	[OrderDate] [datetime] NOT NULL,
	[ExpectedDeliveryDate] [datetime] NOT NULL,
	[Status] [nvarchar](50) NULL,
	[CompanyName] [nvarchar](255) NULL,
	[PurchaseOrderTrackId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[PurchaseOrderId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PurchaseOrderTrackItems]    Script Date: 01-07-2025 02:06:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PurchaseOrderTrackItems](
	[PurchaseOrderTrackItemId] [int] IDENTITY(1,1) NOT NULL,
	[PurchaseOrderTrackId] [int] NOT NULL,
	[MaterialType] [nvarchar](100) NULL,
	[MaterialName] [nvarchar](100) NOT NULL,
	[Unit] [nvarchar](50) NOT NULL,
	[Quantity] [int] NOT NULL,
	[ActualQuantity] [int] NOT NULL,
	[PendingQuantity]  AS ([Quantity]-[ActualQuantity]) PERSISTED,
	[GRNId] [int] NULL,
	[GRNDate] [datetime] NULL,
	[GRNCode] [nvarchar](100) NULL,
	[OriginalQuantity] [decimal](18, 2) NULL,
	[UnitPrice] [decimal](18, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[PurchaseOrderTrackItemId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PurchaseOrderTracks]    Script Date: 01-07-2025 02:06:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PurchaseOrderTracks](
	[PurchaseOrderTrackId] [int] IDENTITY(1,1) NOT NULL,
	[PurchaseOrderId] [int] NOT NULL,
	[POCode] [nvarchar](100) NOT NULL,
	[VendorId] [int] NOT NULL,
	[OrderDate] [datetime] NOT NULL,
	[ExpectedDelivery] [datetime] NOT NULL,
	[Balance] [decimal](18, 2) NULL,
	[TotalPrice] [decimal](18, 2) NOT NULL,
	[ActualQuantity] [decimal](18, 2) NOT NULL,
	[Price] [decimal](18, 2) NOT NULL,
	[Quantity] [decimal](18, 2) NOT NULL,
	[GRNQuantity] [decimal](18, 2) NOT NULL,
	[OriQuantity] [decimal](18, 2) NOT NULL,
	[OriTotalPrice] [decimal](18, 2) NOT NULL,
	[PurchaseOrderQuantity] [decimal](18, 2) NOT NULL,
	[PurchaseOrderTotalPrice] [decimal](18, 2) NOT NULL,
	[UnitPrice] [decimal](18, 2) NOT NULL,
	[Unit] [varchar](50) NULL,
 CONSTRAINT [PK__Purchase__DE8AB660C09B0CFF] PRIMARY KEY CLUSTERED 
(
	[PurchaseOrderTrackId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RawMaterials]    Script Date: 01-07-2025 02:06:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RawMaterials](
	[RawMaterialId] [int] IDENTITY(1,1) NOT NULL,
	[MaterialType] [nvarchar](255) NOT NULL,
	[VendorId] [int] NOT NULL,
	[Quantity] [float] NOT NULL,
	[Unit] [nvarchar](255) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[ModifiedDate] [datetime] NULL,
	[VendorName] [nvarchar](255) NULL,
	[MaterialName] [nvarchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[RawMaterialId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 01-07-2025 02:06:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](50) NOT NULL,
	[LastName] [nvarchar](50) NOT NULL,
	[Email] [nvarchar](100) NOT NULL,
	[Password] [nvarchar](255) NOT NULL,
	[ContactNo] [nvarchar](15) NOT NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Vendors]    Script Date: 01-07-2025 02:06:01 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Vendors](
	[VendorName] [nvarchar](100) NOT NULL,
	[Email] [nvarchar](255) NOT NULL,
	[PhoneNumber] [nvarchar](20) NOT NULL,
	[Address] [nvarchar](250) NULL,
	[CompanyName] [nvarchar](150) NOT NULL,
	[Status] [nvarchar](10) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[ModifiedDate] [datetime] NULL,
	[VendorId] [int] IDENTITY(1,1) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[VendorId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[FinishedGoodsItems] ON 

INSERT [dbo].[FinishedGoodsItems] ([FinishedGoodsItemId], [FinishedGoodsMasterId], [RawMaterialId], [MaterialName], [PlannedQuantity]) VALUES (2, 2, 28, N'Stainless Steel sheets,Caps ', CAST(200.00 AS Decimal(18, 2)))
INSERT [dbo].[FinishedGoodsItems] ([FinishedGoodsItemId], [FinishedGoodsMasterId], [RawMaterialId], [MaterialName], [PlannedQuantity]) VALUES (3, 2, 29, N'Silicone Ring', CAST(100.00 AS Decimal(18, 2)))
INSERT [dbo].[FinishedGoodsItems] ([FinishedGoodsItemId], [FinishedGoodsMasterId], [RawMaterialId], [MaterialName], [PlannedQuantity]) VALUES (5, 4, 30, N'Cotton Fabric', CAST(30.00 AS Decimal(18, 2)))
INSERT [dbo].[FinishedGoodsItems] ([FinishedGoodsItemId], [FinishedGoodsMasterId], [RawMaterialId], [MaterialName], [PlannedQuantity]) VALUES (6, 4, 31, N'Metal Zipper', CAST(10.00 AS Decimal(18, 2)))
INSERT [dbo].[FinishedGoodsItems] ([FinishedGoodsItemId], [FinishedGoodsMasterId], [RawMaterialId], [MaterialName], [PlannedQuantity]) VALUES (7, 4, 32, N'Polyester Thread', CAST(10.00 AS Decimal(18, 2)))
INSERT [dbo].[FinishedGoodsItems] ([FinishedGoodsItemId], [FinishedGoodsMasterId], [RawMaterialId], [MaterialName], [PlannedQuantity]) VALUES (8, 4, 33, N'Plastic Buttons', CAST(20.00 AS Decimal(18, 2)))
SET IDENTITY_INSERT [dbo].[FinishedGoodsItems] OFF
GO
SET IDENTITY_INSERT [dbo].[FinishedGoodsMasters] ON 

INSERT [dbo].[FinishedGoodsMasters] ([FinishedGoodsMasterId], [FinishedGoodsCode], [FinishedGoodsName], [CreatedDate], [Status]) VALUES (2, N'FG001', N'Steel Bottole', CAST(N'2025-05-30T15:56:32.660' AS DateTime), N'Active')
INSERT [dbo].[FinishedGoodsMasters] ([FinishedGoodsMasterId], [FinishedGoodsCode], [FinishedGoodsName], [CreatedDate], [Status]) VALUES (4, N'FG002', N'Fabric Jacket', CAST(N'2025-05-30T16:37:29.090' AS DateTime), N'Active')
SET IDENTITY_INSERT [dbo].[FinishedGoodsMasters] OFF
GO
SET IDENTITY_INSERT [dbo].[GRNItems] ON 

INSERT [dbo].[GRNItems] ([GRNItemId], [GRNId], [PurchaseOrderItemId], [MaterialType], [MaterialName], [Quantity], [Unit], [ActualQuantity], [PendingQuantity], [OriginalQuantity]) VALUES (26, 42, 40, N'Steel', N'Steel(Sheets)', 500, N'Piece', 150, NULL, CAST(500.00 AS Decimal(18, 2)))
INSERT [dbo].[GRNItems] ([GRNItemId], [GRNId], [PurchaseOrderItemId], [MaterialType], [MaterialName], [Quantity], [Unit], [ActualQuantity], [PendingQuantity], [OriginalQuantity]) VALUES (27, 43, 40, N'Steel', N'Steel(Sheets)', 350, N'Piece', 120, NULL, CAST(350.00 AS Decimal(18, 2)))
INSERT [dbo].[GRNItems] ([GRNItemId], [GRNId], [PurchaseOrderItemId], [MaterialType], [MaterialName], [Quantity], [Unit], [ActualQuantity], [PendingQuantity], [OriginalQuantity]) VALUES (29, 45, 40, N'Steel', N'Steel(Sheets)', 130, N'Piece', 100, NULL, CAST(130.00 AS Decimal(18, 2)))
INSERT [dbo].[GRNItems] ([GRNItemId], [GRNId], [PurchaseOrderItemId], [MaterialType], [MaterialName], [Quantity], [Unit], [ActualQuantity], [PendingQuantity], [OriginalQuantity]) VALUES (32, 48, 45, N'Fabric', N'Georgette', 900, N'Meter', 200, NULL, CAST(0.00 AS Decimal(18, 2)))
INSERT [dbo].[GRNItems] ([GRNItemId], [GRNId], [PurchaseOrderItemId], [MaterialType], [MaterialName], [Quantity], [Unit], [ActualQuantity], [PendingQuantity], [OriginalQuantity]) VALUES (33, 49, 45, N'Fabric', N'Georgette', 700, N'Meter', 300, NULL, CAST(0.00 AS Decimal(18, 2)))
INSERT [dbo].[GRNItems] ([GRNItemId], [GRNId], [PurchaseOrderItemId], [MaterialType], [MaterialName], [Quantity], [Unit], [ActualQuantity], [PendingQuantity], [OriginalQuantity]) VALUES (34, 50, 46, N'Wood', N'Wood(sheets)', 500, N'Piece', 50, NULL, CAST(0.00 AS Decimal(18, 2)))
INSERT [dbo].[GRNItems] ([GRNItemId], [GRNId], [PurchaseOrderItemId], [MaterialType], [MaterialName], [Quantity], [Unit], [ActualQuantity], [PendingQuantity], [OriginalQuantity]) VALUES (35, 50, 47, N'Steel', N'Steel(Sheets)', 700, N'Piece', 150, NULL, CAST(0.00 AS Decimal(18, 2)))
INSERT [dbo].[GRNItems] ([GRNItemId], [GRNId], [PurchaseOrderItemId], [MaterialType], [MaterialName], [Quantity], [Unit], [ActualQuantity], [PendingQuantity], [OriginalQuantity]) VALUES (36, 51, 46, N'Wood', N'Wood(sheets)', 450, N'Piece', 150, NULL, CAST(0.00 AS Decimal(18, 2)))
INSERT [dbo].[GRNItems] ([GRNItemId], [GRNId], [PurchaseOrderItemId], [MaterialType], [MaterialName], [Quantity], [Unit], [ActualQuantity], [PendingQuantity], [OriginalQuantity]) VALUES (37, 51, 47, N'Steel', N'Steel(Sheets)', 550, N'Piece', 120, NULL, CAST(0.00 AS Decimal(18, 2)))
INSERT [dbo].[GRNItems] ([GRNItemId], [GRNId], [PurchaseOrderItemId], [MaterialType], [MaterialName], [Quantity], [Unit], [ActualQuantity], [PendingQuantity], [OriginalQuantity]) VALUES (38, 52, 46, N'Wood', N'Wood(sheets)', 300, N'Piece', 100, NULL, CAST(0.00 AS Decimal(18, 2)))
INSERT [dbo].[GRNItems] ([GRNItemId], [GRNId], [PurchaseOrderItemId], [MaterialType], [MaterialName], [Quantity], [Unit], [ActualQuantity], [PendingQuantity], [OriginalQuantity]) VALUES (39, 52, 47, N'Steel', N'Steel(Sheets)', 430, N'Piece', 30, NULL, CAST(0.00 AS Decimal(18, 2)))
INSERT [dbo].[GRNItems] ([GRNItemId], [GRNId], [PurchaseOrderItemId], [MaterialType], [MaterialName], [Quantity], [Unit], [ActualQuantity], [PendingQuantity], [OriginalQuantity]) VALUES (41, 54, 40, N'Steel', N'Steel(Sheets)', 130, N'Piece', 30, NULL, CAST(0.00 AS Decimal(18, 2)))
INSERT [dbo].[GRNItems] ([GRNItemId], [GRNId], [PurchaseOrderItemId], [MaterialType], [MaterialName], [Quantity], [Unit], [ActualQuantity], [PendingQuantity], [OriginalQuantity]) VALUES (42, 55, 49, N'Wood', N'sheets', 200, N'Piece', 20, NULL, CAST(0.00 AS Decimal(18, 2)))
INSERT [dbo].[GRNItems] ([GRNItemId], [GRNId], [PurchaseOrderItemId], [MaterialType], [MaterialName], [Quantity], [Unit], [ActualQuantity], [PendingQuantity], [OriginalQuantity]) VALUES (43, 56, 53, N'Wood', N'Flie', 120, N'Piece', 20, NULL, CAST(0.00 AS Decimal(18, 2)))
INSERT [dbo].[GRNItems] ([GRNItemId], [GRNId], [PurchaseOrderItemId], [MaterialType], [MaterialName], [Quantity], [Unit], [ActualQuantity], [PendingQuantity], [OriginalQuantity]) VALUES (44, 57, 53, N'Wood', N'Flie', 100, N'Piece', 50, NULL, CAST(0.00 AS Decimal(18, 2)))
INSERT [dbo].[GRNItems] ([GRNItemId], [GRNId], [PurchaseOrderItemId], [MaterialType], [MaterialName], [Quantity], [Unit], [ActualQuantity], [PendingQuantity], [OriginalQuantity]) VALUES (46, 59, 54, N'Fabric', N'Cotton', 250, N'Meter', 50, NULL, CAST(0.00 AS Decimal(18, 2)))
INSERT [dbo].[GRNItems] ([GRNItemId], [GRNId], [PurchaseOrderItemId], [MaterialType], [MaterialName], [Quantity], [Unit], [ActualQuantity], [PendingQuantity], [OriginalQuantity]) VALUES (47, 60, 14, N'Wood', N'Unknown', 200, N'Kg', 20, NULL, CAST(0.00 AS Decimal(18, 2)))
INSERT [dbo].[GRNItems] ([GRNItemId], [GRNId], [PurchaseOrderItemId], [MaterialType], [MaterialName], [Quantity], [Unit], [ActualQuantity], [PendingQuantity], [OriginalQuantity]) VALUES (48, 61, 54, N'Fabric', N'Cotton', 200, N'Meter', 100, NULL, CAST(0.00 AS Decimal(18, 2)))
INSERT [dbo].[GRNItems] ([GRNItemId], [GRNId], [PurchaseOrderItemId], [MaterialType], [MaterialName], [Quantity], [Unit], [ActualQuantity], [PendingQuantity], [OriginalQuantity]) VALUES (50, 63, 54, N'Fabric', N'Cotton', 100, N'Meter', 50, NULL, CAST(0.00 AS Decimal(18, 2)))
INSERT [dbo].[GRNItems] ([GRNItemId], [GRNId], [PurchaseOrderItemId], [MaterialType], [MaterialName], [Quantity], [Unit], [ActualQuantity], [PendingQuantity], [OriginalQuantity]) VALUES (51, 64, 54, N'Fabric', N'Cotton', 50, N'Meter', 25, NULL, CAST(0.00 AS Decimal(18, 2)))
INSERT [dbo].[GRNItems] ([GRNItemId], [GRNId], [PurchaseOrderItemId], [MaterialType], [MaterialName], [Quantity], [Unit], [ActualQuantity], [PendingQuantity], [OriginalQuantity]) VALUES (53, 66, 57, N'Steel', N'Steel(Sheets)', 400, N'Piece', 100, NULL, CAST(0.00 AS Decimal(18, 2)))
INSERT [dbo].[GRNItems] ([GRNItemId], [GRNId], [PurchaseOrderItemId], [MaterialType], [MaterialName], [Quantity], [Unit], [ActualQuantity], [PendingQuantity], [OriginalQuantity]) VALUES (54, 66, 58, N'Wood', N'sheets', 600, N'Piece', 200, NULL, CAST(0.00 AS Decimal(18, 2)))
INSERT [dbo].[GRNItems] ([GRNItemId], [GRNId], [PurchaseOrderItemId], [MaterialType], [MaterialName], [Quantity], [Unit], [ActualQuantity], [PendingQuantity], [OriginalQuantity]) VALUES (55, 66, 59, N'Plastic', N'Pipe', 200, N'Piece', 50, NULL, CAST(0.00 AS Decimal(18, 2)))
INSERT [dbo].[GRNItems] ([GRNItemId], [GRNId], [PurchaseOrderItemId], [MaterialType], [MaterialName], [Quantity], [Unit], [ActualQuantity], [PendingQuantity], [OriginalQuantity]) VALUES (56, 67, 45, N'Fabric', N'Georgette', 400, N'Meter', 100, NULL, CAST(0.00 AS Decimal(18, 2)))
INSERT [dbo].[GRNItems] ([GRNItemId], [GRNId], [PurchaseOrderItemId], [MaterialType], [MaterialName], [Quantity], [Unit], [ActualQuantity], [PendingQuantity], [OriginalQuantity]) VALUES (57, 68, 53, N'Wood', N'Flie', 50, N'Piece', 10, NULL, CAST(0.00 AS Decimal(18, 2)))
INSERT [dbo].[GRNItems] ([GRNItemId], [GRNId], [PurchaseOrderItemId], [MaterialType], [MaterialName], [Quantity], [Unit], [ActualQuantity], [PendingQuantity], [OriginalQuantity]) VALUES (58, 69, 53, N'Wood', N'Flie', 40, N'Piece', 20, NULL, CAST(0.00 AS Decimal(18, 2)))
INSERT [dbo].[GRNItems] ([GRNItemId], [GRNId], [PurchaseOrderItemId], [MaterialType], [MaterialName], [Quantity], [Unit], [ActualQuantity], [PendingQuantity], [OriginalQuantity]) VALUES (59, 70, 57, N'Steel', N'Steel(Sheets)', 300, N'Piece', 200, NULL, CAST(0.00 AS Decimal(18, 2)))
INSERT [dbo].[GRNItems] ([GRNItemId], [GRNId], [PurchaseOrderItemId], [MaterialType], [MaterialName], [Quantity], [Unit], [ActualQuantity], [PendingQuantity], [OriginalQuantity]) VALUES (60, 70, 58, N'Wood', N'sheets', 400, N'Piece', 200, NULL, CAST(0.00 AS Decimal(18, 2)))
INSERT [dbo].[GRNItems] ([GRNItemId], [GRNId], [PurchaseOrderItemId], [MaterialType], [MaterialName], [Quantity], [Unit], [ActualQuantity], [PendingQuantity], [OriginalQuantity]) VALUES (61, 70, 59, N'Plastic', N'Pipe', 150, N'Piece', 50, NULL, CAST(0.00 AS Decimal(18, 2)))
INSERT [dbo].[GRNItems] ([GRNItemId], [GRNId], [PurchaseOrderItemId], [MaterialType], [MaterialName], [Quantity], [Unit], [ActualQuantity], [PendingQuantity], [OriginalQuantity]) VALUES (62, 71, 53, N'Wood', N'Flie', 20, N'Piece', 10, NULL, CAST(0.00 AS Decimal(18, 2)))
INSERT [dbo].[GRNItems] ([GRNItemId], [GRNId], [PurchaseOrderItemId], [MaterialType], [MaterialName], [Quantity], [Unit], [ActualQuantity], [PendingQuantity], [OriginalQuantity]) VALUES (63, 72, 60, N'Steel', N'Steel(Rods)', 500, N'Piece', 100, NULL, CAST(0.00 AS Decimal(18, 2)))
INSERT [dbo].[GRNItems] ([GRNItemId], [GRNId], [PurchaseOrderItemId], [MaterialType], [MaterialName], [Quantity], [Unit], [ActualQuantity], [PendingQuantity], [OriginalQuantity]) VALUES (64, 73, 60, N'Steel', N'Steel(Rods)', 400, N'Piece', 200, NULL, CAST(0.00 AS Decimal(18, 2)))
INSERT [dbo].[GRNItems] ([GRNItemId], [GRNId], [PurchaseOrderItemId], [MaterialType], [MaterialName], [Quantity], [Unit], [ActualQuantity], [PendingQuantity], [OriginalQuantity]) VALUES (65, 74, 60, N'Steel', N'Steel(Rods)', 200, N'Piece', 10, NULL, CAST(0.00 AS Decimal(18, 2)))
SET IDENTITY_INSERT [dbo].[GRNItems] OFF
GO
SET IDENTITY_INSERT [dbo].[GRNs] ON 

INSERT [dbo].[GRNs] ([GRNId], [GRNCode], [PurchaseOrderId], [GRNDate], [Status], [VendorId], [POCode]) VALUES (10, N'GRN-20250416-001', 18, CAST(N'2025-04-16T00:00:00.000' AS DateTime), N'Received', 0, N'')
INSERT [dbo].[GRNs] ([GRNId], [GRNCode], [PurchaseOrderId], [GRNDate], [Status], [VendorId], [POCode]) VALUES (12, N'GRN-MISSING', 18, CAST(N'2025-04-17T00:00:00.000' AS DateTime), N'Received', 0, N'')
INSERT [dbo].[GRNs] ([GRNId], [GRNCode], [PurchaseOrderId], [GRNDate], [Status], [VendorId], [POCode]) VALUES (14, N'GRN-MISSING', 18, CAST(N'2025-04-17T00:00:00.000' AS DateTime), N'Received', 0, N'')
INSERT [dbo].[GRNs] ([GRNId], [GRNCode], [PurchaseOrderId], [GRNDate], [Status], [VendorId], [POCode]) VALUES (16, N'GRN-MISSING', 18, CAST(N'2025-04-17T00:00:00.000' AS DateTime), N'Received', 0, N'')
INSERT [dbo].[GRNs] ([GRNId], [GRNCode], [PurchaseOrderId], [GRNDate], [Status], [VendorId], [POCode]) VALUES (18, N'GRN-MISSING', 15, CAST(N'2025-04-17T00:00:00.000' AS DateTime), N'Received', 0, N'')
INSERT [dbo].[GRNs] ([GRNId], [GRNCode], [PurchaseOrderId], [GRNDate], [Status], [VendorId], [POCode]) VALUES (20, N'GRN-MISSING', 17, CAST(N'2025-04-17T00:00:00.000' AS DateTime), N'Partial', 0, N'')
INSERT [dbo].[GRNs] ([GRNId], [GRNCode], [PurchaseOrderId], [GRNDate], [Status], [VendorId], [POCode]) VALUES (23, N'GRN-GRN-20250417-0061', 13, CAST(N'2025-04-17T00:00:00.000' AS DateTime), N'Received', 0, N'')
INSERT [dbo].[GRNs] ([GRNId], [GRNCode], [PurchaseOrderId], [GRNDate], [Status], [VendorId], [POCode]) VALUES (24, N'GRN-GRN-20250417-0071', 12, CAST(N'2025-04-17T00:00:00.000' AS DateTime), N'Cancelled', 0, N'')
INSERT [dbo].[GRNs] ([GRNId], [GRNCode], [PurchaseOrderId], [GRNDate], [Status], [VendorId], [POCode]) VALUES (25, N'GRN-GRN-20250417-0081', 18, CAST(N'2025-04-17T00:00:00.000' AS DateTime), N'Partial', 0, N'')
INSERT [dbo].[GRNs] ([GRNId], [GRNCode], [PurchaseOrderId], [GRNDate], [Status], [VendorId], [POCode]) VALUES (42, N'GRN0041', 18, CAST(N'2025-04-22T00:00:00.000' AS DateTime), N'Pending', 9, N'PO-20250416145244')
INSERT [dbo].[GRNs] ([GRNId], [GRNCode], [PurchaseOrderId], [GRNDate], [Status], [VendorId], [POCode]) VALUES (43, N'GRN0043', 18, CAST(N'2025-04-22T00:00:00.000' AS DateTime), N'Pending', 9, N'PO-20250416145244')
INSERT [dbo].[GRNs] ([GRNId], [GRNCode], [PurchaseOrderId], [GRNDate], [Status], [VendorId], [POCode]) VALUES (45, N'GRN0045', 18, CAST(N'2025-04-22T00:00:00.000' AS DateTime), N'Pending', 9, N'PO-20250416145244')
INSERT [dbo].[GRNs] ([GRNId], [GRNCode], [PurchaseOrderId], [GRNDate], [Status], [VendorId], [POCode]) VALUES (48, N'GRN0046', 19, CAST(N'2025-04-22T00:00:00.000' AS DateTime), N'Pending', 13, N'PO-20250422155033')
INSERT [dbo].[GRNs] ([GRNId], [GRNCode], [PurchaseOrderId], [GRNDate], [Status], [VendorId], [POCode]) VALUES (49, N'GRN0049', 19, CAST(N'2025-04-22T00:00:00.000' AS DateTime), N'Pending', 13, N'PO-20250422155033')
INSERT [dbo].[GRNs] ([GRNId], [GRNCode], [PurchaseOrderId], [GRNDate], [Status], [VendorId], [POCode]) VALUES (50, N'GRN0050', 20, CAST(N'2025-04-22T00:00:00.000' AS DateTime), N'Pending', 15, N'PO-20250422155800')
INSERT [dbo].[GRNs] ([GRNId], [GRNCode], [PurchaseOrderId], [GRNDate], [Status], [VendorId], [POCode]) VALUES (51, N'GRN0051', 0, CAST(N'2025-04-22T00:00:00.000' AS DateTime), N'Pending', 15, N'PO-20250422155800')
INSERT [dbo].[GRNs] ([GRNId], [GRNCode], [PurchaseOrderId], [GRNDate], [Status], [VendorId], [POCode]) VALUES (52, N'GRN0052', 0, CAST(N'2025-04-22T00:00:00.000' AS DateTime), N'Received', 15, N'PO-20250422155800')
INSERT [dbo].[GRNs] ([GRNId], [GRNCode], [PurchaseOrderId], [GRNDate], [Status], [VendorId], [POCode]) VALUES (54, N'GRN0054', 0, CAST(N'2025-04-22T00:00:00.000' AS DateTime), N'Received', 9, N'PO-20250416145244')
INSERT [dbo].[GRNs] ([GRNId], [GRNCode], [PurchaseOrderId], [GRNDate], [Status], [VendorId], [POCode]) VALUES (55, N'GRN0055', 21, CAST(N'2025-04-29T00:00:00.000' AS DateTime), N'Pending', 12, N'PO-20250424113227')
INSERT [dbo].[GRNs] ([GRNId], [GRNCode], [PurchaseOrderId], [GRNDate], [Status], [VendorId], [POCode]) VALUES (56, N'GRN0056', 23, CAST(N'2025-05-02T00:00:00.000' AS DateTime), N'Pending', 2, N'PO-20250502122250')
INSERT [dbo].[GRNs] ([GRNId], [GRNCode], [PurchaseOrderId], [GRNDate], [Status], [VendorId], [POCode]) VALUES (57, N'GRN0057', 23, CAST(N'2025-05-02T00:00:00.000' AS DateTime), N'Pending', 2, N'PO-20250502122250')
INSERT [dbo].[GRNs] ([GRNId], [GRNCode], [PurchaseOrderId], [GRNDate], [Status], [VendorId], [POCode]) VALUES (59, N'GRN0058', 24, CAST(N'2025-05-03T00:00:00.000' AS DateTime), N'Pending', 13, N'PO-20250503115654')
INSERT [dbo].[GRNs] ([GRNId], [GRNCode], [PurchaseOrderId], [GRNDate], [Status], [VendorId], [POCode]) VALUES (60, N'GRN0060', 9, CAST(N'2025-05-05T00:00:00.000' AS DateTime), N'Pending', 13, N'PO-20250408231151')
INSERT [dbo].[GRNs] ([GRNId], [GRNCode], [PurchaseOrderId], [GRNDate], [Status], [VendorId], [POCode]) VALUES (61, N'GRN0061', 24, CAST(N'2025-05-05T00:00:00.000' AS DateTime), N'Pending', 13, N'PO-20250503115654')
INSERT [dbo].[GRNs] ([GRNId], [GRNCode], [PurchaseOrderId], [GRNDate], [Status], [VendorId], [POCode]) VALUES (63, N'GRN0062', 24, CAST(N'2025-05-06T00:00:00.000' AS DateTime), N'Pending', 13, N'PO-20250503115654')
INSERT [dbo].[GRNs] ([GRNId], [GRNCode], [PurchaseOrderId], [GRNDate], [Status], [VendorId], [POCode]) VALUES (64, N'GRN0064', 24, CAST(N'2025-05-07T00:00:00.000' AS DateTime), N'Pending', 13, N'PO-20250503115654')
INSERT [dbo].[GRNs] ([GRNId], [GRNCode], [PurchaseOrderId], [GRNDate], [Status], [VendorId], [POCode]) VALUES (66, N'GRN0065', 26, CAST(N'2025-05-19T00:00:00.000' AS DateTime), N'Pending', 7, N'PO-20250519142349')
INSERT [dbo].[GRNs] ([GRNId], [GRNCode], [PurchaseOrderId], [GRNDate], [Status], [VendorId], [POCode]) VALUES (67, N'GRN0067', 19, CAST(N'2025-05-19T00:00:00.000' AS DateTime), N'Pending', 13, N'PO-20250422155033')
INSERT [dbo].[GRNs] ([GRNId], [GRNCode], [PurchaseOrderId], [GRNDate], [Status], [VendorId], [POCode]) VALUES (68, N'GRN0068', 23, CAST(N'2025-05-19T00:00:00.000' AS DateTime), N'Pending', 2, N'PO-20250502122250')
INSERT [dbo].[GRNs] ([GRNId], [GRNCode], [PurchaseOrderId], [GRNDate], [Status], [VendorId], [POCode]) VALUES (69, N'GRN0069', 23, CAST(N'2025-05-19T00:00:00.000' AS DateTime), N'Pending', 2, N'PO-20250502122250')
INSERT [dbo].[GRNs] ([GRNId], [GRNCode], [PurchaseOrderId], [GRNDate], [Status], [VendorId], [POCode]) VALUES (70, N'GRN0070', 26, CAST(N'2025-05-19T00:00:00.000' AS DateTime), N'Pending', 7, N'PO-20250519142349')
INSERT [dbo].[GRNs] ([GRNId], [GRNCode], [PurchaseOrderId], [GRNDate], [Status], [VendorId], [POCode]) VALUES (71, N'GRN0071', 23, CAST(N'2025-05-19T00:00:00.000' AS DateTime), N'Pending', 2, N'PO-20250502122250')
INSERT [dbo].[GRNs] ([GRNId], [GRNCode], [PurchaseOrderId], [GRNDate], [Status], [VendorId], [POCode]) VALUES (72, N'GRN0072', 27, CAST(N'2025-05-20T00:00:00.000' AS DateTime), N'Pending', 16, N'PO-20250520124633')
INSERT [dbo].[GRNs] ([GRNId], [GRNCode], [PurchaseOrderId], [GRNDate], [Status], [VendorId], [POCode]) VALUES (73, N'GRN0073', 27, CAST(N'2025-05-20T00:00:00.000' AS DateTime), N'Pending', 16, N'PO-20250520124633')
INSERT [dbo].[GRNs] ([GRNId], [GRNCode], [PurchaseOrderId], [GRNDate], [Status], [VendorId], [POCode]) VALUES (74, N'GRN0074', 0, CAST(N'2025-05-21T00:00:00.000' AS DateTime), N'Received', 16, N'PO-20250520124633')
SET IDENTITY_INSERT [dbo].[GRNs] OFF
GO
SET IDENTITY_INSERT [dbo].[Inventories] ON 

INSERT [dbo].[Inventories] ([InventoryId], [MaterialName], [Quantity], [Unit], [Location], [Status], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy]) VALUES (3, N'Steel', CAST(120.00 AS Decimal(18, 2)), N'Kg', N'Latur Midc', N'Available', CAST(N'2025-04-08T15:00:39.360' AS DateTime), CAST(N'2025-04-09T11:48:55.977' AS DateTime), N'Admin', N'Admin')
INSERT [dbo].[Inventories] ([InventoryId], [MaterialName], [Quantity], [Unit], [Location], [Status], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy]) VALUES (5, N'Fabric', CAST(250.00 AS Decimal(18, 2)), N'Kg', N'Dhule', N'Reserved', CAST(N'2025-04-08T15:23:51.007' AS DateTime), CAST(N'2025-04-08T23:32:26.357' AS DateTime), N'Admin', N'Admin')
INSERT [dbo].[Inventories] ([InventoryId], [MaterialName], [Quantity], [Unit], [Location], [Status], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy]) VALUES (6, N'Fabric', CAST(150.00 AS Decimal(18, 2)), N'Piece', N'Pune MIDC', N'Available', CAST(N'2025-04-08T23:12:53.757' AS DateTime), CAST(N'2025-04-08T23:13:14.183' AS DateTime), N'Admin', N'Admin')
INSERT [dbo].[Inventories] ([InventoryId], [MaterialName], [Quantity], [Unit], [Location], [Status], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy]) VALUES (8, N'Wood', CAST(200.00 AS Decimal(18, 2)), N'Kg', N'Solapur', N'Available', CAST(N'2025-05-06T14:37:50.000' AS DateTime), NULL, N'Admin', NULL)
INSERT [dbo].[Inventories] ([InventoryId], [MaterialName], [Quantity], [Unit], [Location], [Status], [CreatedDate], [ModifiedDate], [CreatedBy], [ModifiedBy]) VALUES (9, N'Fabric', CAST(500.00 AS Decimal(18, 2)), N'Kg', N'Solapur', N'Available', CAST(N'2025-05-06T14:38:18.123' AS DateTime), CAST(N'2025-05-17T15:32:06.753' AS DateTime), N'Admin', N'Admin')
SET IDENTITY_INSERT [dbo].[Inventories] OFF
GO
SET IDENTITY_INSERT [dbo].[Login] ON 

INSERT [dbo].[Login] ([Id], [Email], [PasswordHash], [RememberMe], [LoginTime]) VALUES (1, N'user@example.com', N'hashed_password_here', 1, CAST(N'2025-03-12T15:12:49.560' AS DateTime))
SET IDENTITY_INSERT [dbo].[Login] OFF
GO
SET IDENTITY_INSERT [dbo].[ProductionPlans] ON 

INSERT [dbo].[ProductionPlans] ([ProductionPlanId], [ProductionDate], [Shift], [FinishedGoodsMasterId], [PlannedQuantity], [ActualQuantity], [IsActive]) VALUES (6, CAST(N'2025-06-04' AS Date), N'Evening', 2, 5, 4, 0)
SET IDENTITY_INSERT [dbo].[ProductionPlans] OFF
GO
SET IDENTITY_INSERT [dbo].[PurchaseOrderItems] ON 

INSERT [dbo].[PurchaseOrderItems] ([PurchaseOrderItemId], [PurchaseOrderId], [MaterialType], [Unit], [Quantity], [Price], [MaterialName]) VALUES (14, 9, N'Wood', N'Kg', 200, CAST(20.00 AS Decimal(18, 2)), N'Unknown')
INSERT [dbo].[PurchaseOrderItems] ([PurchaseOrderItemId], [PurchaseOrderId], [MaterialType], [Unit], [Quantity], [Price], [MaterialName]) VALUES (25, 8, N'Steel', N'Kg', 200, CAST(20.00 AS Decimal(18, 2)), N'Unknown')
INSERT [dbo].[PurchaseOrderItems] ([PurchaseOrderItemId], [PurchaseOrderId], [MaterialType], [Unit], [Quantity], [Price], [MaterialName]) VALUES (28, 13, N'Steel', N'Kg', 120, CAST(500.00 AS Decimal(18, 2)), N'Unknown')
INSERT [dbo].[PurchaseOrderItems] ([PurchaseOrderItemId], [PurchaseOrderId], [MaterialType], [Unit], [Quantity], [Price], [MaterialName]) VALUES (29, 13, N'Fabric', N'Meter', 50, CAST(700.00 AS Decimal(18, 2)), N'Unknown')
INSERT [dbo].[PurchaseOrderItems] ([PurchaseOrderItemId], [PurchaseOrderId], [MaterialType], [Unit], [Quantity], [Price], [MaterialName]) VALUES (31, 15, N'Steel', N'Kg', 200, CAST(500.00 AS Decimal(18, 2)), N'Steel(Sheets)')
INSERT [dbo].[PurchaseOrderItems] ([PurchaseOrderItemId], [PurchaseOrderId], [MaterialType], [Unit], [Quantity], [Price], [MaterialName]) VALUES (32, 15, N'Plastic', N'Kg', 500, CAST(100.00 AS Decimal(18, 2)), N'Naylon')
INSERT [dbo].[PurchaseOrderItems] ([PurchaseOrderItemId], [PurchaseOrderId], [MaterialType], [Unit], [Quantity], [Price], [MaterialName]) VALUES (33, 16, N'Steel', N'Kg', 250, CAST(560.00 AS Decimal(18, 2)), N'Steel(Rods)')
INSERT [dbo].[PurchaseOrderItems] ([PurchaseOrderItemId], [PurchaseOrderId], [MaterialType], [Unit], [Quantity], [Price], [MaterialName]) VALUES (34, 16, N'Fabric', N'Meter', 150, CAST(200.00 AS Decimal(18, 2)), N'Cotton')
INSERT [dbo].[PurchaseOrderItems] ([PurchaseOrderItemId], [PurchaseOrderId], [MaterialType], [Unit], [Quantity], [Price], [MaterialName]) VALUES (38, 17, N'Wood', N'Piece', 200, CAST(100.00 AS Decimal(18, 2)), N'Wood(sheets)')
INSERT [dbo].[PurchaseOrderItems] ([PurchaseOrderItemId], [PurchaseOrderId], [MaterialType], [Unit], [Quantity], [Price], [MaterialName]) VALUES (40, 18, N'Steel', N'Piece', 500, CAST(20.00 AS Decimal(18, 2)), N'Steel(Sheets)')
INSERT [dbo].[PurchaseOrderItems] ([PurchaseOrderItemId], [PurchaseOrderId], [MaterialType], [Unit], [Quantity], [Price], [MaterialName]) VALUES (45, 19, N'Fabric', N'Meter', 900, CAST(50.00 AS Decimal(18, 2)), N'Georgette')
INSERT [dbo].[PurchaseOrderItems] ([PurchaseOrderItemId], [PurchaseOrderId], [MaterialType], [Unit], [Quantity], [Price], [MaterialName]) VALUES (46, 20, N'Wood', N'Piece', 500, CAST(50.00 AS Decimal(18, 2)), N'Wood(sheets)')
INSERT [dbo].[PurchaseOrderItems] ([PurchaseOrderItemId], [PurchaseOrderId], [MaterialType], [Unit], [Quantity], [Price], [MaterialName]) VALUES (47, 20, N'Steel', N'Piece', 700, CAST(80.00 AS Decimal(18, 2)), N'Steel(Sheets)')
INSERT [dbo].[PurchaseOrderItems] ([PurchaseOrderItemId], [PurchaseOrderId], [MaterialType], [Unit], [Quantity], [Price], [MaterialName]) VALUES (49, 21, N'Wood', N'Piece', 200, CAST(200.00 AS Decimal(18, 2)), N'sheets')
INSERT [dbo].[PurchaseOrderItems] ([PurchaseOrderItemId], [PurchaseOrderId], [MaterialType], [Unit], [Quantity], [Price], [MaterialName]) VALUES (50, 22, N'Steel', N'Peace', 120, CAST(200.00 AS Decimal(18, 2)), N'Steel(Rods)')
INSERT [dbo].[PurchaseOrderItems] ([PurchaseOrderItemId], [PurchaseOrderId], [MaterialType], [Unit], [Quantity], [Price], [MaterialName]) VALUES (53, 23, N'Wood', N'Piece', 120, CAST(200.00 AS Decimal(18, 2)), N'Flie')
INSERT [dbo].[PurchaseOrderItems] ([PurchaseOrderItemId], [PurchaseOrderId], [MaterialType], [Unit], [Quantity], [Price], [MaterialName]) VALUES (54, 24, N'Fabric', N'Meter', 250, CAST(2000.00 AS Decimal(18, 2)), N'Cotton')
INSERT [dbo].[PurchaseOrderItems] ([PurchaseOrderItemId], [PurchaseOrderId], [MaterialType], [Unit], [Quantity], [Price], [MaterialName]) VALUES (57, 26, N'Steel', N'Piece', 400, CAST(20.00 AS Decimal(18, 2)), N'Steel(Sheets)')
INSERT [dbo].[PurchaseOrderItems] ([PurchaseOrderItemId], [PurchaseOrderId], [MaterialType], [Unit], [Quantity], [Price], [MaterialName]) VALUES (58, 26, N'Wood', N'Piece', 600, CAST(50.00 AS Decimal(18, 2)), N'sheets')
INSERT [dbo].[PurchaseOrderItems] ([PurchaseOrderItemId], [PurchaseOrderId], [MaterialType], [Unit], [Quantity], [Price], [MaterialName]) VALUES (59, 26, N'Plastic', N'Piece', 200, CAST(80.00 AS Decimal(18, 2)), N'Pipe')
INSERT [dbo].[PurchaseOrderItems] ([PurchaseOrderItemId], [PurchaseOrderId], [MaterialType], [Unit], [Quantity], [Price], [MaterialName]) VALUES (60, 27, N'Steel', N'Piece', 500, CAST(20.00 AS Decimal(18, 2)), N'Steel(Rods)')
SET IDENTITY_INSERT [dbo].[PurchaseOrderItems] OFF
GO
SET IDENTITY_INSERT [dbo].[PurchaseOrders] ON 

INSERT [dbo].[PurchaseOrders] ([PurchaseOrderId], [POCode], [VendorId], [OrderDate], [ExpectedDeliveryDate], [Status], [CompanyName], [PurchaseOrderTrackId]) VALUES (8, N'PO-20250408120828', 2, CAST(N'2025-01-21T00:00:00.000' AS DateTime), CAST(N'2025-01-30T00:00:00.000' AS DateTime), N'Rejected', NULL, NULL)
INSERT [dbo].[PurchaseOrders] ([PurchaseOrderId], [POCode], [VendorId], [OrderDate], [ExpectedDeliveryDate], [Status], [CompanyName], [PurchaseOrderTrackId]) VALUES (9, N'PO-20250408231151', 13, CAST(N'2025-02-10T00:00:00.000' AS DateTime), CAST(N'2025-02-15T00:00:00.000' AS DateTime), N'Active', NULL, NULL)
INSERT [dbo].[PurchaseOrders] ([PurchaseOrderId], [POCode], [VendorId], [OrderDate], [ExpectedDeliveryDate], [Status], [CompanyName], [PurchaseOrderTrackId]) VALUES (13, N'PO-20250410160025', 16, CAST(N'2025-04-10T00:00:00.000' AS DateTime), CAST(N'2025-05-08T00:00:00.000' AS DateTime), N'Pending', NULL, NULL)
INSERT [dbo].[PurchaseOrders] ([PurchaseOrderId], [POCode], [VendorId], [OrderDate], [ExpectedDeliveryDate], [Status], [CompanyName], [PurchaseOrderTrackId]) VALUES (15, N'PO-20250411124225', 2, CAST(N'2025-04-01T00:00:00.000' AS DateTime), CAST(N'2025-05-08T00:00:00.000' AS DateTime), N'Pending', NULL, NULL)
INSERT [dbo].[PurchaseOrders] ([PurchaseOrderId], [POCode], [VendorId], [OrderDate], [ExpectedDeliveryDate], [Status], [CompanyName], [PurchaseOrderTrackId]) VALUES (16, N'PO-20250411124642', 7, CAST(N'2025-04-08T00:00:00.000' AS DateTime), CAST(N'2025-05-10T00:00:00.000' AS DateTime), N'Approved', NULL, NULL)
INSERT [dbo].[PurchaseOrders] ([PurchaseOrderId], [POCode], [VendorId], [OrderDate], [ExpectedDeliveryDate], [Status], [CompanyName], [PurchaseOrderTrackId]) VALUES (17, N'PO-20250411131258', 10, CAST(N'2025-04-02T00:00:00.000' AS DateTime), CAST(N'2025-05-10T00:00:00.000' AS DateTime), N'Pending', NULL, NULL)
INSERT [dbo].[PurchaseOrders] ([PurchaseOrderId], [POCode], [VendorId], [OrderDate], [ExpectedDeliveryDate], [Status], [CompanyName], [PurchaseOrderTrackId]) VALUES (18, N'PO-20250416145244', 9, CAST(N'2025-03-15T00:00:00.000' AS DateTime), CAST(N'2025-03-20T00:00:00.000' AS DateTime), N'Pending', NULL, NULL)
INSERT [dbo].[PurchaseOrders] ([PurchaseOrderId], [POCode], [VendorId], [OrderDate], [ExpectedDeliveryDate], [Status], [CompanyName], [PurchaseOrderTrackId]) VALUES (19, N'PO-20250422155033', 13, CAST(N'2025-04-23T00:00:00.000' AS DateTime), CAST(N'2025-05-10T00:00:00.000' AS DateTime), N'Approved', NULL, NULL)
INSERT [dbo].[PurchaseOrders] ([PurchaseOrderId], [POCode], [VendorId], [OrderDate], [ExpectedDeliveryDate], [Status], [CompanyName], [PurchaseOrderTrackId]) VALUES (20, N'PO-20250422155800', 15, CAST(N'2025-05-05T00:00:00.000' AS DateTime), CAST(N'2025-06-15T00:00:00.000' AS DateTime), N'Approved', NULL, NULL)
INSERT [dbo].[PurchaseOrders] ([PurchaseOrderId], [POCode], [VendorId], [OrderDate], [ExpectedDeliveryDate], [Status], [CompanyName], [PurchaseOrderTrackId]) VALUES (21, N'PO-20250424113227', 12, CAST(N'2025-04-24T00:00:00.000' AS DateTime), CAST(N'2025-05-10T00:00:00.000' AS DateTime), N'Pending', NULL, NULL)
INSERT [dbo].[PurchaseOrders] ([PurchaseOrderId], [POCode], [VendorId], [OrderDate], [ExpectedDeliveryDate], [Status], [CompanyName], [PurchaseOrderTrackId]) VALUES (22, N'PO-20250429120950', 2, CAST(N'2025-04-29T00:00:00.000' AS DateTime), CAST(N'2025-05-10T00:00:00.000' AS DateTime), N'Pending', NULL, NULL)
INSERT [dbo].[PurchaseOrders] ([PurchaseOrderId], [POCode], [VendorId], [OrderDate], [ExpectedDeliveryDate], [Status], [CompanyName], [PurchaseOrderTrackId]) VALUES (23, N'PO-20250502122250', 2, CAST(N'2025-05-02T00:00:00.000' AS DateTime), CAST(N'2025-05-23T00:00:00.000' AS DateTime), N'Pending', NULL, NULL)
INSERT [dbo].[PurchaseOrders] ([PurchaseOrderId], [POCode], [VendorId], [OrderDate], [ExpectedDeliveryDate], [Status], [CompanyName], [PurchaseOrderTrackId]) VALUES (24, N'PO-20250503115654', 13, CAST(N'2025-02-15T00:00:00.000' AS DateTime), CAST(N'2025-05-23T00:00:00.000' AS DateTime), N'Approved', NULL, NULL)
INSERT [dbo].[PurchaseOrders] ([PurchaseOrderId], [POCode], [VendorId], [OrderDate], [ExpectedDeliveryDate], [Status], [CompanyName], [PurchaseOrderTrackId]) VALUES (26, N'PO-20250519142349', 7, CAST(N'2025-05-17T00:00:00.000' AS DateTime), CAST(N'2025-05-30T00:00:00.000' AS DateTime), N'Pending', NULL, NULL)
INSERT [dbo].[PurchaseOrders] ([PurchaseOrderId], [POCode], [VendorId], [OrderDate], [ExpectedDeliveryDate], [Status], [CompanyName], [PurchaseOrderTrackId]) VALUES (27, N'PO-20250520124633', 16, CAST(N'2025-05-04T00:00:00.000' AS DateTime), CAST(N'2025-05-22T00:00:00.000' AS DateTime), N'Pending', NULL, NULL)
SET IDENTITY_INSERT [dbo].[PurchaseOrders] OFF
GO
SET IDENTITY_INSERT [dbo].[PurchaseOrderTrackItems] ON 

INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (1, 0, N'Wood', N'Flie', N'Piece', 120, 20, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (2, 0, N'Wood', N'Flie', N'Piece', 100, 50, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (3, 0, N'Wood', N'Flie', N'Piece', 120, 20, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (4, 0, N'Wood', N'Flie', N'Piece', 100, 50, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (5, 0, N'Wood', N'Wood(sheets)', N'Piece', 500, 50, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (6, 0, N'Steel', N'Steel(Sheets)', N'Piece', 700, 150, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (7, 0, N'Wood', N'Wood(sheets)', N'Piece', 450, 150, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (8, 0, N'Steel', N'Steel(Sheets)', N'Piece', 550, 120, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (9, 0, N'Wood', N'Wood(sheets)', N'Piece', 300, 100, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (10, 0, N'Steel', N'Steel(Sheets)', N'Piece', 430, 30, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (11, 0, N'Wood', N'sheets', N'Piece', 200, 20, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (12, 0, N'Wood', N'Flie', N'Piece', 120, 20, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (13, 0, N'Wood', N'Flie', N'Piece', 100, 50, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (14, 0, N'Fabric', N'Cotton', N'Meter', 250, 50, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (15, 0, N'Wood', N'Flie', N'Piece', 120, 20, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (16, 0, N'Wood', N'Flie', N'Piece', 100, 50, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (17, 0, N'Fabric', N'Cotton', N'Meter', 250, 50, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (18, 0, N'Fabric', N'Cotton', N'Meter', 250, 50, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (19, 27, N'Fabric', N'Cotton', N'Meter', 250, 50, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (20, 28, N'Fabric', N'Cotton', N'Meter', 250, 50, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (21, 29, N'Fabric', N'Cotton', N'Meter', 250, 50, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (22, 30, N'Wood', N'Flie', N'Piece', 120, 20, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (23, 30, N'Wood', N'Flie', N'Piece', 100, 50, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (24, 31, N'Wood', N'Flie', N'Piece', 120, 20, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (25, 31, N'Wood', N'Flie', N'Piece', 100, 50, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (26, 32, N'Wood', N'Flie', N'Piece', 120, 20, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (27, 32, N'Wood', N'Flie', N'Piece', 100, 50, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (28, 32, N'Wood', N'Flie', N'Piece', 120, 20, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (29, 32, N'Wood', N'Flie', N'Piece', 100, 50, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (30, 33, N'Fabric', N'Cotton', N'Meter', 250, 50, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (31, 33, N'Fabric', N'Cotton', N'Meter', 250, 50, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (32, 34, N'Fabric', N'Cotton', N'Meter', 250, 50, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (33, 34, N'Fabric', N'Cotton', N'Meter', 250, 50, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (34, 35, N'Wood', N'Wood(sheets)', N'Piece', 500, 50, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (35, 35, N'Steel', N'Steel(Sheets)', N'Piece', 700, 150, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (36, 35, N'Wood', N'Wood(sheets)', N'Piece', 450, 150, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (37, 35, N'Steel', N'Steel(Sheets)', N'Piece', 550, 120, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (38, 35, N'Wood', N'Wood(sheets)', N'Piece', 300, 100, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (39, 35, N'Steel', N'Steel(Sheets)', N'Piece', 430, 30, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (40, 35, N'Wood', N'Wood(sheets)', N'Piece', 500, 50, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (41, 35, N'Steel', N'Steel(Sheets)', N'Piece', 700, 150, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (42, 35, N'Wood', N'Wood(sheets)', N'Piece', 450, 150, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (43, 35, N'Steel', N'Steel(Sheets)', N'Piece', 550, 120, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (44, 35, N'Wood', N'Wood(sheets)', N'Piece', 300, 100, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (45, 35, N'Steel', N'Steel(Sheets)', N'Piece', 430, 30, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (46, 36, N'Wood', N'Wood(sheets)', N'Piece', 500, 50, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (47, 36, N'Steel', N'Steel(Sheets)', N'Piece', 700, 150, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (48, 36, N'Wood', N'Wood(sheets)', N'Piece', 450, 150, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (49, 36, N'Steel', N'Steel(Sheets)', N'Piece', 550, 120, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (50, 36, N'Wood', N'Wood(sheets)', N'Piece', 300, 100, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (51, 36, N'Steel', N'Steel(Sheets)', N'Piece', 430, 30, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (52, 36, N'Wood', N'Wood(sheets)', N'Piece', 500, 50, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (53, 36, N'Steel', N'Steel(Sheets)', N'Piece', 700, 150, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (54, 36, N'Wood', N'Wood(sheets)', N'Piece', 450, 150, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (55, 36, N'Steel', N'Steel(Sheets)', N'Piece', 550, 120, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (56, 36, N'Wood', N'Wood(sheets)', N'Piece', 300, 100, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (57, 36, N'Steel', N'Steel(Sheets)', N'Piece', 430, 30, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (58, 37, N'Fabric', N'Cotton', N'Meter', 250, 50, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (59, 37, N'Fabric', N'Cotton', N'Meter', 250, 50, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (60, 38, N'Fabric', N'Georgette', N'Meter', 900, 200, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (61, 38, N'Fabric', N'Georgette', N'Meter', 700, 300, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (62, 38, N'Fabric', N'Georgette', N'Meter', 900, 200, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (63, 38, N'Fabric', N'Georgette', N'Meter', 700, 300, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (64, 39, N'Wood', N'Flie', N'Piece', 120, 20, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (65, 39, N'Wood', N'Flie', N'Piece', 100, 50, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (66, 39, N'Wood', N'Flie', N'Piece', 120, 20, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (67, 39, N'Wood', N'Flie', N'Piece', 100, 50, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (68, 40, N'Fabric', N'Georgette', N'Meter', 900, 200, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (69, 40, N'Fabric', N'Georgette', N'Meter', 700, 300, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (70, 40, N'Fabric', N'Georgette', N'Meter', 900, 200, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (71, 40, N'Fabric', N'Georgette', N'Meter', 700, 300, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (72, 41, N'Fabric', N'Georgette', N'Meter', 900, 200, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (73, 41, N'Fabric', N'Georgette', N'Meter', 700, 300, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (74, 41, N'Fabric', N'Georgette', N'Meter', 900, 200, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (75, 41, N'Fabric', N'Georgette', N'Meter', 700, 300, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (76, 42, N'Fabric', N'Georgette', N'Meter', 900, 200, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (77, 42, N'Fabric', N'Georgette', N'Meter', 700, 300, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (78, 42, N'Fabric', N'Georgette', N'Meter', 900, 200, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (79, 42, N'Fabric', N'Georgette', N'Meter', 700, 300, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (80, 43, N'Fabric', N'Georgette', N'Meter', 900, 200, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (81, 43, N'Fabric', N'Georgette', N'Meter', 700, 300, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (82, 43, N'Fabric', N'Georgette', N'Meter', 900, 200, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (83, 43, N'Fabric', N'Georgette', N'Meter', 700, 300, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (84, 44, N'Wood', N'Flie', N'Piece', 120, 20, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (85, 44, N'Wood', N'Flie', N'Piece', 100, 50, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (86, 44, N'Wood', N'Flie', N'Piece', 120, 20, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (87, 44, N'Wood', N'Flie', N'Piece', 100, 50, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (88, 45, N'Steel', N'Steel(Sheets)', N'Piece', 500, 150, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (89, 45, N'Steel', N'Steel(Sheets)', N'Piece', 350, 120, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (90, 45, N'Steel', N'Steel(Sheets)', N'Piece', 130, 100, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (91, 45, N'Steel', N'Steel(Sheets)', N'Piece', 130, 30, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (92, 45, N'Steel', N'Steel(Sheets)', N'Piece', 500, 150, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (93, 45, N'Steel', N'Steel(Sheets)', N'Piece', 350, 120, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (94, 45, N'Steel', N'Steel(Sheets)', N'Piece', 130, 100, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (95, 45, N'Steel', N'Steel(Sheets)', N'Piece', 130, 30, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (96, 46, N'Fabric', N'Georgette', N'Meter', 900, 200, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (97, 46, N'Fabric', N'Georgette', N'Meter', 700, 300, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (98, 46, N'Fabric', N'Georgette', N'Meter', 900, 200, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (99, 46, N'Fabric', N'Georgette', N'Meter', 700, 300, NULL, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (100, 47, N'Fabric', N'Cotton', N'Meter', 250, 50, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (101, 47, N'Fabric', N'Cotton', N'Meter', 250, 50, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (102, 48, N'Fabric', N'Cotton', N'Meter', 250, 50, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (103, 48, N'Fabric', N'Cotton', N'Meter', 250, 50, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (104, 49, N'Fabric', N'Cotton', N'Meter', 250, 50, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (105, 49, N'Fabric', N'Cotton', N'Meter', 250, 50, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (106, 50, N'Fabric', N'Cotton', N'Meter', 250, 50, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (107, 50, N'Fabric', N'Cotton', N'Meter', 250, 50, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (108, 54, N'Fabric', N'Cotton', N'Meter', 250, 50, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (109, 54, N'Fabric', N'Cotton', N'Meter', 250, 50, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (110, 55, N'Fabric', N'Cotton', N'Meter', 250, 50, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (111, 55, N'Fabric', N'Cotton', N'Meter', 250, 50, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (112, 56, N'Wood', N'Flie', N'Piece', 120, 20, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (113, 56, N'Wood', N'Flie', N'Piece', 100, 50, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (114, 56, N'Wood', N'Flie', N'Piece', 120, 20, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (115, 56, N'Wood', N'Flie', N'Piece', 100, 50, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (116, 57, N'Wood', N'Flie', N'Piece', 120, 20, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (117, 57, N'Wood', N'Flie', N'Piece', 100, 50, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (118, 57, N'Wood', N'Flie', N'Piece', 120, 20, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (119, 57, N'Wood', N'Flie', N'Piece', 100, 50, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (120, 58, N'Wood', N'Flie', N'Piece', 120, 20, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (121, 58, N'Wood', N'Flie', N'Piece', 100, 50, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (122, 58, N'Wood', N'Flie', N'Piece', 120, 20, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (123, 58, N'Wood', N'Flie', N'Piece', 100, 50, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (124, 60, N'Wood', N'Wood(sheets)', N'Piece', 500, 50, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (125, 60, N'Steel', N'Steel(Sheets)', N'Piece', 700, 150, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (126, 60, N'Wood', N'Wood(sheets)', N'Piece', 450, 150, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (127, 60, N'Steel', N'Steel(Sheets)', N'Piece', 550, 120, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (128, 60, N'Wood', N'Wood(sheets)', N'Piece', 300, 100, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (129, 60, N'Steel', N'Steel(Sheets)', N'Piece', 430, 30, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (130, 60, N'Wood', N'Wood(sheets)', N'Piece', 500, 50, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (131, 60, N'Steel', N'Steel(Sheets)', N'Piece', 700, 150, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (132, 60, N'Wood', N'Wood(sheets)', N'Piece', 450, 150, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (133, 60, N'Steel', N'Steel(Sheets)', N'Piece', 550, 120, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (134, 60, N'Wood', N'Wood(sheets)', N'Piece', 300, 100, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (135, 60, N'Steel', N'Steel(Sheets)', N'Piece', 430, 30, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (136, 61, N'Wood', N'Flie', N'Piece', 120, 20, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (137, 61, N'Wood', N'Flie', N'Piece', 100, 50, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (139, 62, N'Wood', N'Flie', N'Piece', 120, 20, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (140, 62, N'Wood', N'Flie', N'Piece', 100, 50, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (141, 62, N'Wood', N'Flie', N'Piece', 120, 20, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (142, 62, N'Wood', N'Flie', N'Piece', 100, 50, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (143, 63, N'Fabric', N'Cotton', N'Meter', 250, 50, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (144, 63, N'Fabric', N'Cotton', N'Meter', 250, 50, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (145, 64, N'Fabric', N'Cotton', N'Meter', 250, 50, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (146, 64, N'Fabric', N'Cotton', N'Meter', 250, 50, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (147, 65, N'Wood', N'Flie', N'Piece', 120, 20, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (148, 65, N'Wood', N'Flie', N'Piece', 100, 50, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (149, 65, N'Wood', N'Flie', N'Piece', 120, 20, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (150, 65, N'Wood', N'Flie', N'Piece', 100, 50, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (151, 66, N'Wood', N'Flie', N'Piece', 120, 20, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (152, 66, N'Wood', N'Flie', N'Piece', 100, 50, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (153, 66, N'Wood', N'Flie', N'Piece', 120, 20, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (154, 66, N'Wood', N'Flie', N'Piece', 100, 50, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (155, 67, N'Fabric', N'Cotton', N'Meter', 250, 50, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (156, 67, N'Fabric', N'Cotton', N'Meter', 250, 50, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (157, 68, N'Wood', N'Flie', N'Piece', 120, 20, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (158, 68, N'Wood', N'Flie', N'Piece', 100, 50, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (159, 68, N'Wood', N'Flie', N'Piece', 120, 20, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (160, 68, N'Wood', N'Flie', N'Piece', 100, 50, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (161, 69, N'Wood', N'Flie', N'Piece', 120, 20, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (162, 69, N'Wood', N'Flie', N'Piece', 100, 50, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (163, 69, N'Wood', N'Flie', N'Piece', 120, 20, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (164, 69, N'Wood', N'Flie', N'Piece', 100, 50, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (165, 70, N'Fabric', N'Cotton', N'Meter', 250, 50, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (166, 70, N'Fabric', N'Cotton', N'Meter', 250, 50, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (167, 71, N'Fabric', N'Cotton', N'Meter', 250, 50, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (168, 71, N'Fabric', N'Cotton', N'Meter', 250, 50, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (169, 72, N'Fabric', N'Cotton', N'Meter', 250, 50, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (170, 72, N'Fabric', N'Cotton', N'Meter', 250, 50, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (171, 73, N'Fabric', N'Cotton', N'Meter', 250, 50, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (172, 74, N'Wood', N'Flie', N'Piece', 120, 20, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (173, 74, N'Wood', N'Flie', N'Piece', 100, 50, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (174, 75, N'Fabric', N'Georgette', N'Meter', 900, 200, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (175, 75, N'Fabric', N'Georgette', N'Meter', 700, 300, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (176, 76, N'Steel', N'Steel(Sheets)', N'Piece', 500, 150, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (177, 76, N'Steel', N'Steel(Sheets)', N'Piece', 350, 120, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (178, 76, N'Steel', N'Steel(Sheets)', N'Piece', 130, 100, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (179, 76, N'Steel', N'Steel(Sheets)', N'Piece', 130, 30, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (180, 77, N'Fabric', N'Cotton', N'Meter', 250, 50, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (181, 77, N'Fabric', N'Cotton', N'Meter', 200, 100, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (182, 78, N'Fabric', N'Cotton', N'Meter', 250, 50, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (183, 78, N'Fabric', N'Cotton', N'Meter', 200, 100, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (184, 78, N'Fabric', N'Cotton', N'Meter', 100, 100, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (185, 79, N'Fabric', N'Cotton', N'Meter', 250, 50, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (186, 79, N'Fabric', N'Cotton', N'Meter', 200, 100, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (187, 80, N'Wood', N'Flie', N'Piece', 120, 20, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (188, 80, N'Wood', N'Flie', N'Piece', 100, 50, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (189, 81, N'Wood', N'sheets', N'Piece', 200, 20, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (190, 82, N'Fabric', N'Cotton', N'Meter', 250, 50, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (191, 82, N'Fabric', N'Cotton', N'Meter', 200, 100, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (192, 82, N'Fabric', N'Cotton', N'Meter', 100, 50, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (193, 83, N'Fabric', N'Cotton', N'Meter', 250, 50, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (194, 83, N'Fabric', N'Cotton', N'Meter', 200, 100, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (195, 83, N'Fabric', N'Cotton', N'Meter', 100, 50, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (196, 84, N'Fabric', N'Cotton', N'Meter', 250, 50, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (197, 84, N'Fabric', N'Cotton', N'Meter', 200, 100, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (198, 84, N'Fabric', N'Cotton', N'Meter', 100, 50, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (199, 85, N'Fabric', N'Cotton', N'Meter', 250, 50, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (200, 85, N'Fabric', N'Cotton', N'Meter', 200, 100, 0, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (201, 85, N'Fabric', N'Cotton', N'Meter', 100, 50, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (202, 85, N'Fabric', N'Cotton', N'Meter', 50, 25, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (203, 86, N'Fabric', N'Cotton', N'Meter', 250, 50, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (204, 86, N'Fabric', N'Cotton', N'Meter', 200, 100, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (205, 86, N'Fabric', N'Cotton', N'Meter', 100, 50, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (206, 86, N'Fabric', N'Cotton', N'Meter', 50, 25, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (207, 87, N'Fabric', N'Cotton', N'Meter', 250, 50, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (208, 87, N'Fabric', N'Cotton', N'Meter', 200, 100, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (209, 87, N'Fabric', N'Cotton', N'Meter', 100, 50, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (210, 87, N'Fabric', N'Cotton', N'Meter', 50, 25, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (211, 88, N'Fabric', N'Cotton', N'Meter', 250, 50, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (212, 88, N'Fabric', N'Cotton', N'Meter', 200, 100, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (213, 88, N'Fabric', N'Cotton', N'Meter', 100, 50, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (214, 88, N'Fabric', N'Cotton', N'Meter', 50, 25, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (215, 89, N'Fabric', N'Cotton', N'Meter', 250, 50, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (216, 89, N'Fabric', N'Cotton', N'Meter', 200, 100, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (217, 89, N'Fabric', N'Cotton', N'Meter', 100, 50, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (218, 89, N'Fabric', N'Cotton', N'Meter', 50, 25, 0, NULL, NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (219, 90, N'Wood', N'sheets', N'Piece', 200, 20, 0, CAST(N'2025-05-07T00:00:00.000' AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (220, 91, N'Wood', N'sheets', N'Piece', 200, 20, 0, CAST(N'2025-05-07T00:00:00.000' AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (221, 92, N'Fabric', N'Cotton', N'Meter', 250, 50, 0, CAST(N'2025-05-07T00:00:00.000' AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (222, 92, N'Fabric', N'Cotton', N'Meter', 200, 100, 0, CAST(N'2025-05-07T00:00:00.000' AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (223, 92, N'Fabric', N'Cotton', N'Meter', 100, 50, 0, CAST(N'2025-05-07T00:00:00.000' AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (224, 92, N'Fabric', N'Cotton', N'Meter', 50, 25, 0, CAST(N'2025-05-07T00:00:00.000' AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (225, 93, N'Wood', N'sheets', N'Piece', 200, 20, 0, CAST(N'2025-05-07T00:00:00.000' AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (226, 94, N'Wood', N'Flie', N'Piece', 120, 20, 0, CAST(N'2025-05-07T00:00:00.000' AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (227, 94, N'Wood', N'Flie', N'Piece', 100, 50, 0, CAST(N'2025-05-07T00:00:00.000' AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (228, 95, N'Wood', N'sheets', N'Piece', 200, 20, 0, CAST(N'2025-05-07T00:00:00.000' AS DateTime), NULL, NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (229, 96, N'Wood', N'sheets', N'Piece', 200, 20, 0, CAST(N'2025-05-07T00:00:00.000' AS DateTime), N'GRN123', NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (230, 97, N'Wood', N'Flie', N'Piece', 120, 20, 0, CAST(N'2025-05-17T00:00:00.000' AS DateTime), N'GRN123', NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (231, 97, N'Wood', N'Flie', N'Piece', 100, 50, 0, CAST(N'2025-05-17T00:00:00.000' AS DateTime), N'GRN123', NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (232, 98, N'Fabric', N'Cotton', N'Meter', 250, 50, 0, CAST(N'2025-05-03T00:00:00.000' AS DateTime), N'GRN0058', NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (233, 99, N'Wood', N'Flie', N'Piece', 120, 20, 0, CAST(N'2025-05-02T00:00:00.000' AS DateTime), N'GRN0056', NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (234, 100, N'Wood', N'Wood(sheets)', N'Piece', 500, 50, 0, CAST(N'2025-04-22T00:00:00.000' AS DateTime), N'GRN0050', NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (235, 100, N'Steel', N'Steel(Sheets)', N'Piece', 700, 150, 0, CAST(N'2025-04-22T00:00:00.000' AS DateTime), N'GRN0050', NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (236, 101, N'Steel', N'Steel(Sheets)', N'Piece', 400, 100, 0, CAST(N'2025-05-19T00:00:00.000' AS DateTime), N'GRN0065', NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (237, 101, N'Wood', N'sheets', N'Piece', 600, 200, 0, CAST(N'2025-05-19T00:00:00.000' AS DateTime), N'GRN0065', NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (238, 101, N'Plastic', N'Pipe', N'Piece', 200, 50, 0, CAST(N'2025-05-19T00:00:00.000' AS DateTime), N'GRN0065', NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (239, 102, N'Steel', N'Steel(Sheets)', N'Piece', 400, 100, 0, CAST(N'2025-05-19T00:00:00.000' AS DateTime), N'GRN0065', NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (240, 102, N'Wood', N'sheets', N'Piece', 600, 200, 0, CAST(N'2025-05-19T00:00:00.000' AS DateTime), N'GRN0065', NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (241, 102, N'Plastic', N'Pipe', N'Piece', 200, 50, 0, CAST(N'2025-05-19T00:00:00.000' AS DateTime), N'GRN0065', NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (242, 103, N'Steel', N'Steel(Sheets)', N'Piece', 400, 100, 0, CAST(N'2025-05-19T00:00:00.000' AS DateTime), N'GRN0065', NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (243, 103, N'Wood', N'sheets', N'Piece', 600, 200, 0, CAST(N'2025-05-19T00:00:00.000' AS DateTime), N'GRN0065', NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (244, 103, N'Plastic', N'Pipe', N'Piece', 200, 50, 0, CAST(N'2025-05-19T00:00:00.000' AS DateTime), N'GRN0065', NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (245, 104, N'Fabric', N'Cotton', N'Meter', 250, 50, 0, CAST(N'2025-05-03T00:00:00.000' AS DateTime), N'GRN0058', NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (246, 105, N'Wood', N'Flie', N'Piece', 120, 20, 0, CAST(N'2025-05-02T00:00:00.000' AS DateTime), N'GRN0056', NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (247, 106, N'Wood', N'Flie', N'Piece', 120, 20, 0, CAST(N'2025-05-02T00:00:00.000' AS DateTime), N'GRN0056', NULL, NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (248, 107, N'Fabric', N'Georgette', N'Meter', 900, 200, 0, CAST(N'2025-04-22T00:00:00.000' AS DateTime), N'GRN0046', CAST(900.00 AS Decimal(18, 2)), NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (249, 108, N'Wood', N'Wood(sheets)', N'Piece', 500, 50, 0, CAST(N'2025-04-22T00:00:00.000' AS DateTime), N'GRN0050', CAST(500.00 AS Decimal(18, 2)), NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (250, 108, N'Steel', N'Steel(Sheets)', N'Piece', 700, 150, 0, CAST(N'2025-04-22T00:00:00.000' AS DateTime), N'GRN0050', CAST(700.00 AS Decimal(18, 2)), NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (251, 109, N'Wood', N'Flie', N'Piece', 120, 20, 0, CAST(N'2025-05-02T00:00:00.000' AS DateTime), N'GRN0056', CAST(120.00 AS Decimal(18, 2)), NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (252, 110, N'Steel', N'Steel(Rods)', N'Piece', 500, 100, 0, CAST(N'2025-05-20T00:00:00.000' AS DateTime), N'GRN0072', CAST(500.00 AS Decimal(18, 2)), NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (253, 111, N'Steel', N'Steel(Rods)', N'Piece', 500, 100, 0, CAST(N'2025-05-20T00:00:00.000' AS DateTime), N'GRN0072', CAST(500.00 AS Decimal(18, 2)), NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (254, 112, N'Steel', N'Steel(Rods)', N'Piece', 500, 100, 0, CAST(N'2025-05-20T00:00:00.000' AS DateTime), N'GRN0072', CAST(500.00 AS Decimal(18, 2)), NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (255, 112, N'Steel', N'Steel(Rods)', N'Piece', 400, 200, 0, CAST(N'2025-05-20T00:00:00.000' AS DateTime), N'GRN0073', CAST(500.00 AS Decimal(18, 2)), NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (256, 112, N'Steel', N'Steel(Rods)', N'Piece', 200, 10, 0, CAST(N'2025-05-21T00:00:00.000' AS DateTime), N'GRN0074', CAST(500.00 AS Decimal(18, 2)), NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (257, 113, N'Fabric', N'Cotton', N'Meter', 250, 50, 0, CAST(N'2025-05-03T00:00:00.000' AS DateTime), N'GRN0058', CAST(250.00 AS Decimal(18, 2)), NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (258, 113, N'Fabric', N'Cotton', N'Meter', 200, 100, 0, CAST(N'2025-05-05T00:00:00.000' AS DateTime), N'GRN0061', CAST(250.00 AS Decimal(18, 2)), NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (259, 113, N'Fabric', N'Cotton', N'Meter', 100, 50, 0, CAST(N'2025-05-06T00:00:00.000' AS DateTime), N'GRN0062', CAST(250.00 AS Decimal(18, 2)), NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (260, 113, N'Fabric', N'Cotton', N'Meter', 50, 25, 0, CAST(N'2025-05-07T00:00:00.000' AS DateTime), N'GRN0064', CAST(250.00 AS Decimal(18, 2)), NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (261, 114, N'Steel', N'Steel(Rods)', N'Piece', 500, 100, 0, CAST(N'2025-05-20T00:00:00.000' AS DateTime), N'GRN0072', CAST(500.00 AS Decimal(18, 2)), NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (262, 114, N'Steel', N'Steel(Rods)', N'Piece', 400, 200, 0, CAST(N'2025-05-20T00:00:00.000' AS DateTime), N'GRN0073', CAST(500.00 AS Decimal(18, 2)), NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (263, 114, N'Steel', N'Steel(Rods)', N'Piece', 200, 10, 0, CAST(N'2025-05-21T00:00:00.000' AS DateTime), N'GRN0074', CAST(500.00 AS Decimal(18, 2)), NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (264, 115, N'Steel', N'Steel(Rods)', N'Piece', 500, 100, 0, CAST(N'2025-05-20T00:00:00.000' AS DateTime), N'GRN0072', CAST(500.00 AS Decimal(18, 2)), NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (265, 115, N'Steel', N'Steel(Rods)', N'Piece', 400, 200, 0, CAST(N'2025-05-20T00:00:00.000' AS DateTime), N'GRN0073', CAST(500.00 AS Decimal(18, 2)), NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (266, 115, N'Steel', N'Steel(Rods)', N'Piece', 200, 10, 0, CAST(N'2025-05-21T00:00:00.000' AS DateTime), N'GRN0074', CAST(500.00 AS Decimal(18, 2)), NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (267, 116, N'Steel', N'Steel(Rods)', N'Piece', 500, 100, 0, CAST(N'2025-05-20T00:00:00.000' AS DateTime), N'GRN0072', CAST(500.00 AS Decimal(18, 2)), NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (268, 116, N'Steel', N'Steel(Rods)', N'Piece', 400, 200, 0, CAST(N'2025-05-20T00:00:00.000' AS DateTime), N'GRN0073', CAST(500.00 AS Decimal(18, 2)), NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (269, 116, N'Steel', N'Steel(Rods)', N'Piece', 200, 10, 0, CAST(N'2025-05-21T00:00:00.000' AS DateTime), N'GRN0074', CAST(500.00 AS Decimal(18, 2)), NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (270, 120, N'Steel', N'Steel(Rods)', N'Piece', 500, 100, 0, CAST(N'2025-05-20T00:00:00.000' AS DateTime), N'GRN0072', CAST(500.00 AS Decimal(18, 2)), NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (271, 120, N'Steel', N'Steel(Rods)', N'Piece', 400, 200, 0, CAST(N'2025-05-20T00:00:00.000' AS DateTime), N'GRN0073', CAST(500.00 AS Decimal(18, 2)), NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (272, 120, N'Steel', N'Steel(Rods)', N'Piece', 200, 10, 0, CAST(N'2025-05-21T00:00:00.000' AS DateTime), N'GRN0074', CAST(500.00 AS Decimal(18, 2)), NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (273, 121, N'Steel', N'Steel(Rods)', N'Piece', 500, 100, 0, CAST(N'2025-05-20T00:00:00.000' AS DateTime), N'GRN0072', CAST(500.00 AS Decimal(18, 2)), NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (274, 121, N'Steel', N'Steel(Rods)', N'Piece', 400, 200, 0, CAST(N'2025-05-20T00:00:00.000' AS DateTime), N'GRN0073', CAST(500.00 AS Decimal(18, 2)), NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (275, 121, N'Steel', N'Steel(Rods)', N'Piece', 200, 10, 0, CAST(N'2025-05-21T00:00:00.000' AS DateTime), N'GRN0074', CAST(500.00 AS Decimal(18, 2)), NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (276, 122, N'Steel', N'Steel(Rods)', N'Piece', 500, 100, 0, CAST(N'2025-05-20T00:00:00.000' AS DateTime), N'GRN0072', CAST(500.00 AS Decimal(18, 2)), NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (277, 122, N'Steel', N'Steel(Rods)', N'Piece', 400, 200, 0, CAST(N'2025-05-20T00:00:00.000' AS DateTime), N'GRN0073', CAST(500.00 AS Decimal(18, 2)), NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (278, 122, N'Steel', N'Steel(Rods)', N'Piece', 200, 10, 0, CAST(N'2025-05-21T00:00:00.000' AS DateTime), N'GRN0074', CAST(500.00 AS Decimal(18, 2)), NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (279, 123, N'Steel', N'Steel(Rods)', N'Piece', 500, 100, 0, CAST(N'2025-05-20T00:00:00.000' AS DateTime), N'GRN0072', CAST(500.00 AS Decimal(18, 2)), NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (280, 123, N'Steel', N'Steel(Rods)', N'Piece', 400, 200, 0, CAST(N'2025-05-20T00:00:00.000' AS DateTime), N'GRN0073', CAST(500.00 AS Decimal(18, 2)), NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (281, 123, N'Steel', N'Steel(Rods)', N'Piece', 200, 10, 0, CAST(N'2025-05-21T00:00:00.000' AS DateTime), N'GRN0074', CAST(500.00 AS Decimal(18, 2)), NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (282, 124, N'Steel', N'Steel(Rods)', N'Piece', 500, 100, 0, CAST(N'2025-05-20T00:00:00.000' AS DateTime), N'GRN0072', CAST(500.00 AS Decimal(18, 2)), NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (283, 124, N'Steel', N'Steel(Rods)', N'Piece', 400, 200, 0, CAST(N'2025-05-20T00:00:00.000' AS DateTime), N'GRN0073', CAST(500.00 AS Decimal(18, 2)), NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (284, 124, N'Steel', N'Steel(Rods)', N'Piece', 200, 10, 0, CAST(N'2025-05-21T00:00:00.000' AS DateTime), N'GRN0074', CAST(500.00 AS Decimal(18, 2)), NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (285, 125, N'Steel', N'Steel(Rods)', N'Piece', 500, 100, 0, CAST(N'2025-05-20T00:00:00.000' AS DateTime), N'GRN0072', CAST(500.00 AS Decimal(18, 2)), NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (286, 125, N'Steel', N'Steel(Rods)', N'Piece', 400, 200, 0, CAST(N'2025-05-20T00:00:00.000' AS DateTime), N'GRN0073', CAST(500.00 AS Decimal(18, 2)), NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (287, 125, N'Steel', N'Steel(Rods)', N'Piece', 200, 10, 0, CAST(N'2025-05-21T00:00:00.000' AS DateTime), N'GRN0074', CAST(500.00 AS Decimal(18, 2)), NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (288, 126, N'Wood', N'Wood(sheets)', N'Piece', 500, 50, 0, CAST(N'2025-04-22T00:00:00.000' AS DateTime), N'GRN0050', CAST(500.00 AS Decimal(18, 2)), NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (289, 126, N'Steel', N'Steel(Sheets)', N'Piece', 700, 150, 0, CAST(N'2025-04-22T00:00:00.000' AS DateTime), N'GRN0050', CAST(700.00 AS Decimal(18, 2)), NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (290, 126, N'Wood', N'Wood(sheets)', N'Piece', 300, 100, 0, CAST(N'2025-04-22T00:00:00.000' AS DateTime), N'GRN0052', CAST(500.00 AS Decimal(18, 2)), NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (291, 126, N'Steel', N'Steel(Sheets)', N'Piece', 430, 30, 0, CAST(N'2025-04-22T00:00:00.000' AS DateTime), N'GRN0052', CAST(700.00 AS Decimal(18, 2)), NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (292, 127, N'Steel', N'Steel(Rods)', N'Piece', 500, 100, 0, CAST(N'2025-05-20T00:00:00.000' AS DateTime), N'GRN0072', CAST(500.00 AS Decimal(18, 2)), NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (293, 127, N'Steel', N'Steel(Rods)', N'Piece', 400, 200, 0, CAST(N'2025-05-20T00:00:00.000' AS DateTime), N'GRN0073', CAST(500.00 AS Decimal(18, 2)), NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (294, 127, N'Steel', N'Steel(Rods)', N'Piece', 200, 10, 0, CAST(N'2025-05-21T00:00:00.000' AS DateTime), N'GRN0074', CAST(500.00 AS Decimal(18, 2)), NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (295, 128, N'Wood', N'Wood(sheets)', N'Piece', 500, 50, 0, CAST(N'2025-04-22T00:00:00.000' AS DateTime), N'GRN0050', CAST(500.00 AS Decimal(18, 2)), NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (296, 128, N'Steel', N'Steel(Sheets)', N'Piece', 700, 150, 0, CAST(N'2025-04-22T00:00:00.000' AS DateTime), N'GRN0050', CAST(700.00 AS Decimal(18, 2)), NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (297, 128, N'Wood', N'Wood(sheets)', N'Piece', 300, 100, 0, CAST(N'2025-04-22T00:00:00.000' AS DateTime), N'GRN0052', CAST(500.00 AS Decimal(18, 2)), NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (298, 128, N'Steel', N'Steel(Sheets)', N'Piece', 430, 30, 0, CAST(N'2025-04-22T00:00:00.000' AS DateTime), N'GRN0052', CAST(700.00 AS Decimal(18, 2)), NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (299, 129, N'Fabric', N'Georgette', N'Meter', 900, 200, 0, CAST(N'2025-04-22T00:00:00.000' AS DateTime), N'GRN0046', CAST(900.00 AS Decimal(18, 2)), NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (300, 129, N'Fabric', N'Georgette', N'Meter', 700, 300, 0, CAST(N'2025-04-22T00:00:00.000' AS DateTime), N'GRN0049', CAST(900.00 AS Decimal(18, 2)), NULL)
GO
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (301, 129, N'Fabric', N'Georgette', N'Meter', 400, 100, 0, CAST(N'2025-05-19T00:00:00.000' AS DateTime), N'GRN0067', CAST(900.00 AS Decimal(18, 2)), NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (302, 130, N'Steel', N'Steel(Sheets)', N'Piece', 500, 150, 0, CAST(N'2025-04-22T00:00:00.000' AS DateTime), N'GRN0041', CAST(500.00 AS Decimal(18, 2)), NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (303, 130, N'Steel', N'Steel(Sheets)', N'Piece', 350, 120, 0, CAST(N'2025-04-22T00:00:00.000' AS DateTime), N'GRN0043', CAST(500.00 AS Decimal(18, 2)), NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (304, 130, N'Steel', N'Steel(Sheets)', N'Piece', 130, 100, 0, CAST(N'2025-04-22T00:00:00.000' AS DateTime), N'GRN0045', CAST(500.00 AS Decimal(18, 2)), NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (305, 131, N'Steel', N'Steel(Rods)', N'Piece', 500, 100, 0, CAST(N'2025-05-20T00:00:00.000' AS DateTime), N'GRN0072', CAST(500.00 AS Decimal(18, 2)), NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (306, 131, N'Steel', N'Steel(Rods)', N'Piece', 400, 200, 0, CAST(N'2025-05-20T00:00:00.000' AS DateTime), N'GRN0073', CAST(500.00 AS Decimal(18, 2)), NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (307, 131, N'Steel', N'Steel(Rods)', N'Piece', 200, 10, 0, CAST(N'2025-05-21T00:00:00.000' AS DateTime), N'GRN0074', CAST(500.00 AS Decimal(18, 2)), NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (308, 132, N'Wood', N'Flie', N'Piece', 120, 20, 0, CAST(N'2025-05-02T00:00:00.000' AS DateTime), N'GRN0056', CAST(120.00 AS Decimal(18, 2)), NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (309, 132, N'Wood', N'Flie', N'Piece', 100, 50, 0, CAST(N'2025-05-02T00:00:00.000' AS DateTime), N'GRN0057', CAST(120.00 AS Decimal(18, 2)), NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (310, 132, N'Wood', N'Flie', N'Piece', 50, 10, 0, CAST(N'2025-05-19T00:00:00.000' AS DateTime), N'GRN0068', CAST(120.00 AS Decimal(18, 2)), NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (311, 132, N'Wood', N'Flie', N'Piece', 40, 20, 0, CAST(N'2025-05-19T00:00:00.000' AS DateTime), N'GRN0069', CAST(120.00 AS Decimal(18, 2)), NULL)
INSERT [dbo].[PurchaseOrderTrackItems] ([PurchaseOrderTrackItemId], [PurchaseOrderTrackId], [MaterialType], [MaterialName], [Unit], [Quantity], [ActualQuantity], [GRNId], [GRNDate], [GRNCode], [OriginalQuantity], [UnitPrice]) VALUES (312, 132, N'Wood', N'Flie', N'Piece', 20, 10, 0, CAST(N'2025-05-19T00:00:00.000' AS DateTime), N'GRN0071', CAST(120.00 AS Decimal(18, 2)), NULL)
SET IDENTITY_INSERT [dbo].[PurchaseOrderTrackItems] OFF
GO
SET IDENTITY_INSERT [dbo].[PurchaseOrderTracks] ON 

INSERT [dbo].[PurchaseOrderTracks] ([PurchaseOrderTrackId], [PurchaseOrderId], [POCode], [VendorId], [OrderDate], [ExpectedDelivery], [Balance], [TotalPrice], [ActualQuantity], [Price], [Quantity], [GRNQuantity], [OriQuantity], [OriTotalPrice], [PurchaseOrderQuantity], [PurchaseOrderTotalPrice], [UnitPrice], [Unit]) VALUES (126, 20, N'PO-20250422155800', 15, CAST(N'2025-05-05T00:00:00.000' AS DateTime), CAST(N'2025-06-15T00:00:00.000' AS DateTime), NULL, CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(1200.00 AS Decimal(18, 2)), CAST(81000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), NULL)
INSERT [dbo].[PurchaseOrderTracks] ([PurchaseOrderTrackId], [PurchaseOrderId], [POCode], [VendorId], [OrderDate], [ExpectedDelivery], [Balance], [TotalPrice], [ActualQuantity], [Price], [Quantity], [GRNQuantity], [OriQuantity], [OriTotalPrice], [PurchaseOrderQuantity], [PurchaseOrderTotalPrice], [UnitPrice], [Unit]) VALUES (129, 19, N'PO-20250422155033', 13, CAST(N'2025-04-23T00:00:00.000' AS DateTime), CAST(N'2025-05-10T00:00:00.000' AS DateTime), NULL, CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(900.00 AS Decimal(18, 2)), CAST(45000.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), NULL)
INSERT [dbo].[PurchaseOrderTracks] ([PurchaseOrderTrackId], [PurchaseOrderId], [POCode], [VendorId], [OrderDate], [ExpectedDelivery], [Balance], [TotalPrice], [ActualQuantity], [Price], [Quantity], [GRNQuantity], [OriQuantity], [OriTotalPrice], [PurchaseOrderQuantity], [PurchaseOrderTotalPrice], [UnitPrice], [Unit]) VALUES (131, 27, N'PO-20250520124633', 16, CAST(N'2025-05-04T00:00:00.000' AS DateTime), CAST(N'2025-05-22T00:00:00.000' AS DateTime), NULL, CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(500.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), NULL)
INSERT [dbo].[PurchaseOrderTracks] ([PurchaseOrderTrackId], [PurchaseOrderId], [POCode], [VendorId], [OrderDate], [ExpectedDelivery], [Balance], [TotalPrice], [ActualQuantity], [Price], [Quantity], [GRNQuantity], [OriQuantity], [OriTotalPrice], [PurchaseOrderQuantity], [PurchaseOrderTotalPrice], [UnitPrice], [Unit]) VALUES (132, 23, N'PO-20250502122250', 2, CAST(N'2025-05-02T00:00:00.000' AS DateTime), CAST(N'2025-05-23T00:00:00.000' AS DateTime), NULL, CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(120.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), CAST(0.00 AS Decimal(18, 2)), NULL)
SET IDENTITY_INSERT [dbo].[PurchaseOrderTracks] OFF
GO
SET IDENTITY_INSERT [dbo].[RawMaterials] ON 

INSERT [dbo].[RawMaterials] ([RawMaterialId], [MaterialType], [VendorId], [Quantity], [Unit], [CreatedDate], [ModifiedDate], [VendorName], [MaterialName]) VALUES (14, N'Steel,Fabric', 2, 0, N'20mm,Meter', CAST(N'2025-04-02T15:26:49.107' AS DateTime), CAST(N'2025-04-10T12:48:57.573' AS DateTime), NULL, N'Steel(Rode),Fabric(siffon)')
INSERT [dbo].[RawMaterials] ([RawMaterialId], [MaterialType], [VendorId], [Quantity], [Unit], [CreatedDate], [ModifiedDate], [VendorName], [MaterialName]) VALUES (16, N'Plastic,Wood', 9, 0, N'Kg', CAST(N'2025-04-02T16:02:03.047' AS DateTime), CAST(N'2025-04-10T12:48:35.403' AS DateTime), NULL, N'Plastic(Nylon),Wood(Cheery,Maple)')
INSERT [dbo].[RawMaterials] ([RawMaterialId], [MaterialType], [VendorId], [Quantity], [Unit], [CreatedDate], [ModifiedDate], [VendorName], [MaterialName]) VALUES (18, N'Fabric,Plastic,Wood', 10, 0, N'Meter,Kg,10Piece', CAST(N'2025-04-02T16:11:23.677' AS DateTime), CAST(N'2025-04-10T12:51:11.007' AS DateTime), NULL, N'Fabric(Polyster,Cotton),Plastic(Naylon),Wood(Oak)')
INSERT [dbo].[RawMaterials] ([RawMaterialId], [MaterialType], [VendorId], [Quantity], [Unit], [CreatedDate], [ModifiedDate], [VendorName], [MaterialName]) VALUES (19, N'Steel,Fabric,Plastic', 12, 0, N'Kg,Meter,Piece', CAST(N'2025-04-03T13:23:47.020' AS DateTime), CAST(N'2025-04-10T12:51:00.343' AS DateTime), NULL, N'Steel(Sheets),Cotton,Polythylene')
INSERT [dbo].[RawMaterials] ([RawMaterialId], [MaterialType], [VendorId], [Quantity], [Unit], [CreatedDate], [ModifiedDate], [VendorName], [MaterialName]) VALUES (22, N'Fabric', 7, 0, N'Meter', CAST(N'2025-04-09T11:56:10.880' AS DateTime), CAST(N'2025-04-10T12:51:21.017' AS DateTime), NULL, N'TeriCot')
INSERT [dbo].[RawMaterials] ([RawMaterialId], [MaterialType], [VendorId], [Quantity], [Unit], [CreatedDate], [ModifiedDate], [VendorName], [MaterialName]) VALUES (25, N'Steel,Fabric,Plastic', 9, 0, N'20mm,Meter', CAST(N'2025-05-02T12:21:02.893' AS DateTime), NULL, NULL, N'Steel(Rode),Fabric(siffon)')
INSERT [dbo].[RawMaterials] ([RawMaterialId], [MaterialType], [VendorId], [Quantity], [Unit], [CreatedDate], [ModifiedDate], [VendorName], [MaterialName]) VALUES (26, N'Fabric,Plastic,Wood', 2, 0, N'20mm,Meter,Piece', CAST(N'2025-05-06T14:23:01.693' AS DateTime), NULL, NULL, N'Fabric(Polyster,Cotton),Plastic(Naylon),Wood(Oak)')
INSERT [dbo].[RawMaterials] ([RawMaterialId], [MaterialType], [VendorId], [Quantity], [Unit], [CreatedDate], [ModifiedDate], [VendorName], [MaterialName]) VALUES (27, N'Steel,Plastic', 2, 0, N'piece', CAST(N'2025-05-30T15:37:32.277' AS DateTime), NULL, NULL, N'Sheets')
INSERT [dbo].[RawMaterials] ([RawMaterialId], [MaterialType], [VendorId], [Quantity], [Unit], [CreatedDate], [ModifiedDate], [VendorName], [MaterialName]) VALUES (28, N'Plastic', 2, 0, N'kg,Pieces', CAST(N'2025-05-30T15:45:51.663' AS DateTime), CAST(N'2025-05-30T15:51:10.343' AS DateTime), NULL, N'Stainless Steel sheets,Caps ')
INSERT [dbo].[RawMaterials] ([RawMaterialId], [MaterialType], [VendorId], [Quantity], [Unit], [CreatedDate], [ModifiedDate], [VendorName], [MaterialName]) VALUES (29, N'Silicone', 13, 0, N'Piece', CAST(N'2025-05-30T15:52:23.440' AS DateTime), NULL, NULL, N'Silicone Ring')
INSERT [dbo].[RawMaterials] ([RawMaterialId], [MaterialType], [VendorId], [Quantity], [Unit], [CreatedDate], [ModifiedDate], [VendorName], [MaterialName]) VALUES (30, N'Fabric', 9, 0, N'Meter', CAST(N'2025-05-30T16:32:31.920' AS DateTime), NULL, NULL, N'Cotton Fabric')
INSERT [dbo].[RawMaterials] ([RawMaterialId], [MaterialType], [VendorId], [Quantity], [Unit], [CreatedDate], [ModifiedDate], [VendorName], [MaterialName]) VALUES (31, N'Zipper', 15, 0, N'pieces', CAST(N'2025-05-30T16:33:55.843' AS DateTime), NULL, NULL, N'Metal Zipper')
INSERT [dbo].[RawMaterials] ([RawMaterialId], [MaterialType], [VendorId], [Quantity], [Unit], [CreatedDate], [ModifiedDate], [VendorName], [MaterialName]) VALUES (32, N'Thread', 16, 0, N'Spool', CAST(N'2025-05-30T16:35:22.430' AS DateTime), NULL, NULL, N'Polyester Thread')
INSERT [dbo].[RawMaterials] ([RawMaterialId], [MaterialType], [VendorId], [Quantity], [Unit], [CreatedDate], [ModifiedDate], [VendorName], [MaterialName]) VALUES (33, N' Buttons', 7, 0, N'Piece', CAST(N'2025-05-30T16:35:59.953' AS DateTime), NULL, NULL, N'Plastic Buttons')
SET IDENTITY_INSERT [dbo].[RawMaterials] OFF
GO
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([Id], [FirstName], [LastName], [Email], [Password], [ContactNo], [CreatedDate], [ModifiedDate]) VALUES (1, N'Diksha', N'Parit', N'Diksha@gmail.com', N'1234567', N'9182736453', CAST(N'2025-03-25T12:10:39.360' AS DateTime), NULL)
INSERT [dbo].[Users] ([Id], [FirstName], [LastName], [Email], [Password], [ContactNo], [CreatedDate], [ModifiedDate]) VALUES (2, N'Kirti', N'Parit', N'Kirti21@gmail.com', N'$2a$11$3F5M0iCQESl9yboPmKNkKOpwF7twNgEGoDH6NVtFxOMMXzaM5QmzO', N'8765432145', CAST(N'2025-03-25T12:20:13.537' AS DateTime), NULL)
INSERT [dbo].[Users] ([Id], [FirstName], [LastName], [Email], [Password], [ContactNo], [CreatedDate], [ModifiedDate]) VALUES (3, N'Krishna', N'Parit', N'Krishna@gmail.com', N'$2a$12$sXqoF3POzalGaMARQ5lz5.Cl3UM/RPbHnxgbNpsYc6VWauUJjIpyS', N'7083483920', CAST(N'2025-03-25T12:22:56.220' AS DateTime), NULL)
INSERT [dbo].[Users] ([Id], [FirstName], [LastName], [Email], [Password], [ContactNo], [CreatedDate], [ModifiedDate]) VALUES (4, N'sonali', N'Hiwale', N'sonali@gmail.com', N'$2a$12$Tw0amWL6peJ75xAM/JRtCeYnSw6ZNoPtXIZJDa.zcdn/tkcD47O6u', N'8192837465', CAST(N'2025-03-25T12:23:53.540' AS DateTime), NULL)
INSERT [dbo].[Users] ([Id], [FirstName], [LastName], [Email], [Password], [ContactNo], [CreatedDate], [ModifiedDate]) VALUES (5, N'Rutuja', N'Kale', N'Kale1@gmail.com', N'$2a$12$LxHsa1VMj6NRM4JoXIDx6u6mMYF6GFhzW1BQtFdW5vAE9k7fldMHG', N'9182736453', CAST(N'2025-03-25T14:04:39.897' AS DateTime), NULL)
INSERT [dbo].[Users] ([Id], [FirstName], [LastName], [Email], [Password], [ContactNo], [CreatedDate], [ModifiedDate]) VALUES (6, N'sa', N'ss', N'aditi@gmail.com', N'1234123', N'7083483920', CAST(N'2025-03-25T15:06:40.003' AS DateTime), NULL)
INSERT [dbo].[Users] ([Id], [FirstName], [LastName], [Email], [Password], [ContactNo], [CreatedDate], [ModifiedDate]) VALUES (7, N'Riya', N'patil', N'Riya@gmail.com', N'Riya@12', N'7083483920', CAST(N'2025-03-25T15:10:49.850' AS DateTime), NULL)
INSERT [dbo].[Users] ([Id], [FirstName], [LastName], [Email], [Password], [ContactNo], [CreatedDate], [ModifiedDate]) VALUES (8, N'Kirti', N'Parit', N'Kirti@gmail.com', N'Kirti@1', N'9182736453', CAST(N'2025-03-26T15:28:42.577' AS DateTime), NULL)
INSERT [dbo].[Users] ([Id], [FirstName], [LastName], [Email], [Password], [ContactNo], [CreatedDate], [ModifiedDate]) VALUES (9, N'Sejal', N'Patil', N'Sejal@gmail.com', N'Sejal@1', N'7083483920', CAST(N'2025-03-26T15:47:46.080' AS DateTime), NULL)
INSERT [dbo].[Users] ([Id], [FirstName], [LastName], [Email], [Password], [ContactNo], [CreatedDate], [ModifiedDate]) VALUES (10, N'Rutuja', N'Kale', N'Rutu@gmail.com', N'1234567', N'7083483920', CAST(N'2025-03-26T17:27:46.283' AS DateTime), NULL)
INSERT [dbo].[Users] ([Id], [FirstName], [LastName], [Email], [Password], [ContactNo], [CreatedDate], [ModifiedDate]) VALUES (11, N'Admin', N'Admin', N'admin@erp.com', N'1234567', N'7083483920', CAST(N'2025-04-08T14:50:35.003' AS DateTime), NULL)
INSERT [dbo].[Users] ([Id], [FirstName], [LastName], [Email], [Password], [ContactNo], [CreatedDate], [ModifiedDate]) VALUES (12, N'Omkar', N'Hiwale Patil', N'Om@gmail.com', N'1234567', N'7083483920', CAST(N'2025-05-02T12:19:48.770' AS DateTime), NULL)
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
SET IDENTITY_INSERT [dbo].[Vendors] ON 

INSERT [dbo].[Vendors] ([VendorName], [Email], [PhoneNumber], [Address], [CompanyName], [Status], [CreatedDate], [ModifiedDate], [VendorId]) VALUES (N'Diksha', N'Diksha21@gmail.com', N'9595724443', N'Waluj MIDC', N'Unioteq', N'Inactive', CAST(N'2025-03-19T07:20:36.253' AS DateTime), CAST(N'2025-03-19T07:20:36.253' AS DateTime), 2)
INSERT [dbo].[Vendors] ([VendorName], [Email], [PhoneNumber], [Address], [CompanyName], [Status], [CreatedDate], [ModifiedDate], [VendorId]) VALUES (N'Krishna', N'Krishna901@gmail.com', N'9541236874', N'Near South City', N'Modi Innovation', N'Active', CAST(N'2025-03-19T07:23:12.940' AS DateTime), CAST(N'2025-03-19T07:23:12.940' AS DateTime), 3)
INSERT [dbo].[Vendors] ([VendorName], [Email], [PhoneNumber], [Address], [CompanyName], [Status], [CreatedDate], [ModifiedDate], [VendorId]) VALUES (N'Sagar', N'sagar1@gmail.com', N'9087678987', N'pune', N'makeover', N'Active', CAST(N'2025-03-21T10:49:16.077' AS DateTime), CAST(N'2025-03-21T10:49:16.077' AS DateTime), 6)
INSERT [dbo].[Vendors] ([VendorName], [Email], [PhoneNumber], [Address], [CompanyName], [Status], [CreatedDate], [ModifiedDate], [VendorId]) VALUES (N'Rahul', N'Rahul@gmail.com', N'9876543215', N'Mumbai', N'servo lite', N'Active', CAST(N'2025-04-08T18:00:07.840' AS DateTime), CAST(N'2025-04-08T18:00:07.863' AS DateTime), 7)
INSERT [dbo].[Vendors] ([VendorName], [Email], [PhoneNumber], [Address], [CompanyName], [Status], [CreatedDate], [ModifiedDate], [VendorId]) VALUES (N'Riya ', N'Riya@gmail.com', N'9595724443', N'softwarepark', N'united', N'Active', CAST(N'2025-03-25T08:09:26.537' AS DateTime), CAST(N'2025-03-25T08:09:26.537' AS DateTime), 8)
INSERT [dbo].[Vendors] ([VendorName], [Email], [PhoneNumber], [Address], [CompanyName], [Status], [CreatedDate], [ModifiedDate], [VendorId]) VALUES (N'Ovii', N'Ovika@gmail.com', N'9876543212', N'Near MGM clg', N'TCS', N'Active', CAST(N'2025-03-26T09:26:00.077' AS DateTime), CAST(N'2025-03-26T09:26:00.077' AS DateTime), 9)
INSERT [dbo].[Vendors] ([VendorName], [Email], [PhoneNumber], [Address], [CompanyName], [Status], [CreatedDate], [ModifiedDate], [VendorId]) VALUES (N'Kirti', N'Kirti@gmail.com', N'9595724443', N'Shivajinagar', N'Angel', N'Active', CAST(N'2025-03-26T10:00:07.637' AS DateTime), CAST(N'2025-03-26T10:00:07.637' AS DateTime), 10)
INSERT [dbo].[Vendors] ([VendorName], [Email], [PhoneNumber], [Address], [CompanyName], [Status], [CreatedDate], [ModifiedDate], [VendorId]) VALUES (N'shivani', N'shivani@gmail.com', N'9876543212', N'satara', N'your solution', N'Active', CAST(N'2025-04-03T07:53:26.943' AS DateTime), CAST(N'2025-04-03T07:53:26.947' AS DateTime), 12)
INSERT [dbo].[Vendors] ([VendorName], [Email], [PhoneNumber], [Address], [CompanyName], [Status], [CreatedDate], [ModifiedDate], [VendorId]) VALUES (N'ABC Supplies', N'abc@email.com', N'1234567890', N'123 Street', N'ABC Ltd.', N'Active', CAST(N'2025-04-03T15:56:53.887' AS DateTime), CAST(N'2025-04-03T15:56:53.887' AS DateTime), 13)
INSERT [dbo].[Vendors] ([VendorName], [Email], [PhoneNumber], [Address], [CompanyName], [Status], [CreatedDate], [ModifiedDate], [VendorId]) VALUES (N'Rita', N'Rita@gmail.com', N'9595724443', N'MIDC Waluj', N'Connect Solution', N'Inactive', CAST(N'2025-04-08T07:34:19.993' AS DateTime), CAST(N'2025-04-08T07:34:20.003' AS DateTime), 15)
INSERT [dbo].[Vendors] ([VendorName], [Email], [PhoneNumber], [Address], [CompanyName], [Status], [CreatedDate], [ModifiedDate], [VendorId]) VALUES (N'Ganesh', N'ganesh51@gmail.com', N'9595724443', N'Cidco', N'Triodia Ltd', N'Active', CAST(N'2025-05-02T07:02:39.810' AS DateTime), CAST(N'2025-05-02T07:02:39.810' AS DateTime), 16)
INSERT [dbo].[Vendors] ([VendorName], [Email], [PhoneNumber], [Address], [CompanyName], [Status], [CreatedDate], [ModifiedDate], [VendorId]) VALUES (N'Ganesh', N'hh@gmail.com', N'9876543212', N'aa', N'aa', N'Active', CAST(N'2025-05-02T07:03:16.060' AS DateTime), CAST(N'2025-05-02T07:03:16.060' AS DateTime), 18)
INSERT [dbo].[Vendors] ([VendorName], [Email], [PhoneNumber], [Address], [CompanyName], [Status], [CreatedDate], [ModifiedDate], [VendorId]) VALUES (N'Amol Tupe', N'Amol@gmail.com', N'9541236874', N'N7', N'Unioteq', N'Active', CAST(N'2025-05-08T05:44:45.937' AS DateTime), CAST(N'2025-05-08T05:44:45.937' AS DateTime), 19)
INSERT [dbo].[Vendors] ([VendorName], [Email], [PhoneNumber], [Address], [CompanyName], [Status], [CreatedDate], [ModifiedDate], [VendorId]) VALUES (N'Gauri', N'Gauri@gmail.com', N'9541236874', N'Cidco', N'Man', N'Active', CAST(N'2025-05-29T07:20:10.763' AS DateTime), CAST(N'2025-05-29T07:20:10.767' AS DateTime), 20)
SET IDENTITY_INSERT [dbo].[Vendors] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Users__A9D10534FE5B60E5]    Script Date: 01-07-2025 02:06:02 PM ******/
ALTER TABLE [dbo].[Users] ADD UNIQUE NONCLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Vendors__A9D105348124219F]    Script Date: 01-07-2025 02:06:02 PM ******/
ALTER TABLE [dbo].[Vendors] ADD  CONSTRAINT [UQ__Vendors__A9D105348124219F] UNIQUE NONCLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[GRNs] ADD  DEFAULT ((0)) FOR [VendorId]
GO
ALTER TABLE [dbo].[GRNs] ADD  DEFAULT ('') FOR [POCode]
GO
ALTER TABLE [dbo].[Login] ADD  DEFAULT ((0)) FOR [RememberMe]
GO
ALTER TABLE [dbo].[Login] ADD  DEFAULT (getdate()) FOR [LoginTime]
GO
ALTER TABLE [dbo].[ProductionPlans] ADD  DEFAULT ((0)) FOR [ActualQuantity]
GO
ALTER TABLE [dbo].[ProductionPlans] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[PurchaseOrderItems] ADD  DEFAULT ('Unknown') FOR [MaterialName]
GO
ALTER TABLE [dbo].[PurchaseOrderTracks] ADD  CONSTRAINT [DF__PurchaseO__Total__3E3D3572]  DEFAULT ((0)) FOR [TotalPrice]
GO
ALTER TABLE [dbo].[PurchaseOrderTracks] ADD  CONSTRAINT [DF__PurchaseO__Actua__3F3159AB]  DEFAULT ((0)) FOR [ActualQuantity]
GO
ALTER TABLE [dbo].[PurchaseOrderTracks] ADD  CONSTRAINT [DF__PurchaseO__Price__40257DE4]  DEFAULT ((0)) FOR [Price]
GO
ALTER TABLE [dbo].[PurchaseOrderTracks] ADD  CONSTRAINT [DF__PurchaseO__Quant__4119A21D]  DEFAULT ((0)) FOR [Quantity]
GO
ALTER TABLE [dbo].[PurchaseOrderTracks] ADD  CONSTRAINT [DF__PurchaseO__GRNQu__420DC656]  DEFAULT ((0)) FOR [GRNQuantity]
GO
ALTER TABLE [dbo].[PurchaseOrderTracks] ADD  CONSTRAINT [DF__PurchaseO__OriQu__4301EA8F]  DEFAULT ((0)) FOR [OriQuantity]
GO
ALTER TABLE [dbo].[PurchaseOrderTracks] ADD  CONSTRAINT [DF__PurchaseO__OriTo__43F60EC8]  DEFAULT ((0)) FOR [OriTotalPrice]
GO
ALTER TABLE [dbo].[PurchaseOrderTracks] ADD  CONSTRAINT [DF__PurchaseO__Purch__44EA3301]  DEFAULT ((0)) FOR [PurchaseOrderQuantity]
GO
ALTER TABLE [dbo].[PurchaseOrderTracks] ADD  CONSTRAINT [DF__PurchaseO__Purch__45DE573A]  DEFAULT ((0)) FOR [PurchaseOrderTotalPrice]
GO
ALTER TABLE [dbo].[PurchaseOrderTracks] ADD  CONSTRAINT [DF__PurchaseO__UnitP__47C69FAC]  DEFAULT ((0.00)) FOR [UnitPrice]
GO
ALTER TABLE [dbo].[PurchaseOrderTracks] ADD  DEFAULT ('') FOR [Unit]
GO
ALTER TABLE [dbo].[RawMaterials] ADD  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[RawMaterials] ADD  CONSTRAINT [DF_RawMaterials_VendorName]  DEFAULT ('Unknown Vendor') FOR [VendorName]
GO
ALTER TABLE [dbo].[RawMaterials] ADD  CONSTRAINT [DF_RawMaterials_MaterialName]  DEFAULT ('Unknown Material') FOR [MaterialName]
GO
ALTER TABLE [dbo].[Users] ADD  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[Vendors] ADD  CONSTRAINT [DF__Vendors__Created__13F1F5EB]  DEFAULT (getutcdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[FinishedGoodsItems]  WITH CHECK ADD  CONSTRAINT [FK_FinishedGoodsItems_FinishedGoodsMaster] FOREIGN KEY([FinishedGoodsMasterId])
REFERENCES [dbo].[FinishedGoodsMasters] ([FinishedGoodsMasterId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[FinishedGoodsItems] CHECK CONSTRAINT [FK_FinishedGoodsItems_FinishedGoodsMaster]
GO
ALTER TABLE [dbo].[FinishedGoodsItems]  WITH CHECK ADD  CONSTRAINT [FK_FinishedGoodsItems_RawMaterials] FOREIGN KEY([RawMaterialId])
REFERENCES [dbo].[RawMaterials] ([RawMaterialId])
GO
ALTER TABLE [dbo].[FinishedGoodsItems] CHECK CONSTRAINT [FK_FinishedGoodsItems_RawMaterials]
GO
ALTER TABLE [dbo].[GRNItems]  WITH CHECK ADD  CONSTRAINT [FK_GRNItem_GRN] FOREIGN KEY([GRNId])
REFERENCES [dbo].[GRNs] ([GRNId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[GRNItems] CHECK CONSTRAINT [FK_GRNItem_GRN]
GO
ALTER TABLE [dbo].[GRNItems]  WITH CHECK ADD  CONSTRAINT [FK_GRNItem_PurchaseOrderItem] FOREIGN KEY([PurchaseOrderItemId])
REFERENCES [dbo].[PurchaseOrderItems] ([PurchaseOrderItemId])
GO
ALTER TABLE [dbo].[GRNItems] CHECK CONSTRAINT [FK_GRNItem_PurchaseOrderItem]
GO
ALTER TABLE [dbo].[ProductionPlans]  WITH CHECK ADD  CONSTRAINT [FK_ProductionPlan_FinishedGoods] FOREIGN KEY([FinishedGoodsMasterId])
REFERENCES [dbo].[FinishedGoodsMasters] ([FinishedGoodsMasterId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ProductionPlans] CHECK CONSTRAINT [FK_ProductionPlan_FinishedGoods]
GO
ALTER TABLE [dbo].[PurchaseOrderItems]  WITH CHECK ADD  CONSTRAINT [FK_PurchaseOrderItem_PurchaseOrder] FOREIGN KEY([PurchaseOrderId])
REFERENCES [dbo].[PurchaseOrders] ([PurchaseOrderId])
GO
ALTER TABLE [dbo].[PurchaseOrderItems] CHECK CONSTRAINT [FK_PurchaseOrderItem_PurchaseOrder]
GO
ALTER TABLE [dbo].[PurchaseOrders]  WITH CHECK ADD  CONSTRAINT [FK_PurchaseOrder_Vendor] FOREIGN KEY([VendorId])
REFERENCES [dbo].[Vendors] ([VendorId])
GO
ALTER TABLE [dbo].[PurchaseOrders] CHECK CONSTRAINT [FK_PurchaseOrder_Vendor]
GO
ALTER TABLE [dbo].[PurchaseOrders]  WITH CHECK ADD  CONSTRAINT [FK_PurchaseOrdesr_PurchaseOrderTracks] FOREIGN KEY([PurchaseOrderTrackId])
REFERENCES [dbo].[PurchaseOrderTracks] ([PurchaseOrderTrackId])
GO
ALTER TABLE [dbo].[PurchaseOrders] CHECK CONSTRAINT [FK_PurchaseOrdesr_PurchaseOrderTracks]
GO
ALTER TABLE [dbo].[PurchaseOrderTracks]  WITH CHECK ADD  CONSTRAINT [FK_PurchaseOrderTrack_PurchaseOrders] FOREIGN KEY([PurchaseOrderId])
REFERENCES [dbo].[PurchaseOrders] ([PurchaseOrderId])
GO
ALTER TABLE [dbo].[PurchaseOrderTracks] CHECK CONSTRAINT [FK_PurchaseOrderTrack_PurchaseOrders]
GO
ALTER TABLE [dbo].[PurchaseOrderItems]  WITH CHECK ADD CHECK  (([Quantity]>(0)))
GO
ALTER TABLE [dbo].[Vendors]  WITH CHECK ADD  CONSTRAINT [CK_Vendors_Status] CHECK  ((lower([Status])='inactive' OR lower([Status])='active'))
GO
ALTER TABLE [dbo].[Vendors] CHECK CONSTRAINT [CK_Vendors_Status]
GO
USE [master]
GO
ALTER DATABASE [ERP] SET  READ_WRITE 
GO
