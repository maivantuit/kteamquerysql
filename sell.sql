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
insert into KhachHang values('KH004','Tran Huu Anh','anhth@gmail.com','0905123564','Sai Gon')
insert into KhachHang values('KH005','Truong Duyen','anhth@gmail.com','0905123564','Da Nang')
insert into KhachHang values('KH006','Nguyen Thuy','anhth@gmail.com','0905123564','Da Nang')

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
insert into DonHang values('DH004','KH001','TT02','03/20/2015')
insert into DonHang values('DH005','KH003','TT02','03/20/2015')
insert into DonHang values('DH006','KH005','TT02','03/20/2015')
insert into DonHang values('DH007','KH006','TT02','03/20/2015')
create table ChiTietDonHang(
	MaDH varchar(10) foreign key references DonHang(MaDH), 	
	MaSP varchar(10) foreign key references SanPham(MaSP), 	
	SoLuong int,
	TongTien decimal(18,0),
	primary key (MaDH,MaSP)
)
insert into ChiTietDonHang values('DH001','SP002','3','56000')
insert into ChiTietDonHang values('DH001','SP001','10','67000')
insert into ChiTietDonHang values('DH003','SP001','10','27000')
insert into ChiTietDonHang values('DH002','SP002','10','67000')
insert into ChiTietDonHang values('DH005','SP002','10','67000')
insert into ChiTietDonHang values('DH006','SP002','10','67000')
insert into ChiTietDonHang values('DH007','SP002','10','67000')







/*------------------------------------------Day 2 LAMTHEM-------------------------------------------*/

--- Question 1:  Liệt kê thông tin toàn bộ Sản Phẩm
select * from SanPham
--- Question 2:  Xóa toàn bộ khách hàng có DiaChi là 'Lang Son'

delete from  KhachHang where DiaChi = 'Lang Son'

DELETE KH.*, DH.*
FROM KhachHang KH
LEFT JOIN DonHang DH ON KH.MaKH = DH.MaKH
WHERE DiaChi =  'Lang Son' 

--- Question 3: Cập nhật giá trị của trường XuatXu trong bảng SanPham thành 'Viet Nam' đối với trường xuất xứ có giá trị là 'NV'

update SanPham set XuatXu = 'Viet Nam' where XuatXu = 'VN'

--- Question 4: Liệt kê thông tin những sản phẩm có SoLuong > 50 thuộc danh mục là 'Thoi Trang Nu' 
--và những sản phẩm có SoLuong > 100 thuộc danh mục là 'Thoi Trang Nam'


select * 
from SanPham
inner join DMSanPham on DMSanPham.MaDM = SanPham.MaDM
where SoLuong > 50 and TenDanhMuc = 'Thoi Trang Nu'
union
select * 
from SanPham
inner join DMSanPham on DMSanPham.MaDM = SanPham.MaDM
where SoLuong > 100 and TenDanhMuc = 'Thoi Trang Nam'

--- Question 5: Liệt kê những khách hàng có tên bắt đầu là ký tự 'A' và có độ dài là 5 ký tự
select *
from KhachHang
where TenKH like '%[ ]A__' --tên có 5 ký tự có 4 dấu '_'

--- Question 6: Liệt kê toàn bộ sản phẩm, sắp xếp giảm dần theo TenSP và tăng dẫn theo SoLuong
select *
from SanPham
order by 
	TenSP desc , SoLuong asc

--- Question 7: Đếm các sản phẩm tương ứng theo từng khách hàng đã đặt hàng, chỉ đếm những sản phẩm được khách hàng đặt trên 5 sản phẩm.

select DonHang.MaKH,count(distinct ChiTietDonHang.MaSP) as SanPhamTuongUngDaDat -- loại bỏ trùng lặp mã sp rồi đếm
from ChiTietDonHang
join DonHang on DonHang.MaDH = ChiTietDonHang.MaDH
join KhachHang on KhachHang.MaKH = DonHang.MaKH
group by DonHang.MaKH
having count(distinct ChiTietDonHang.MaSP) >1 -- loại bỏ trùng lặp mã sp rồi đếm


--- Question 8: Liệt kê tên của toàn bộ khách hàng (tên nào giống nhau thì chỉ liệt kê 1 lần)
select distinct TenKH
from KhachHang

--- Question 9: Liệt kê MaKH, TenKH, TenSP, SoLuong,NgayDat, GiaTien, TongTien 
select DonHang.MaKH, TenKH, TenSP, SanPham.SoLuong, NgayDat, GiaTien,TongTien= GiaTien*SanPham.SoLuong
from KhachHang 
inner join DonHang  on DonHang.MaKH = KhachHang.MaKH
inner join ChiTietDonHang on DonHang.MaDH = ChiTietDonHang.MaDH
inner join SanPham on SanPham.MaSP = ChiTietDonHang.MaSP

--- Question 10: Liệt kê MaKH, TenKH, MaDH, TenSP, SoLuong, TongTien (của tất cả các lần đặt của khách hàng)
-- nhưng khách hàng chưa đặt hàng lần nào thì vẫn phải liệt kê khách hàng đó ra.
select KhachHang.MaKH, TenKH, DonHang.MaDH, TenSP, ChiTietDonHang.SoLuong, TongTien = GiaTien*SanPham.SoLuong-- có thể tính Tổng tiền = Số lượng * Số lượng
from KhachHang
left join DonHang on KhachHang.MaKH = DonHang.MaKH
left join ChiTietDonHang on DonHang.MaDH = ChiTietDonHang.MaDH
left join SanPham on SanPham.MaSP = ChiTietDonHang.MaSP	  --- ở đây chưa có mà nó nối nhiều bảng, nên lấy left hết

--- Question 11: Liệt kê MaKH, TenKH của những khác hàng đã từng đặt hàng với thực hiện thành toán qua 'Visa' 
--hoặc đã thực hiện thanh toán qua 'JCB'

select distinct DonHang.MaKH, TenKH
from DonHang
join ThanhToan on DonHang.MaTT = ThanhToan.MaTT
join KhachHang on KhachHang.MaKH = DonHang.MaKH
where PhuongThucTT = 'Visa' or PhuongThucTT = 'JCB'

 
--- Question 12: Liệt kê MaKH, TenKH của những khách hàng chưa từng mua bất kỳ sản phẩm nào.
-- => chưa giao dịch 
select distinct KhachHang.MaKH,TenKH
from KhachHang
left join DonHang on KhachHang.MaKH = DonHang.MaKH
where DonHang.MaKH is null

select  KhachHang.MaKH,TenKH
from KhachHang
where MaKH not in (select DonHang.MaKH from DonHang)

--  cách khác tìm theo không tồn tại sản phẩm của đơn hàng của khách hàng trong ChiTietDonHang
--  Ứng  theo bài toán mà làm

--- Question 13: Liệt kê MaKH, TenKH, TenSP, SoLuong, GiaTien, PhuongThucTT, NgayDat,TongTien
-- của những khách hàng có địa chỉ là 'Da Nang' và mới thực hiện đặt hàng một lần duy nhất.
-- kết quả liệt kê được sắp xếp tăng dần của trường TenKH

select DonHang.MaKH,TenKH,DiaChi,TenSP, ChiTietDonHang.SoLuong,GiaTien, PhuongThucTT,NgayDat,TongTien = GiaTien*ChiTietDonHang.SoLuong
from KhachHang
join DonHang on KhachHang.MaKH = DonHang.MaKH
join ChiTietDonHang on ChiTietDonHang.MaDH = DonHang.MaDH
join SanPham on ChiTietDonHang.MaSP = SanPham.MaSP
join ThanhToan on ThanhToan.MaTT = DonHang.MaTT
where	DiaChi = 'Da Nang'		
		and 
		DonHang.MaKH in  -- so sánh theo string (chuổi)
		(select MaKH
		from DonHang		
		group by MaKH
		having count(MaDH)=1)
order by TenKH asc


select * from DonHang
select * from ChiTietDonHang
select * from KhachHang
select * from DMSanPham
select * from SanPham
select * from ThanhToan
select * from DonHang
select * from ChiTietDonHang