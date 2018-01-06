create database SellingDay2LamThem
go
use SellingDay2LamThem
go
create table KhachHang(
	MaKH varchar(10) primary key,
	TenKH nvarchar(50),
	Email varchar(50),
	SoDT varchar(15),
	DiaChi nvarchar(50)
)
insert into KhachHang values('KH001','Tran Van An','an@gmail.com','0905123564','Lang Son')
insert into KhachHang values('KH002','Phan Phuoc','phuoccp@gmail.com','0905123564','Da Nang')
insert into KhachHang values('KH003','Tran Huu Anh','anhth@gmail.com','0905123564','Ha Noi')

create table DMSanPham(
	MaDM varchar(10) primary key,
	TenDanhMuc varchar(50),
	MoTa nvarchar(100)
)
insert into DMSanPham values('DM01','Thoi Trang Nu','Vay, ao danh cho nu')
insert into DMSanPham values('DM02','Thoi Trang Nam','Quan danh cho nam')
insert into DMSanPham values('DM03','Trang Suc','Danh cho nu va nam')
create table SanPham(
	MaSP varchar(10) primary key,
	MaDM varchar(10) foreign key references DMSanPham(MaDM),
	TenSP nvarchar(50),
	SoLuong int,
	GiaTien decimal(18,0),
	XuatXu varchar(20)	
)
insert into SanPham values('SP001','DM01','Dam Maxi','200','195000','VN')
insert into SanPham values('SP002','DM01',N'Tui Da Mỹ','50','3000000','HK')
insert into SanPham values('SP003','DM02','Lac tay Uc','300','300000','HQ')

create table ThanhToan(
	MaTT varchar(10) primary key,
	PhuongThucTT nvarchar(50)
)
insert into ThanhToan values('TT01','Visa')
insert into ThanhToan values('TT02','Master Card')
insert into ThanhToan values('TT03','JCB')
create table DonHang(
	MaDH varchar(10) primary key,
	MaKH varchar(10) foreign key references KhachHang(MaKH),
	MaTT varchar(10) foreign key references ThanhToan(MaTT), 	
	NgayDat date,
)

insert into DonHang values('DH001','KH002','TT01','10/20/2014')
insert into DonHang values('DH002','KH002','TT01','10/20/2015')
insert into DonHang values('DH003','KH001','TT03','03/20/2015')
create table ChiTietDonHang(
	MaDH varchar(10) foreign key references DonHang(MaDH), 	
	MaSP varchar(10) foreign key references SanPham(MaSP), 	
	SoLuong int,
	TongTien decimal(18,0),
	primary key (MaDH,MaSP)
)
insert into ChiTietDonHang values('DH001','SP002','3','56000')
insert into ChiTietDonHang values('DH003','SP001','10','27000')
insert into ChiTietDonHang values('DH002','SP002','10','67000')







/*------------------------------------------Day 2 LAMTHEM-------------------------------------------*/

--- 1. Question 1: 


select * from KhachHang
select * from DMSanPham
select * from SanPham
select * from ThanhToan
select * from DonHang
select * from ChiTietDonHang