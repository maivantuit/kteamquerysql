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
insert into LoaiSP values('LSP004',N'Điện tử')
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
insert into SanPham values('SP006',N'Javen','LSP003','10000','20')
insert into SanPham values('SP007',N'Vim','LSP003','0','20')
insert into SanPham values('SP008',N'Lap Top','LSP004','10000000','20')
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
insert into NhanVien values('NV0010',N'Hồng Dương',N'Nam',N'Gia Lai','20')
insert into NhanVien values('NV0011',N'Hồng Dương',N'Nam',N'','20')
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
insert into BanHang values('NV003','SP004','22')


/*********************************QUESTIONS***************************************/
--- Question 1: 
insert into NhanVien values('NV005',N'Nguyễn Chi Phèo',N'Nam',N'Quảng Trị','18')
--- Question 2:
delete NhanVien where QueQuan = N'Kom Tum' 
--- Question 3: Tăng giá bán lên gắp đôi cho những sản phẩm có mã loại sản phẩm là 'LSP001'  
update SanPham set GiaBan = GiaBan*2 where MaLoaiSP = 'LSP001'

--- Question 4: Liệt kê thông tin toàn bộ nhân viên trong công ty
select * 
from NhanVien 

--- Question 5: Liệt kê toàn bộ thông tin của nhân viên từ 23 tuổi trở lên và quê quán ở Bình Định
insert into NhanVien values('NV006',N'Nguyễn Quốc Luyện',N'Nam',N'Bình Định','18')
insert into NhanVien values('NV007',N'Lê Hoàn',N'Nữ',N'Bình Định','24')

select *
from NhanVien
where Tuoi >= 23 and QueQuan = N'Bình Định'

--- Question 6: Liệt kê mã sản phẩm của những sản phẩm đã từng bán
select distinct MaSP as N'Danh sách mã sản phẩm đã từng bán'
from BanHang

--- Question 7: Liệt kê những nhân viên có họ Nguyễn
select *
from NhanVien
where HoTenNV like N'Nguyễn%'

--- Question 8: Liệu kê những nhân viên có tên là Hoa
insert into NhanVien values('NV008',N'Tình Hoa',N'Nữ',N'Kom Tum','24')

select *
from NhanVien
where HoTenNV like N'%Hoa'

--- Question 9: Liệt kê những sản phẩm có tên bao gồm 12 ký tự
select *
from SanPham
where len(TenSP) =7

--- Question 10: Liệt kê sản phẩm thuộc loại 'Mỹ phẩm'
select * -- lấy hết 2 table
from SanPham
join LoaiSP on SanPham.MaLoaiSP = LoaiSP.MaLoaiSP
where TenLoaiSP = N'Mỹ phẩm'

--- Question 11: Liệt kê những sản phẩm có giá bán dưới 20.000 hoặc chưa từng bán lần nào.
select MaSP, TenSP
from SanPham
where GiaBan < 20000
except
select SanPham.MaSP, TenSP 
from BanHang
join SanPham on SanPham.MaSP = BanHang.MaSP

--- Question 12: Liệt kê những nhân viên chưa từng bán được sản phẩm nào 
--và những nhân viên "chỉ mới" bán được sản phẩm bột giặt OMO
go
(select MaNV, HoTenNV 
from NhanVien
except 
select NhanVien.MaNV, HoTenNV
from BanHang
join NhanVien on NhanVien.MaNV = BanHang.MaNV)
union
(select MaNV, HoTenNV
from NhanVien
intersect
select BanHang.MaNV ,HoTenNV
from BanHang
join SanPham on SanPham.MaSP = BanHang.MaSP
join NhanVien on NhanVien.MaNV = BanHang.MaNV
where TenSP = N'Bột giặt OMO'
		and
		BanHang.MaNV in (select MaNV  -- lấy 1 filed để so sánh thôi
		from BanHang
		group by MaNV
		having count(MaSP) =1)
)

--- Question 13: Hãy liệt kê mã nhân viên của những nhân viên có quê ở Gia Lai
-- và chưa từng bán được sản phẩm nào
select MaNV
from NhanVien
where QueQuan = N'Gia Lai'
union
(select MaNV
from NhanVien
except
select MaNV
from BanHang
)

--- Question 14: Hãy liệt kê MaSP, TenSP, MaLoaiSP, GiaBan, TenLoaiSP 
--của tất cả những sản phẩm đã có niêm yết giá bán
select MaSP, TenSP, SanPham.MaLoaiSP, GiaBan , TenLoaiSP
from SanPham
join LoaiSP on LoaiSP.MaLoaiSP = SanPham.MaLoaiSP
where GiaBan <> '0'


--- Question 15: Hãy liệt kê MaNV, HoTenNV, GioiTinh, QueQuan của nhân viên 
--và MaSP, TenSP,MaLoaiSP, TenLSP, SoLuongDaBan của tất cả các nhân viên đã từng bán được hàng.

select  (BanHang.MaNV), HoTenNV, GioiTinh, QueQuan, BanHang.MaSP, TenSP, LoaiSP.MaLoaiSP,TenSP,SoLuongDaBan
from BanHang
join NhanVien on BanHang.MaNV = NhanVien.MaNV
join SanPham on SanPham.MaSP = BanHang.MaSP
join LoaiSP on LoaiSP.MaLoaiSP = SanPham.MaLoaiSP


--- Question 16: Hãy liệt kê MaLSP, TenLSP của những loại sản phẩm đã từng được bán

select distinct LoaiSP.MaLoaiSP, TenLoaiSP
from LoaiSP
join SanPham on SanPham.MaLoaiSP = LoaiSP.MaLoaiSP
where 
	MaSP in (select MaSP from BanHang)

--- Question 17: Hãy liệt kê tên của những nhân viên (nếu có tên trùng thì hiển thị 1 lần)
select distinct HoTenNV
from NhanVien

--- Question 18: Hãy liệt kê MaNV, TenNV, QueQuan của tất cả nhân viên, 
--nếu bạn nào chưa có quê quán thì mục quê quán sẽ hiển thị là 'Cỏi trên xuống'
select MaNV, HoTenNV,
		case
			when QueQuan = '' then  N'Cỏi trên xuống'		
			else QueQuan			
		end as N'Quê quán'
from NhanVien

	


--- Question 19: Hãy liệt kê 5 nhân viên có tuôi đời cao nhất

select top(5)*
from NhanVien
order by Tuoi desc

--- Question 20: Hãy liệt kê những nhân viên có tuổi đời từ 18-22
select *
from NhanVien
where Tuoi between 18 and 22

 select * from LoaiSP
 select * from SanPham
 select * from NhanVien
 select * from BanHang