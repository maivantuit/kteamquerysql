create database Day2Bai1
go
use Day2Bai1
go


create table LoaiSP(
	MaLoaiSP varchar(10) primary key,
	TenLoaiSP nvarchar(50)
)
insert into LoaiSP values('LSP001',N'Mỹ phẩm')
insert into LoaiSP values('LSP002',N'Trang sức')
insert into LoaiSP values('LSP003',N'Tạp hóa bếp')
create table SanPham(
	MaSP varchar(10) primary key,
	TenSP nvarchar(50),
	MaLoaiSP varchar(10) foreign key references LoaiSP(MaLoaiSP),
	GiaBan decimal(18,0),
	SoLuong int
)
insert into SanPham values('SP001',N'Nước hoa','LSP001','300000','12')
insert into SanPham values('SP002',N'Sữa rửa mặt','LSP001','210000','10')
insert into SanPham values('SP003',N'Đồng hồ','LSP002','420000','123')
insert into SanPham values('SP004',N'Bột giặt OMO','LSP003','15000','105')
insert into SanPham values('SP005',N'Nước rửa chén','LSP003','30000','30')
create table NhanVien(
	MaNV varchar(10) primary key,
	HoTenNV nvarchar(50),
	GioiTinh nvarchar(10) check (GioiTinh in (N'Nam',N'Nữ')),
	QueQuan nvarchar(50),
	Tuoi int
)
insert into NhanVien values('NV001',N'Mai Văn Tú',N'Nam',N'Quảng Trị','22')
insert into NhanVien values('NV002',N'Trịnh Hồng Đào',N'Nữ',N'Long An','19')
insert into NhanVien values('NV003',N'Trần Thế',N'Nam',N'Gia Lai','21')
insert into NhanVien values('NV004',N'Hồng Dương',N'Nam',N'Gia Lai','20')
create table BanHang(
	MaNV varchar(10) foreign key references NhanVien(MaNV),
	MaSP varchar(10) foreign key references SanPham(MaSP),
	SoLuongDaBan int	
)
insert into BanHang values('NV001','SP001','10')
insert into BanHang values('NV001','SP003','51')
insert into BanHang values('NV002','SP004','23')
insert into BanHang values('NV003','SP002','2')
insert into BanHang values('NV004','SP002','12')
insert into BanHang values('NV003','SP001','22')