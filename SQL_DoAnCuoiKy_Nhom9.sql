USE [master]
GO
/****** Object:  Database [QLHH]    Script Date: 11/16/2022 11:23:05 PM ******/
CREATE DATABASE [QLHH]
GO
ALTER DATABASE [QLHH] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [QLHH].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [QLHH] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [QLHH] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [QLHH] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [QLHH] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [QLHH] SET ARITHABORT OFF 
GO
ALTER DATABASE [QLHH] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [QLHH] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [QLHH] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [QLHH] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [QLHH] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [QLHH] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [QLHH] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [QLHH] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [QLHH] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [QLHH] SET  ENABLE_BROKER 
GO
ALTER DATABASE [QLHH] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [QLHH] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [QLHH] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [QLHH] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [QLHH] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [QLHH] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [QLHH] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [QLHH] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [QLHH] SET  MULTI_USER 
GO
ALTER DATABASE [QLHH] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [QLHH] SET DB_CHAINING OFF 
GO
ALTER DATABASE [QLHH] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [QLHH] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [QLHH] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [QLHH] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'QLHH', N'ON'
GO
ALTER DATABASE [QLHH] SET QUERY_STORE = OFF
GO
USE [QLHH]
GO
CREATE LOGIN [admin] WITH PASSWORD = '123'
GO
/****** Object:  User [admin]    Script Date: 11/16/2022 11:23:06 PM ******/
CREATE USER [admin] FOR LOGIN [admin] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [admin]
GO
/****** Object:  UserDefinedFunction [dbo].[ChiPhiPhaiThanhToanChoNhaCungCap]    Script Date: 11/16/2022 11:23:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[ChiPhiPhaiThanhToanChoNhaCungCap](@Ngay date,@MaNhaCungCap char(20))
returns int
as
begin
	declare @SoTien int
	select @SoTien=sum(Gia*SoLuong) from HangHoa join ChiTietNhapHang on ChiTietNhapHang.MaHang=HangHoa.MaHang where NgayNhap=@Ngay and MaNhaCungCap=@MaNhaCungCap
	return @SoTien
end
GO
/****** Object:  UserDefinedFunction [dbo].[ThongBaoHangLoi]    Script Date: 11/16/2022 11:23:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE function [dbo].[ThongBaoHangLoi]()
returns @table table(MaHang char(20),TenLoi nvarchar(50),SoLuong int)
as
begin
	insert @table select * from HangLoi 
	return
end
GO
/****** Object:  Table [dbo].[HangHoa]    Script Date: 11/16/2022 11:23:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HangHoa](
	[MaHang] [char](20) NOT NULL,
	[TenHang] [nvarchar](30) NULL,
	[Gia] [real] NULL,
	[SoLuongTonKho] [int] NULL,
	[MaLoaiHang] [char](20) NULL,
 CONSTRAINT [pk_MaHang] PRIMARY KEY CLUSTERED 
(
	[MaHang] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  UserDefinedFunction [dbo].[HangCoSoLuongDuoi10]    Script Date: 11/16/2022 11:23:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[HangCoSoLuongDuoi10]()
returns table as
return
	select *
	from HangHoa
	where HangHoa.SoLuongTonKho <10
GO
/****** Object:  Table [dbo].[ChiTietNhapHang]    Script Date: 11/16/2022 11:23:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChiTietNhapHang](
	[MaNhapHang] [char](20) NOT NULL,
	[MaHang] [char](20) NULL,
	[SoLuong] [int] NULL,
	[NgayNhap] [date] NULL,
	[MaNhaCungCap] [char](20) NULL,
 CONSTRAINT [pk_MaNhapHang] PRIMARY KEY CLUSTERED 
(
	[MaNhapHang] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[view_NhapHang]    Script Date: 11/16/2022 11:23:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[view_ChiTietNhapHang] as
select MaNhapHang, SoLuong, NgayNhap, MaNhaCungCap
from ChiTietNhapHang
GO
/****** Object:  Table [dbo].[ChiTietXuatHang]    Script Date: 11/16/2022 11:23:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChiTietXuatHang](
	[MaXuatHang] [char](20) NOT NULL,
	[MaHang] [char](20) NULL,
	[SoLuong] [int] NULL,
	[NgayXuat] [date] NULL,
 CONSTRAINT [pk_MaXuatHang] PRIMARY KEY CLUSTERED 
(
	[MaXuatHang] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[view_XuatHang]    Script Date: 11/16/2022 11:23:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[view_ChiTietXuatHang] as
select MaXuatHang, MaHang, SoLuong, NgayXuat
from ChiTietXuatHang
GO
/****** Object:  View [dbo].[view_HangHoa]    Script Date: 11/16/2022 11:23:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[view_HangHoa]
AS
SELECT        MaHang, TenHang, Gia, SoLuongTonKho
FROM            dbo.HangHoa
GO
/****** Object:  Table [dbo].[LoaiHang]    Script Date: 11/16/2022 11:23:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LoaiHang](
	[MaLoaiHang] [char](20) NOT NULL,
	[TenLoaiHang] [nvarchar](20) NULL,
 CONSTRAINT [pk_MaLoaiHang] PRIMARY KEY CLUSTERED 
(
	[MaLoaiHang] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[view_LoaiHang]    Script Date: 11/16/2022 11:23:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[view_LoaiHang] as
select MaLoaiHang, TenLoaiHang
from LoaiHang
GO
/****** Object:  Table [dbo].[NhaCungCap]    Script Date: 11/16/2022 11:23:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NhaCungCap](
	[MaNhaCungCap] [char](20) NOT NULL,
	[TenNhaCungCap] [nvarchar](30) NULL,
	[DiaChi] [nvarchar](50) NULL,
	[SoDienThoai] [char](13) NULL,
 CONSTRAINT [pk_MaNhaCungCap] PRIMARY KEY CLUSTERED 
(
	[MaNhaCungCap] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[view_NhaCungCap]    Script Date: 11/16/2022 11:23:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[view_NhaCungCap] as
select MaNhaCungCap, TenNhaCungCap, DiaChi, SoDienThoai
from NhaCungCap
GO
/****** Object:  Table [dbo].[HangLoi]    Script Date: 11/16/2022 11:23:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HangLoi](
	[MaHang] [char](20) NULL,
	[TenLoi] [nvarchar](50) NULL,
	[SoLuong] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TaiKhoan]    Script Date: 11/16/2022 11:23:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create view [dbo].[view_HangLoi] as
select MaHang, TenLoi, SoLuong
from HangLoi
GO
CREATE TABLE [dbo].[TaiKhoan](
	[TenDangNhap] [char](20) NOT NULL,
	[MatKhau] [char](25) NULL,
	[PhanLoai] [char](6) NULL,
 CONSTRAINT [pk_TenDangNhap] PRIMARY KEY CLUSTERED 
(
	[TenDangNhap] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[ChiTietNhapHang] ([MaNhapHang], [MaHang], [SoLuong], [NgayNhap], [MaNhaCungCap]) VALUES (N'NH01                ', N'HH04                ', 12, CAST(N'2022-09-13' AS Date), N'NCC02               ')
INSERT [dbo].[ChiTietNhapHang] ([MaNhapHang], [MaHang], [SoLuong], [NgayNhap], [MaNhaCungCap]) VALUES (N'NH02                ', N'HH05                ', 21, CAST(N'2022-09-13' AS Date), N'NCC02               ')
INSERT [dbo].[ChiTietNhapHang] ([MaNhapHang], [MaHang], [SoLuong], [NgayNhap], [MaNhaCungCap]) VALUES (N'NH03                ', N'HH06                ', 16, CAST(N'2022-09-13' AS Date), N'NCC02               ')
INSERT [dbo].[ChiTietNhapHang] ([MaNhapHang], [MaHang], [SoLuong], [NgayNhap], [MaNhaCungCap]) VALUES (N'NH04                ', N'HH01                ', 2, CAST(N'2022-09-13' AS Date), N'NCC04               ')
INSERT [dbo].[ChiTietNhapHang] ([MaNhapHang], [MaHang], [SoLuong], [NgayNhap], [MaNhaCungCap]) VALUES (N'NH05                ', N'HH02                ', 3, CAST(N'2022-09-13' AS Date), N'NCC04               ')
INSERT [dbo].[ChiTietNhapHang] ([MaNhapHang], [MaHang], [SoLuong], [NgayNhap], [MaNhaCungCap]) VALUES (N'NH06                ', N'HH07                ', 5, CAST(N'2022-09-13' AS Date), N'NCC01               ')
INSERT [dbo].[ChiTietNhapHang] ([MaNhapHang], [MaHang], [SoLuong], [NgayNhap], [MaNhaCungCap]) VALUES (N'NH07                ', N'HH10                ', 20, CAST(N'2022-09-13' AS Date), N'NCC02               ')
INSERT [dbo].[ChiTietNhapHang] ([MaNhapHang], [MaHang], [SoLuong], [NgayNhap], [MaNhaCungCap]) VALUES (N'NH08                ', N'HH11                ', 10, CAST(N'2022-09-13' AS Date), N'NCC03               ')
INSERT [dbo].[ChiTietNhapHang] ([MaNhapHang], [MaHang], [SoLuong], [NgayNhap], [MaNhaCungCap]) VALUES (N'NH09                ', N'HH13                ', 10, CAST(N'2022-09-13' AS Date), N'NCC02               ')
INSERT [dbo].[ChiTietNhapHang] ([MaNhapHang], [MaHang], [SoLuong], [NgayNhap], [MaNhaCungCap]) VALUES (N'NH10                ', N'HH15                ', 15, CAST(N'2022-09-13' AS Date), N'NCC05               ')
INSERT [dbo].[ChiTietNhapHang] ([MaNhapHang], [MaHang], [SoLuong], [NgayNhap], [MaNhaCungCap]) VALUES (N'NH11                ', N'HH18                ', 13, CAST(N'2022-09-13' AS Date), N'NCC07               ')
INSERT [dbo].[ChiTietNhapHang] ([MaNhapHang], [MaHang], [SoLuong], [NgayNhap], [MaNhaCungCap]) VALUES (N'NH12                ', N'HH19                ', 20, CAST(N'2022-09-13' AS Date), N'NCC07               ')
INSERT [dbo].[ChiTietNhapHang] ([MaNhapHang], [MaHang], [SoLuong], [NgayNhap], [MaNhaCungCap]) VALUES (N'NH13                ', N'HH21                ', 25, CAST(N'2022-09-13' AS Date), N'NCC05               ')
INSERT [dbo].[ChiTietNhapHang] ([MaNhapHang], [MaHang], [SoLuong], [NgayNhap], [MaNhaCungCap]) VALUES (N'NH14                ', N'HH24                ', 30, CAST(N'2022-09-13' AS Date), N'NCC08               ')
INSERT [dbo].[ChiTietNhapHang] ([MaNhapHang], [MaHang], [SoLuong], [NgayNhap], [MaNhaCungCap]) VALUES (N'NH15                ', N'HH26                ', 34, CAST(N'2022-09-13' AS Date), N'NCC08               ')
INSERT [dbo].[ChiTietNhapHang] ([MaNhapHang], [MaHang], [SoLuong], [NgayNhap], [MaNhaCungCap]) VALUES (N'NH16                ', N'HH01                ', 30, CAST(N'2022-11-15' AS Date), N'NCC04               ')
INSERT [dbo].[ChiTietNhapHang] ([MaNhapHang], [MaHang], [SoLuong], [NgayNhap], [MaNhaCungCap]) VALUES (N'NH17                ', N'HH11                ', 15, CAST(N'2022-11-15' AS Date), N'NCC04               ')
GO
INSERT [dbo].[ChiTietXuatHang] ([MaXuatHang], [MaHang], [SoLuong], [NgayXuat]) VALUES (N'XH01                ', N'HH22                ', 16, CAST(N'2022-09-14' AS Date))
INSERT [dbo].[ChiTietXuatHang] ([MaXuatHang], [MaHang], [SoLuong], [NgayXuat]) VALUES (N'XH02                ', N'HH19                ', 8, CAST(N'2022-09-14' AS Date))
INSERT [dbo].[ChiTietXuatHang] ([MaXuatHang], [MaHang], [SoLuong], [NgayXuat]) VALUES (N'XH03                ', N'HH17                ', 5, CAST(N'2022-09-14' AS Date))
INSERT [dbo].[ChiTietXuatHang] ([MaXuatHang], [MaHang], [SoLuong], [NgayXuat]) VALUES (N'XH04                ', N'HH16                ', 50, CAST(N'2022-09-14' AS Date))
INSERT [dbo].[ChiTietXuatHang] ([MaXuatHang], [MaHang], [SoLuong], [NgayXuat]) VALUES (N'XH05                ', N'HH28                ', 15, CAST(N'2022-09-14' AS Date))
INSERT [dbo].[ChiTietXuatHang] ([MaXuatHang], [MaHang], [SoLuong], [NgayXuat]) VALUES (N'XH06                ', N'HH29                ', 23, CAST(N'2022-09-14' AS Date))
INSERT [dbo].[ChiTietXuatHang] ([MaXuatHang], [MaHang], [SoLuong], [NgayXuat]) VALUES (N'XH07                ', N'HH05                ', 15, CAST(N'2022-09-14' AS Date))
INSERT [dbo].[ChiTietXuatHang] ([MaXuatHang], [MaHang], [SoLuong], [NgayXuat]) VALUES (N'XH08                ', N'HH07                ', 9, CAST(N'2022-09-14' AS Date))
GO
INSERT [dbo].[HangHoa] ([MaHang], [TenHang], [Gia], [SoLuongTonKho], [MaLoaiHang]) VALUES (N'HH01                ', N'Máy hút bụi Samsung', 500000, 90, N'LH01                ')
INSERT [dbo].[HangHoa] ([MaHang], [TenHang], [Gia], [SoLuongTonKho], [MaLoaiHang]) VALUES (N'HH02                ', N'Máy giặt Aqua', 4000000, 4, N'LH01                ')
INSERT [dbo].[HangHoa] ([MaHang], [TenHang], [Gia], [SoLuongTonKho], [MaLoaiHang]) VALUES (N'HH03                ', N'Tủ lạnh Toshiba', 6000000, 6, N'LH01                ')
INSERT [dbo].[HangHoa] ([MaHang], [TenHang], [Gia], [SoLuongTonKho], [MaLoaiHang]) VALUES (N'HH04                ', N'Đùi gà', 40000, 30, N'LH10                ')
INSERT [dbo].[HangHoa] ([MaHang], [TenHang], [Gia], [SoLuongTonKho], [MaLoaiHang]) VALUES (N'HH05                ', N'Thịt đùi heo', 50000, 10, N'LH10                ')
INSERT [dbo].[HangHoa] ([MaHang], [TenHang], [Gia], [SoLuongTonKho], [MaLoaiHang]) VALUES (N'HH06                ', N'Cá thu', 45000, 9, N'LH02                ')
INSERT [dbo].[HangHoa] ([MaHang], [TenHang], [Gia], [SoLuongTonKho], [MaLoaiHang]) VALUES (N'HH07                ', N'Mì tôm Hảo Hảo', 4000, 85, N'LH04                ')
INSERT [dbo].[HangHoa] ([MaHang], [TenHang], [Gia], [SoLuongTonKho], [MaLoaiHang]) VALUES (N'HH08                ', N'Kem Kinh Đô', 7000, 10, N'LH02                ')
INSERT [dbo].[HangHoa] ([MaHang], [TenHang], [Gia], [SoLuongTonKho], [MaLoaiHang]) VALUES (N'HH09                ', N'Cháo Gấu Đỏ', 4500, 30, N'LH03                ')
INSERT [dbo].[HangHoa] ([MaHang], [TenHang], [Gia], [SoLuongTonKho], [MaLoaiHang]) VALUES (N'HH10                ', N'Táo Mỹ', 40000, 20, N'LH10                ')
INSERT [dbo].[HangHoa] ([MaHang], [TenHang], [Gia], [SoLuongTonKho], [MaLoaiHang]) VALUES (N'HH11                ', N'Dưa hấu đỏ', 15000, 25, N'LH10                ')
INSERT [dbo].[HangHoa] ([MaHang], [TenHang], [Gia], [SoLuongTonKho], [MaLoaiHang]) VALUES (N'HH12                ', N'Cam', 20000, 15, N'LH10                ')
INSERT [dbo].[HangHoa] ([MaHang], [TenHang], [Gia], [SoLuongTonKho], [MaLoaiHang]) VALUES (N'HH13                ', N'Rau xà lách', 30000, 12, N'LH10                ')
INSERT [dbo].[HangHoa] ([MaHang], [TenHang], [Gia], [SoLuongTonKho], [MaLoaiHang]) VALUES (N'HH14                ', N'Cà rốt', 15000, 8, N'LH10                ')
INSERT [dbo].[HangHoa] ([MaHang], [TenHang], [Gia], [SoLuongTonKho], [MaLoaiHang]) VALUES (N'HH15                ', N'Bột giặt Omo', 50000, 17, N'LH05                ')
INSERT [dbo].[HangHoa] ([MaHang], [TenHang], [Gia], [SoLuongTonKho], [MaLoaiHang]) VALUES (N'HH16                ', N'Nước xả Izi Home', 40000, 6, N'LH05                ')
INSERT [dbo].[HangHoa] ([MaHang], [TenHang], [Gia], [SoLuongTonKho], [MaLoaiHang]) VALUES (N'HH17                ', N'Nước rửa chén SunLight', 22000, 12, N'LH05                ')
INSERT [dbo].[HangHoa] ([MaHang], [TenHang], [Gia], [SoLuongTonKho], [MaLoaiHang]) VALUES (N'HH18                ', N'Áo thun Louis Vuitton', 100000, 25, N'LH06                ')
INSERT [dbo].[HangHoa] ([MaHang], [TenHang], [Gia], [SoLuongTonKho], [MaLoaiHang]) VALUES (N'HH19                ', N'Quần Jean Calvin Klein', 300000, 23, N'LH06                ')
INSERT [dbo].[HangHoa] ([MaHang], [TenHang], [Gia], [SoLuongTonKho], [MaLoaiHang]) VALUES (N'HH20                ', N'Túi xách Gucci', 200000, 13, N'LH06                ')
INSERT [dbo].[HangHoa] ([MaHang], [TenHang], [Gia], [SoLuongTonKho], [MaLoaiHang]) VALUES (N'HH21                ', N'Sữa rửa mặt Nivia Men', 70000, 18, N'LH05                ')
INSERT [dbo].[HangHoa] ([MaHang], [TenHang], [Gia], [SoLuongTonKho], [MaLoaiHang]) VALUES (N'HH22                ', N'Bàn chải đánh răng P/S', 30000, 18, N'LH07                ')
INSERT [dbo].[HangHoa] ([MaHang], [TenHang], [Gia], [SoLuongTonKho], [MaLoaiHang]) VALUES (N'HH23                ', N'Dao cạo râu Gillette', 32000, 22, N'LH07                ')
INSERT [dbo].[HangHoa] ([MaHang], [TenHang], [Gia], [SoLuongTonKho], [MaLoaiHang]) VALUES (N'HH24                ', N'Pepsi', 8000, 35, N'LH08                ')
INSERT [dbo].[HangHoa] ([MaHang], [TenHang], [Gia], [SoLuongTonKho], [MaLoaiHang]) VALUES (N'HH25                ', N'Nước khoáng Lavie', 5000, 24, N'LH08                ')
INSERT [dbo].[HangHoa] ([MaHang], [TenHang], [Gia], [SoLuongTonKho], [MaLoaiHang]) VALUES (N'HH26                ', N'Sting dau', 10000, 40, N'LH08                ')
INSERT [dbo].[HangHoa] ([MaHang], [TenHang], [Gia], [SoLuongTonKho], [MaLoaiHang]) VALUES (N'HH27                ', N'Kẹo mút Chupa Chups', 3000, 29, N'LH09                ')
INSERT [dbo].[HangHoa] ([MaHang], [TenHang], [Gia], [SoLuongTonKho], [MaLoaiHang]) VALUES (N'HH28                ', N'Bánh quy Cosy', 15000, 10, N'LH09                ')
INSERT [dbo].[HangHoa] ([MaHang], [TenHang], [Gia], [SoLuongTonKho], [MaLoaiHang]) VALUES (N'HH29                ', N'Snack Lays sườn nướng', 21000, 17, N'LH09                ')
GO
INSERT [dbo].[HangLoi] ([MaHang], [TenLoi], [SoLuong]) VALUES (N'HH04                ', N'Hết hạn sử dụng', 2)
INSERT [dbo].[HangLoi] ([MaHang], [TenLoi], [SoLuong]) VALUES (N'HH28                ', N'Hết hạn sử dụng', 5)
INSERT [dbo].[HangLoi] ([MaHang], [TenLoi], [SoLuong]) VALUES (N'HH09                ', N'Hết hạn sử dụng', 10)
INSERT [dbo].[HangLoi] ([MaHang], [TenLoi], [SoLuong]) VALUES (N'HH20                ', N'Het HSD', 1)
GO
INSERT [dbo].[LoaiHang] ([MaLoaiHang], [TenLoaiHang]) VALUES (N'LH09                ', N'Bánh kẹo ngọt')
INSERT [dbo].[LoaiHang] ([MaLoaiHang], [TenLoaiHang]) VALUES (N'LH03                ', N'Đồ ăn nhanh')
INSERT [dbo].[LoaiHang] ([MaLoaiHang], [TenLoaiHang]) VALUES (N'LH07                ', N'Đồ dùng cá nhân')
INSERT [dbo].[LoaiHang] ([MaLoaiHang], [TenLoaiHang]) VALUES (N'LH01                ', N'Đồ gia dụng')
INSERT [dbo].[LoaiHang] ([MaLoaiHang], [TenLoaiHang]) VALUES (N'LH08                ', N'Đồ uống')
INSERT [dbo].[LoaiHang] ([MaLoaiHang], [TenLoaiHang]) VALUES (N'LH05                ', N'Hóa phẩm')
INSERT [dbo].[LoaiHang] ([MaLoaiHang], [TenLoaiHang]) VALUES (N'LH06                ', N'Thời trang')
INSERT [dbo].[LoaiHang] ([MaLoaiHang], [TenLoaiHang]) VALUES (N'LH02                ', N'Thực phẩm đông lạnh')
INSERT [dbo].[LoaiHang] ([MaLoaiHang], [TenLoaiHang]) VALUES (N'LH04                ', N'Thực phẩm khô')
INSERT [dbo].[LoaiHang] ([MaLoaiHang], [TenLoaiHang]) VALUES (N'LH10                ', N'Thực phẩm tươi sống')
GO
INSERT [dbo].[NhaCungCap] ([MaNhaCungCap], [TenNhaCungCap], [DiaChi], [SoDienThoai]) VALUES (N'NCC01               ', N'Công ty Ðồ An Liền', N'189 Phạm Văn Ðồng,Gò Vấp,TP.HCM', N'0654654845   ')
INSERT [dbo].[NhaCungCap] ([MaNhaCungCap], [TenNhaCungCap], [DiaChi], [SoDienThoai]) VALUES (N'NCC02               ', N'Công ty Nông thủy sản', N'232 Kha Vạn Cân,TP.Thủ Đức', N'0852728362   ')
INSERT [dbo].[NhaCungCap] ([MaNhaCungCap], [TenNhaCungCap], [DiaChi], [SoDienThoai]) VALUES (N'NCC03               ', N'Công ty Bánh Kẹo', N'440 Kha Vạn Cân,TP.Thủ Đức', N'0999728362   ')
INSERT [dbo].[NhaCungCap] ([MaNhaCungCap], [TenNhaCungCap], [DiaChi], [SoDienThoai]) VALUES (N'NCC04               ', N'Công ty Điện dụng', N'199 Phạm Văn Đồng,Gò Vấp,TP.HCM', N'015243628    ')
INSERT [dbo].[NhaCungCap] ([MaNhaCungCap], [TenNhaCungCap], [DiaChi], [SoDienThoai]) VALUES (N'NCC05               ', N'Công ty Hóa phẩm', N'189 Phan Văn Trị,Gò Vấp,TP.HCM', N'0977947944   ')
INSERT [dbo].[NhaCungCap] ([MaNhaCungCap], [TenNhaCungCap], [DiaChi], [SoDienThoai]) VALUES (N'NCC06               ', N'Công ty Đồ Cá Nhân', N'123 Cộng Hòa,Tân Bình,TP.HCM', N'0966283622   ')
INSERT [dbo].[NhaCungCap] ([MaNhaCungCap], [TenNhaCungCap], [DiaChi], [SoDienThoai]) VALUES (N'NCC07               ', N'Công ty Thời Trang', N'22 Hoàng Diệu 2,Tp.Thủ Đức', N'083678282    ')
INSERT [dbo].[NhaCungCap] ([MaNhaCungCap], [TenNhaCungCap], [DiaChi], [SoDienThoai]) VALUES (N'NCC08               ', N'Công ty Nước giải khát', N'29/2 đường số 5,Tăng Nhơn Phú B,Tp.Thủ Đức', N'0638763822   ')
GO
INSERT [dbo].[TaiKhoan] ([TenDangNhap], [MatKhau], [PhanLoai]) VALUES (N'admin               ', N'123                      ', N'admin ')
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__HangHoa__E6C9BFA8E2AB5034]    Script Date: 11/16/2022 11:23:06 PM ******/
ALTER TABLE [dbo].[HangHoa] ADD UNIQUE NONCLUSTERED 
(
	[TenHang] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__LoaiHang__E74DCF9263562E58]    Script Date: 11/16/2022 11:23:06 PM ******/
ALTER TABLE [dbo].[LoaiHang] ADD UNIQUE NONCLUSTERED 
(
	[TenLoaiHang] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__NhaCungC__0389B7BDE1DAC473]    Script Date: 11/16/2022 11:23:06 PM ******/
ALTER TABLE [dbo].[NhaCungCap] ADD UNIQUE NONCLUSTERED 
(
	[SoDienThoai] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[ChiTietNhapHang]  WITH CHECK ADD FOREIGN KEY([MaHang])
REFERENCES [dbo].[HangHoa] ([MaHang])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ChiTietNhapHang]  WITH CHECK ADD  CONSTRAINT [fk_MaNhaCungCap] FOREIGN KEY([MaNhaCungCap])
REFERENCES [dbo].[NhaCungCap] ([MaNhaCungCap])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ChiTietNhapHang] CHECK CONSTRAINT [fk_MaNhaCungCap]
GO
ALTER TABLE [dbo].[ChiTietXuatHang]  WITH CHECK ADD  CONSTRAINT [fk_MaHang_ChiTietXuatHang] FOREIGN KEY([MaHang])
REFERENCES [dbo].[HangHoa] ([MaHang])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ChiTietXuatHang] CHECK CONSTRAINT [fk_MaHang_ChiTietXuatHang]
GO
ALTER TABLE [dbo].[HangHoa]  WITH CHECK ADD  CONSTRAINT [fk_MaLoaiHang] FOREIGN KEY([MaLoaiHang])
REFERENCES [dbo].[LoaiHang] ([MaLoaiHang])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[HangHoa] CHECK CONSTRAINT [fk_MaLoaiHang]
GO
ALTER TABLE [dbo].[HangLoi]  WITH CHECK ADD  CONSTRAINT [fk_MaHang_HangLoi] FOREIGN KEY([MaHang])
REFERENCES [dbo].[HangHoa] ([MaHang])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[HangLoi] CHECK CONSTRAINT [fk_MaHang_HangLoi]
GO
ALTER TABLE [dbo].[ChiTietNhapHang]  WITH CHECK ADD  CONSTRAINT [ck_SoLuong_NhapHang] CHECK  (([SoLuong]>(0)))
GO
ALTER TABLE [dbo].[ChiTietNhapHang] CHECK CONSTRAINT [ck_SoLuong_NhapHang]
GO
ALTER TABLE [dbo].[ChiTietXuatHang]  WITH CHECK ADD  CONSTRAINT [ck_SoLuong_XuatHang] CHECK  (([SoLuong]>(0)))
GO
ALTER TABLE [dbo].[ChiTietXuatHang] CHECK CONSTRAINT [ck_SoLuong_XuatHang]
GO
ALTER TABLE [dbo].[HangHoa]  WITH CHECK ADD  CONSTRAINT [ck_Gia_HangHoa] CHECK  (([Gia]>(0)))
GO
ALTER TABLE [dbo].[HangHoa] CHECK CONSTRAINT [ck_Gia_HangHoa]
GO
ALTER TABLE [dbo].[HangHoa]  WITH CHECK ADD  CONSTRAINT [ck_SoLuongTonKho_HangHoa] CHECK  (([SoLuongTonkho]>(0)))
GO
ALTER TABLE [dbo].[HangHoa] CHECK CONSTRAINT [ck_SoLuongTonKho_HangHoa]
GO
ALTER TABLE [dbo].[HangLoi]  WITH CHECK ADD  CONSTRAINT [ck_SoLuong_HangLoi] CHECK  (([SoLuong]>(0)))
GO
ALTER TABLE [dbo].[HangLoi] CHECK CONSTRAINT [ck_SoLuong_HangLoi]
GO
/****** Object:  StoredProcedure [dbo].[DeleteRowOfTable_ChiTietNhapHang]    Script Date: 11/16/2022 11:23:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


------------------------------------------------------------------------------------------------------

create proc [dbo].[DeleteRowOfTable_ChiTietNhapHang](@KhoaChinh char(20)) as
begin
	delete from ChiTietNhapHang where MaNhapHang=@KhoaChinh
end
GO
/****** Object:  StoredProcedure [dbo].[DeleteRowOfTable_ChiTietXuatHang]    Script Date: 11/16/2022 11:23:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------------------------------------------------------------------------

create proc [dbo].[DeleteRowOfTable_ChiTietXuatHang](@KhoaChinh char(20)) as
begin
	delete from ChiTietXuatHang where MaXuatHang=@KhoaChinh
end
GO
/****** Object:  StoredProcedure [dbo].[DeleteRowOfTable_HangHoa]    Script Date: 11/16/2022 11:23:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------------------------------------------------------------------------

create proc [dbo].[DeleteRowOfTable_HangHoa](@KhoaChinh char(20)) as
begin
	delete from HangHoa where MaHang=@KhoaChinh
end
GO
/****** Object:  StoredProcedure [dbo].[DeleteRowOfTable_HangLoi]    Script Date: 11/16/2022 11:23:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------------------------------------------------------------------------

create proc [dbo].[DeleteRowOfTable_HangLoi](@KhoaChinh char(20)) as
begin
	delete from HangLoi where MaHang=@KhoaChinh
end
GO
/****** Object:  StoredProcedure [dbo].[DeleteRowOfTable_LoaiHang]    Script Date: 11/16/2022 11:23:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------------------------------------------------------------------------

create proc [dbo].[DeleteRowOfTable_LoaiHang](@KhoaChinh char(20)) as
begin
	delete from LoaiHang where MaLoaiHang=@KhoaChinh
end
GO
/****** Object:  StoredProcedure [dbo].[DeleteRowOfTable_NhaCungCap]    Script Date: 11/16/2022 11:23:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------------------------------------------------------------------------

create proc [dbo].[DeleteRowOfTable_NhaCungCap](@KhoaChinh char(20)) as
begin
	delete from NhaCungCap where MaNhaCungCap=@KhoaChinh
end
GO
/****** Object:  StoredProcedure [dbo].[DeleteRowOfTable_TaiKhoan]    Script Date: 11/16/2022 11:23:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------------------------------------------------------------------------

create proc [dbo].[DeleteRowOfTable_TaiKhoan](@KhoaChinh char(20)) as
begin
	delete from TaiKhoan where TenDangNhap=@KhoaChinh
end
GO
/****** Object:  StoredProcedure [dbo].[insert_hanghoa]    Script Date: 11/16/2022 11:23:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[insert_hanghoa](@mahang char(20), @tenhang nvarchar(30), @gia real, @soluongtonkho int, @maloaihang char(20)) as
begin
	begin tran
	save transaction tran_insert_HangHoa
	insert into HangHoa values (@mahang, @tenhang, @gia, @soluongtonkho, @maloaihang)
	commit
end
GO
/****** Object:  StoredProcedure [dbo].[insert_hangloi]    Script Date: 11/16/2022 11:23:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[insert_hangloi](@mahang char(20), @tenloi nvarchar(50), @soluong int) as
begin
	begin tran
	save transaction tran_insert_HangLoi
	insert into HangLoi values (@mahang, @tenloi, @soluong)
	commit
end
GO
/****** Object:  StoredProcedure [dbo].[insert_loaihang]    Script Date: 11/16/2022 11:23:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[insert_loaihang](@maloaihang char(20), @tenloaihang nvarchar(30)) as
begin
	begin tran
	save transaction tran_insert_LoaiHang
	insert into LoaiHang values (@maloaihang, @tenloaihang)
	commit
end
GO
/****** Object:  StoredProcedure [dbo].[insert_nhacungcap]    Script Date: 11/16/2022 11:23:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[insert_nhacungcap](@manhacungcap char(20), @tennhacungcap nvarchar(30), @diachi nvarchar(50), @sodienthoai char(13)) as
begin
	begin tran
	save transaction tran_insert_NhaCungCap
	insert into NhaCungCap values (@manhacungcap, @tennhacungcap, @diachi, @sodienthoai)
	commit
end
GO
/****** Object:  StoredProcedure [dbo].[insert_nhaphang]    Script Date: 11/16/2022 11:23:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[insert_nhaphang](@manhaphang char(20), @mahang char(20), @soluong int, @ngaynhap date, @manhacungcap char(20)) as
begin
	begin tran
	save transaction tran_insert_ChiTietNhapHang
	insert into ChiTietNhapHang values (@manhaphang, @mahang, @soluong, @ngaynhap, @manhacungcap)
	commit
end
GO
/****** Object:  StoredProcedure [dbo].[insert_xuathang]    Script Date: 11/16/2022 11:23:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[insert_xuathang](@maxuathang char(20), @mahang char(20), @soluong int, @ngayxuat date) as
begin
	begin tran
	save transaction tran_insert_ChiTietXuatHang
	insert into ChiTietXuatHang values (@maxuathang, @mahang, @soluong, @ngayxuat)
	commit
end
GO
/****** Object:  StoredProcedure [dbo].[sp_create_user]    Script Date: 11/16/2022 11:23:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[sp_create_user](
	@username sysname,
	@password sysname
)
AS
BEGIN
	DECLARE @addlogin char(50) = 'CREATE LOGIN ' + QUOTENAME(@username) + 'WITH PASSWORD = ' + QUOTENAME(@password, '''')
	EXEC (@addlogin)
	DECLARE @adduser char(50) = 'CREATE USER ' + QUOTENAME(@username) + ' FOR LOGIN ' + QUOTENAME(@username)
	EXEC (@adduser)
 
	EXEC sp_privileges_user @username

	Insert Into TaiKhoan Values(
		@username,
		@password,
		'user'
	)
END
GO
/****** Object:  StoredProcedure [dbo].[sp_privileges_user]    Script Date: 11/16/2022 11:23:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROC [dbo].[sp_privileges_user](
	@Username sysname
)
AS
BEGIN
	DECLARE @query varchar(100) = 'GRANT SELECT ON [view_HangHoa] TO ' + QUOTENAME(@Username)
	EXEC (@query)
	
	SET @query = 'GRANT SELECT ON [view_LoaiHang] TO ' + QUOTENAME(@Username)
	EXEC (@query)

	SET @query = 'GRANT SELECT ON [view_NhaCungCap] TO ' + QUOTENAME(@Username)
	EXEC (@query)
	
	SET @query = 'GRANT SELECT ON [view_ChiTietNhapHang] TO ' + QUOTENAME(@Username)
	EXEC (@query)
	
	SET @query = 'GRANT SELECT ON [view_ChiTietXuatHang] TO ' + QUOTENAME(@Username)
	EXEC (@query)
END
GO
/****** Object:  StoredProcedure [dbo].[update_ChiTietNhapHang]    Script Date: 11/16/2022 11:23:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[update_ChiTietNhapHang] (@manhaphang char(20), @mahang char(20)= null, @soluong int = null, @ngaynhap date = null, @manhacungcap char(20) = null) as
begin
	declare @query nvarchar(200) = 'Update ChiTietNhapHang set '
	declare @count bit = 0
	if (@mahang != '')
		begin
			set @query = @query + 'MaHang = ' +QUOTENAME(@mahang, '''') 
			set @count = 1
		end
	
	if (@soluong != '')
		begin
			if (@count = 1)
				set @query = @query + ', '
			set @query = @query + 'SoLuong = ' +QUOTENAME(@soluong, '''') 
			set @count = 1
		end
	if (@ngaynhap != '')
		begin
			if (@count = 1)
				set @query = @query + ', '
			set @query = @query + 'NgayNhap = ' +QUOTENAME(@ngaynhap, '''') 
			set @count = 1
		end
	if (@manhacungcap != '')
		begin
			if (@count = 1)
				set @query = @query + ', '
			set @query = @query + 'MaNhaCungCap = ' +QUOTENAME(@manhacungcap, '''') 
			set @count = 1
		end
	set @query = @query + ' where MaNhapHang = ' +QUOTENAME(@manhaphang, '''')
	begin tran
	save transaction tran_update_ChiTietNhapHang
	exec(@query)
	commit
end
GO
/****** Object:  StoredProcedure [dbo].[update_ChiTietXuatHang]    Script Date: 11/16/2022 11:23:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[update_ChiTietXuatHang] (@maxuathang char(20), @mahang char(20)= null, @soluong int = null, @ngayxuat date = null) as
begin
	declare @query nvarchar(200) = 'Update ChiTietXuatHang set '
	declare @count bit = 0
	if (@mahang != '')
		begin
			set @query = @query + 'MaHang = ' +QUOTENAME(@mahang, '''') 
			set @count = 1
		end
	
	if (@soluong != '')
		begin
			if (@count = 1)
				set @query = @query + ', '
			set @query = @query + 'SoLuong = ' +QUOTENAME(@soluong, '''') 
			set @count = 1
		end
	if (@ngayxuat != '')
		begin
			if (@count = 1)
				set @query = @query + ', '
			set @query = @query + 'NgayXuat = ' +QUOTENAME(@ngayxuat, '''') 
			set @count = 1
		end
	set @query = @query + ' where MaXuatHang = ' +QUOTENAME(@maxuathang, '''')
	begin tran
	save transaction tran_update_ChiTietXuatHang
	exec(@query)
	commit
end
GO
/****** Object:  StoredProcedure [dbo].[update_HangHoa]    Script Date: 11/16/2022 11:23:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[update_HangHoa] (@mahang char(20), @tenhang nvarchar(30)= null, @gia real = null, @soluongtonkho int = null, @maloaihang char(20) = null) as
begin
	declare @query nvarchar(200) = 'Update HangHoa set '
	declare @count bit = 0
	if (@tenhang != '')
		begin
			set @query = @query + 'TenHang = ' +QUOTENAME(@tenhang, '''') 
			set @count = 1
		end
	
	if (@gia != '')
		begin
			if (@count =1)
				set @query = @query + ', '
			set @query = @query + 'Gia = ' +QUOTENAME(@gia, '''')
			set @count = 1
		end
	
	if (@soluongtonkho != '')
		begin
			if (@count = 1)
				set @query = @query + ', '
			set @query = @query + 'SoLuongTonKho = ' +QUOTENAME(@soluongtonkho, '''') 
			set @count = 1
		end
	
	if (@maloaihang != '')
		begin
			if (@count =1)
				set @query = @query + ', '
			set @query = @query + 'MaLoaiHang = ' + QUOTENAME(trim(@maloaihang),'''')
			set @count = 1
		end
	set @query = @query + ' where MaHang = ' +QUOTENAME(@mahang, '''')
	begin tran
	save transaction tran_update_HangHoa
	exec(@query)
	commit
end
GO
/****** Object:  StoredProcedure [dbo].[update_HangLoi]    Script Date: 11/16/2022 11:23:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[update_HangLoi] (@mahang char(20), @tenloi nvarchar(50)= null, @soluong int = null) as
begin
	declare @query nvarchar(100) = 'Update HangLoi set '
	declare @count bit = 0
	if (@tenloi != '')
		begin
			set @query = @query + 'TenLoi = ' +QUOTENAME(@tenloi, '''') 
			set @count = 1
		end
	
	if (@soluong != '')
		begin
			if (@count = 1)
				set @query = @query + ', '
			set @query = @query + 'SoLuong = ' +QUOTENAME(@soluong, '''') 
			set @count = 1
		end
	set @query = @query + ' where MaHang = ' +QUOTENAME(@mahang, '''')
	begin tran
	save transaction tran_update_HangLoi
	exec(@query)
	commit
end
GO
/****** Object:  StoredProcedure [dbo].[update_LoaiHang]    Script Date: 11/16/2022 11:23:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[update_LoaiHang] (@maloaihang char(20), @tenloaihang nvarchar(20)= null) as
begin
	declare @query nvarchar(100) = 'Update LoaiHang set '
	declare @count bit = 0
	if (@tenloaihang != '')
		begin
			set @query = @query + 'TenLoaiHang = ' +QUOTENAME(@tenloaihang, '''') 
		end
	set @query = @query + ' where MaLoaiHang = ' +QUOTENAME(@maloaihang, '''')
	begin tran
	save transaction tran_update_LoaiHang
	exec(@query)
	commit
end
GO
/****** Object:  StoredProcedure [dbo].[update_NhaCungCap]    Script Date: 11/16/2022 11:23:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[update_NhaCungCap] (@manhacungcap char(20), @tennhacungcap nvarchar(30)= null, @diachi nvarchar(50) = null, @sodienthoai char(13) = null) as
begin
	declare @query nvarchar(200) = 'Update NhaCungCap set '
	declare @count bit = 0
	if (@tennhacungcap != '')
		begin
			set @query = @query + 'TenNhaCungCap = ' +QUOTENAME(@tennhacungcap, '''') 
			set @count = 1
		end
	
	if (@diachi != '')
		begin
			if (@count = 1)
				set @query = @query + ', '
			set @query = @query + 'DiaChi = ' +QUOTENAME(@diachi, '''') 
			set @count = 1
		end
	if (@sodienthoai != '')
		begin
			if (@count = 1)
				set @query = @query + ', '
			set @query = @query + 'SoDienThoai = ' +QUOTENAME(@sodienthoai, '''') 
			set @count = 1
		end
	set @query = @query + ' where MaNhaCungCap = ' +QUOTENAME(@manhacungcap, '''')
	begin tran
	save transaction tran_update_NhaCungCap
	exec(@query)
	commit
end
GO
/****** Object:  Trigger [dbo].[DeleteNhapHang]    Script Date: 11/16/2022 11:23:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE trigger [dbo].[DeleteNhapHang] on  [dbo].[ChiTietNhapHang] 
for delete as 
declare @SoLuong real,@MaHang char(20)
	select @SoLuong=chen.SoLuong from deleted chen
	select @MaHang=chen.MaHang from deleted chen
begin
	if(@SoLuong>0)
		begin
		update HangHoa set SoLuongTonKho-=@SoLuong where MaHang=@MaHang
		print('Da cap nhat thanh cong')
		end
	else
		print(N'Hang hien da het')
end
GO
ALTER TABLE [dbo].[ChiTietNhapHang] ENABLE TRIGGER [DeleteNhapHang]
GO
/****** Object:  Trigger [dbo].[KiemTraNhapHang]    Script Date: 11/16/2022 11:23:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create trigger [dbo].[KiemTraNhapHang] on  [dbo].[ChiTietNhapHang] 
for insert as 
declare @SoLuong real,@MaHang char(20)
	select @SoLuong=chen.SoLuong from inserted chen
	select @MaHang=chen.MaHang from inserted chen
begin
	if(@SoLuong>0)
		begin
		update HangHoa set SoLuongTonKho+=@SoLuong where MaHang=@MaHang
		print('Da cap nhat thanh cong')
		end
	else
		print(N'Hang hien da het')
end
GO
ALTER TABLE [dbo].[ChiTietNhapHang] ENABLE TRIGGER [KiemTraNhapHang]
GO
/****** Object:  Trigger [dbo].[UpdateNhapHang]    Script Date: 11/16/2022 11:23:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE trigger [dbo].[UpdateNhapHang] on [dbo].[ChiTietNhapHang]
for Update 
as
declare @SoLuongTruoc int,@MaHang char(20), @TonKho int,@SoLuongSau int
	select @SoLuongTruoc=de.SoLuong from deleted de
	select @SoLuongSau=ins.SoLuong from inserted ins
	select @MaHang=chen.MaHang from inserted chen
	select @TonKho=HangHoa.SoLuongTonKho from HangHoa where MaHang = @MaHang
begin
	if(@SoLuongSau-@SoLuongTruoc+@TonKho > 0)
		update HangHoa set SoLuongTonKho+=@SoLuongSau-@SoLuongTruoc where MaHang=@MaHang
	else
		print(N'Hang khong du so luong ')
end
GO
ALTER TABLE [dbo].[ChiTietNhapHang] ENABLE TRIGGER [UpdateNhapHang]
GO
/****** Object:  Trigger [dbo].[DeleteXuatHang]    Script Date: 11/16/2022 11:23:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE trigger [dbo].[DeleteXuatHang] on [dbo].[ChiTietXuatHang]
for delete as 
declare @SoLuong int,@MaHang char(20), @TonKho int
	select @SoLuong=chen.SoLuong from deleted chen
	select @MaHang=chen.MaHang from deleted chen
	select @TonKho=HangHoa.SoLuongTonKho from HangHoa where MaHang = @MaHang
begin
	if(@SoLuong > 0)
		update HangHoa set SoLuongTonKho+=@SoLuong where MaHang=@MaHang
	else
		print(N'Hang khong du so luong ')
end
GO
ALTER TABLE [dbo].[ChiTietXuatHang] ENABLE TRIGGER [DeleteXuatHang]
GO
/****** Object:  Trigger [dbo].[KiemTraXuatHang]    Script Date: 11/16/2022 11:23:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

------------------------------------------------------------------------------------------------------

--drop trigger KiemTraNhapHang

------------------------------------------------------------------------------------------------------

create trigger [dbo].[KiemTraXuatHang] on [dbo].[ChiTietXuatHang]
for insert as 
declare @SoLuong int,@MaHang char(20), @TonKho int
	select @SoLuong=chen.SoLuong from inserted chen
	select @MaHang=chen.MaHang from inserted chen
	select @TonKho=HangHoa.SoLuongTonKho from HangHoa where MaHang = @MaHang
begin
	if(@SoLuong <= @TonKho)
		update HangHoa set SoLuongTonKho-=@SoLuong where MaHang=@MaHang
	else
		print(N'Hang khong du so luong ')
end
GO
ALTER TABLE [dbo].[ChiTietXuatHang] ENABLE TRIGGER [KiemTraXuatHang]
GO
/****** Object:  Trigger [dbo].[UpdateXuatHang]    Script Date: 11/16/2022 11:23:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE trigger [dbo].[UpdateXuatHang] on [dbo].[ChiTietXuatHang]
for Update 
as
declare @SoLuongTruoc int,@MaHang char(20), @TonKho int,@SoLuongSau int
	select @SoLuongTruoc=de.SoLuong from deleted de
	select @SoLuongSau=ins.SoLuong from inserted ins
	select @MaHang=chen.MaHang from inserted chen

	select @TonKho=HangHoa.SoLuongTonKho from HangHoa where MaHang = @MaHang
begin
	if(@TonKho-(@SoLuongSau-@SoLuongTruoc) > 0)
		update HangHoa set SoLuongTonKho-=@SoLuongSau-@SoLuongTruoc where MaHang=@MaHang
	else
		print(N'Hang khong du so luong ')
end
GO
ALTER TABLE [dbo].[ChiTietXuatHang] ENABLE TRIGGER [UpdateXuatHang]
GO
/****** Object:  Trigger [dbo].[ThemHangLoi]    Script Date: 11/16/2022 11:23:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



Create trigger [dbo].[ThemHangLoi]
on  [dbo].[HangLoi]
for insert
as declare @SoLuong int,@MaHang char(20)
select @SoLuong=ne.SoLuong from inserted ne
select @MaHang=ne.MaHang from inserted ne
begin
	if(@SoLuong>0)
	begin
		update HangHoa set SoLuongTonKho-=@SoLuong where MaHang=@MaHang
	end
	else
	begin
		print('Kiem tra so luong')
		rollback
	end
end
GO
ALTER TABLE [dbo].[HangLoi] ENABLE TRIGGER [ThemHangLoi]
GO
/****** Object:  Trigger [dbo].[XoaHangLoi]    Script Date: 11/16/2022 11:23:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE trigger [dbo].[XoaHangLoi]
on [dbo].[HangLoi]
for delete
as declare @SoLuong int,@MaHang char(20)
select @SoLuong=ne.SoLuong from deleted ne
select @MaHang=ne.MaHang from deleted ne
begin
	if(@SoLuong>0)
	begin
		update HangHoa set SoLuongTonKho+=@SoLuong where MaHang=@MaHang
	end
	else
	begin
		print('Kiem tra so luong')
		rollback tran
	end
end
GO
ALTER TABLE [dbo].[HangLoi] ENABLE TRIGGER [XoaHangLoi]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "HangHoa"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 215
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_HangHoa'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'view_HangHoa'
GO
