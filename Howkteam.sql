-- 1/ Tạo DB + Sử dụng DB
	Create Database HowKteam
	Go
	Use HowKteam
	Go
	
-- 2/ Tạo các table + Khoá chính
	Create Table THAMGIADT
	(
		MAGV nchar(3),
		MADT nchar(4),
		STT int,
		PHUCAP float,
		KETQUA nvarchar(10),
		Primary Key (MAGV,MADT,STT)
	)
	go
	
	Create Table KHOA
	(
		MAKHOA nchar (4),
		TENKHOA nvarchar (50),
		NAMTL int,
		PHONG char(3),
		DIENTHOAI char(10),
		TRUONGKHOA nchar(3),
		NGAYNHANCHUC datetime,
		primary key (MAKHOA)
	)
	go
	
	create table BOMON
	(
		MABM nchar(4),
		TENBM nchar (50),
		PHONG char(3),
		DIENTHOAI char(11),
		TRUONGBM nchar(3),
		MAKHOA nchar (4),
		NGAYNHANCHUC date,
		primary key (MABM)
	)
	go
	
	create table CONGVIEC 
	(
		MADT nchar(4),
		SOTT int,
		TENCV nvarchar(50),
		NGAYBD datetime,
		NGAYKT datetime,
		primary key (MADT,SOTT)
	)
	go
	
	create table DETAI
	(
		MADT nchar(4),
		TENDT nvarchar(50),
		CAPQL nchar(20),
		KINHPHI float,
		NGAYBD date,
		NGAYKT date,
		MACD nchar(4),
		GVCNDT nchar(3),
		primary key (MADT)
	)
	go
	create table CHUDE
	(
		MACD nchar(4),
		TENCD nvarchar(30),
		primary key (MACD)
	)
	go
	
	create table GIAOVIEN
	(
		MAGV nchar(3),
		HOTEN nvarchar(50),
		LUONG float,
		PHAI nchar(3),
		NGSINH date,
		DIACHI nchar(50),
		GVQLCM nchar(3),
		MABM nchar(4),
		primary key (MAGV)
	)
	go
	
	create table NGUOITHAN
	(
		MAGV nchar(3),
		TEN nchar(12),
		NGSINH datetime,
		PHAI nchar(3),
		primary key (MAGV,TEN)
	)
	go
	
	create table GV_DT
	(
		MAGV nchar(3),
		DIENTHOAI char (10),
		primary key (MAGV,DIENTHOAI)
	)
	go
	
-- 3/ Tạo khoá ngoại
--Tạo khoá ngoại ở bảng THAMGIADT
	Alter table THAMGIADT
		add constraint FK_HG1_MADT
		foreign key (MADT, STT)
		references CONGVIEC(MADT,SOTT)
		go
		
--Tạo khóa ngoại ở bảng CONGVIEC
	Alter table CONGVIEC
		add constraint FK_HG2_MADT
		foreign key (MADT)
		references DETAI(MADT)
		go
		
--Tạo khóa ngoại ở bảng DETAI
	Alter table DETAI
		add constraint FK_HG3_MACD
		foreign key (MACD)
		references CHUDE(MACD)
		go
		
--Tạo khóa ngoại ở bảng DETAI
	Alter table DETAI
		add constraint FK_HG4_GVCNDT
		foreign key (GVCNDT)
		references GIAOVIEN(MAGV)
		go
		
--Tạo khóa ngoại ở bảng THAMGIADT
	Alter table THAMGIADT
		add constraint FK_HG5_MAGV
		foreign key (MAGV)
		references GIAOVIEN(MAGV)
		go
		
--Tạo khóa ngoại ở bảng GIAOVIEN
	Alter table GIAOVIEN
		add constraint FK_HG6_GVQLCM
		foreign key (GVQLCM)
		references GIAOVIEN(MAGV)
		go
			
--Tạo khóa ngoại ở bảng KHOA
	Alter table KHOA
		add constraint FK_HG7_TRUONGKHOA
		foreign key (TRUONGKHOA)
		references GIAOVIEN(MAGV)
		go
		
--Tạo khóa ngoại ở bảng NGUOITHAN
	Alter table NGUOITHAN
		add constraint FK_HG8_MAGV
		foreign key (MAGV)
		references GIAOVIEN(MAGV)
		go
		
--Tạo khóa ngoại ở bảng GIAOVIEN
	Alter table GIAOVIEN
		add constraint FK_HG9_MABM
		foreign key (MABM)
		references BOMON(MABM)
		go
		
--Tạo khóa ngoại ở bảng BOMON
	Alter table BOMON
		add constraint FK_HG10_MAKHOA
		foreign key (MAKHOA)
		references KHOA(MAKHOA)
		go
		
--Tạo khóa ngoại ở bảng BOMON
	Alter table BOMON
		add constraint FK_HG11_TRUONGBM
		foreign key (TRUONGBM)
		references GIAOVIEN(MAGV)
		go
		
--Tạo khóa ngoại ở bảng GV_DT
	Alter table GV_DT
		add constraint FK_HG12_MAGV
		foreign key (MAGV)
		references GIAOVIEN(MAGV)
		go
		
-- 4/ Nhập data
--Nhập data cho bảng CHUDE
	Insert Into CHUDE(MACD,TENCD)
	values ('NCPT', N'Nghiên cứu phát triển')
	Insert Into CHUDE(MACD,TENCD)
	values ('QLGD', N'Quản lý giáo dục')
	Insert Into CHUDE(MACD,TENCD)
	values ('UDCN', N'Ứng dụng công nghệ')
	go
	
--Nhập data cho bảng GIAOVIEN
	Insert Into GIAOVIEN(MAGV,HOTEN,LUONG,PHAI,NGSINH,DIACHI)
	values ('001',N'Nguyễn Hoài An',2000.0,N'Nam','1973-02-15',N'25/3 Lạc Long Quân, Q.10,TP HCM')
	Insert Into GIAOVIEN(MAGV,HOTEN,LUONG,PHAI,NGSINH,DIACHI)
	values ('002',N'Trần Trà Hương',2500.0,N'Nữ','1960-06-20',N'125 Trần Hưng Đạo, Q.1, TP HCM')
	Insert Into GIAOVIEN(MAGV,HOTEN,LUONG,PHAI,NGSINH,DIACHI,GVQLCM)
	values ('003',N'Nguyễn Ngọc Ánh',2200.0,N'Nữ','1975-05-11',N'12/21 Võ Văn Ngân Thủ Đức, TP HCM',N'002')
	Insert Into GIAOVIEN(MAGV,HOTEN,LUONG,PHAI,NGSINH,DIACHI)
	values ('004',N'Trương Nam Sơn',2300.0,N'Nam','1959-06-20',N'215 Lý Thường Kiệt,TP Biên Hòa')
	Insert Into GIAOVIEN(MAGV,HOTEN,LUONG,PHAI,NGSINH,DIACHI)
	values ('005',N'Lý Hoàng Hà',2500.0,N'Nam','1954-10-23',N'22/5 Nguyễn Xí, Q.Bình Thạnh, TP HCM')
	Insert Into GIAOVIEN(MAGV,HOTEN,LUONG,PHAI,NGSINH,DIACHI,GVQLCM)
	values ('006',N'Trần Bạch Tuyết',1500.0,N'Nữ','1980-05-20',N'127 Hùng Vương, TP Mỹ Tho',N'004')
	Insert Into GIAOVIEN(MAGV,HOTEN,LUONG,PHAI,NGSINH,DIACHI)
	values ('007',N'Nguyễn An Trung',2100.0,N'Nam','1976-06-05',N'234 3/2, TP Biên Hòa')
	Insert Into GIAOVIEN(MAGV,HOTEN,LUONG,PHAI,NGSINH,DIACHI,GVQLCM)
	values ('008',N'Trần Trung Hiếu',1800.0,N'Nam','1977-08-06',N'22/11 Lý Thường Kiệt,TP Mỹ Tho',N'007')
	Insert Into GIAOVIEN(MAGV,HOTEN,LUONG,PHAI,NGSINH,DIACHI,GVQLCM)
	values ('009',N'Trần Hoàng nam',2000.0,N'Nam','1975-11-22',N'234 Trấn Não,An Phú, TP HCM',N'001')
	Insert Into GIAOVIEN(MAGV,HOTEN,LUONG,PHAI,NGSINH,DIACHI,GVQLCM)
	values ('010',N'Phạm Nam Thanh',1500.0,N'Nam','1980-12-12',N'221 Hùng Vương,Q.5, TP HCM',N'007')
	go
	
--Nhập data cho bảng DETAI
	Insert Into DETAI(MADT,TENDT,CAPQL,KINHPHI,NGAYBD,NGAYKT,MACD,GVCNDT)
	values ('001',N'HTTT quản lý các trường ĐH',N'ĐHQG',20.0,'2007-10-20','2008-10-20',N'QLGD','002')
	Insert Into DETAI(MADT,TENDT,CAPQL,KINHPHI,NGAYBD,NGAYKT,MACD,GVCNDT)
	values ('002',N'HTTT quản lý giáo vụ cho một Khoa',N'Trường',20.0,'2000-10-12','2001-10-12',N'QLGD','002')
	Insert Into DETAI(MADT,TENDT,CAPQL,KINHPHI,NGAYBD,NGAYKT,MACD,GVCNDT)
	values ('003',N'Nghiên cứu chế tạo sợi Nanô Platin',N'ĐHQG',300.0,'2008-05-15','2010-05-15',N'NCPT','005')
	Insert Into DETAI(MADT,TENDT,CAPQL,KINHPHI,NGAYBD,NGAYKT,MACD,GVCNDT)
	values ('004',N'Tạo vật liệu sinh học bằng màng ối người',N'Nhà nước',100.0,'2007-01-01','2009-12-31',N'NCPT','004')
	Insert Into DETAI(MADT,TENDT,CAPQL,KINHPHI,NGAYBD,NGAYKT,MACD,GVCNDT)
	values ('005',N'Ứng dụng hóa học xanh',N'Trường',200.0,'2003-10-10','2004-12-10',N'UDCN','007')
	Insert Into DETAI(MADT,TENDT,CAPQL,KINHPHI,NGAYBD,NGAYKT,MACD,GVCNDT)
	values ('006',N'Nghiên cứu tế bào gốc',N'Nhà nước',4000.0,'2006-10-12','2009-10-12',N'NCPT','004')
	Insert Into DETAI(MADT,TENDT,CAPQL,KINHPHI,NGAYBD,NGAYKT,MACD,GVCNDT)
	values ('007',N'HTTT quản lý thư viện ở các trường ĐH',N'Trường',20.0,'2009-05-10','2010-05-10',N'QLGD','001')
	go
	
--Nhập data cho bảng CONGVIEC
	Insert Into CONGVIEC(MADT,SOTT,TENCV,NGAYBD,NGAYKT)
	values ('001',1,N'Khởi tạo và Lập kế hoạch','2007-10-20','2008-12-20')
	Insert Into CONGVIEC(MADT,SOTT,TENCV,NGAYBD,NGAYKT)
	values ('001',2,N'Xác định yêu cầu','2008-12-21','2008-03-21')
	Insert Into CONGVIEC(MADT,SOTT,TENCV,NGAYBD,NGAYKT)
	values ('001',3,N'Phân tích hệ thống','2008-03-22','2008-05-22')
	Insert Into CONGVIEC(MADT,SOTT,TENCV,NGAYBD,NGAYKT)
	values ('001',4,N'Thiết kế hệ thống','2008-05-23','2008-06-23')
	Insert Into CONGVIEC(MADT,SOTT,TENCV,NGAYBD,NGAYKT)
	values ('001',5,N'Cài đặt thử nghiệm','2008-06-24','2008-10-20')
	Insert Into CONGVIEC(MADT,SOTT,TENCV,NGAYBD,NGAYKT)
	values ('002',1,N'Khởi tạo và lập kế hoạch','2009-05-10','2009-07-10')
	Insert Into CONGVIEC(MADT,SOTT,TENCV,NGAYBD,NGAYKT)
	values ('002',2,N'Xác định yêu cầu','2009-07-11','2009-10-11')
	Insert Into CONGVIEC(MADT,SOTT,TENCV,NGAYBD,NGAYKT)
	values ('002',3,N'Phân tích hệ thống','2009-10-12','2009-12-20')
	Insert Into CONGVIEC(MADT,SOTT,TENCV,NGAYBD,NGAYKT)
	values ('002',4,N'Thiết kế hệ thống','2009-12-21','2010-03-22')
	Insert Into CONGVIEC(MADT,SOTT,TENCV,NGAYBD,NGAYKT)
	values ('002',5,N'Cài đặt thử nghiệm','2010-03-23','2010-05-10')
	Insert Into CONGVIEC(MADT,SOTT,TENCV,NGAYBD,NGAYKT)
	values ('006',1,N'Lấy mẫu','2006-10-20','2007-02-20')
	Insert Into CONGVIEC(MADT,SOTT,TENCV,NGAYBD,NGAYKT)
	values ('006',2,N'Nuôi cấy','2007-02-21','2008-09-21')
	Insert Into CONGVIEC(MADT,SOTT,TENCV,NGAYBD,NGAYKT)
	values ('003',2,N'A','2007-02-21','2008-09-21')
	Insert Into CONGVIEC(MADT,SOTT,TENCV,NGAYBD,NGAYKT)
	values ('004',2,N'A','2007-02-21','2008-09-21')
	Insert Into CONGVIEC(MADT,SOTT,TENCV,NGAYBD,NGAYKT)
	values ('005',2,N'A','2007-02-21','2008-09-21')
	Insert Into CONGVIEC(MADT,SOTT,TENCV,NGAYBD,NGAYKT)
	values ('007',2,N'A','2007-02-21','2008-09-21')

	go
	select * from CONGVIEC
--Nhập data cho bảng THAMGIADT
	Insert Into THAMGIADT(MAGV,MADT,STT,PHUCAP)
	values ('001','002',1,0.0)
	Insert Into THAMGIADT(MAGV,MADT,STT,PHUCAP)
	values ('001','002',2,2.0)
	Insert Into THAMGIADT(MAGV,MADT,STT,PHUCAP,KETQUA)
	values ('002','001',4,2.0,N'Đạt')
	Insert Into THAMGIADT(MAGV,MADT,STT,PHUCAP,KETQUA)
	values ('003','001',1,1.0,N'Đạt')
	Insert Into THAMGIADT(MAGV,MADT,STT,PHUCAP,KETQUA)
	values ('003','001',2,0.0,N'Đạt')
	Insert Into THAMGIADT(MAGV,MADT,STT,PHUCAP,KETQUA)
	values ('003','001',4,1.0,N'Đạt')
	Insert Into THAMGIADT(MAGV,MADT,STT,PHUCAP)
	values ('003','002',2,0.0)
	Insert Into THAMGIADT(MAGV,MADT,STT,PHUCAP,KETQUA)
	values ('004','006',1,0.0,N'Đạt')
	Insert Into THAMGIADT(MAGV,MADT,STT,PHUCAP,KETQUA)
	values ('004','006',2,1.0,N'Đạt')
	Insert Into THAMGIADT(MAGV,MADT,STT,PHUCAP,KETQUA)
	values ('006','006',2,1.5,N'Đạt')
	Insert Into THAMGIADT(MAGV,MADT,STT,PHUCAP)
	values ('009','002',3,0.5)
	Insert Into THAMGIADT(MAGV,MADT,STT,PHUCAP)
	values ('009','002',5,1.5)
	Insert Into THAMGIADT(MAGV,MADT,STT,PHUCAP)
	values ('009','001',2,1.5)
	Insert Into THAMGIADT(MAGV,MADT,STT,PHUCAP)
	values ('009','003',2,1.5)
	Insert Into THAMGIADT(MAGV,MADT,STT,PHUCAP)
	values ('009','004',2,1.5)
	Insert Into THAMGIADT(MAGV,MADT,STT,PHUCAP)
	values ('009','005',2,1.5)
	Insert Into THAMGIADT(MAGV,MADT,STT,PHUCAP)
	values ('009','006',2,1.5)
	Insert Into THAMGIADT(MAGV,MADT,STT,PHUCAP)
	values ('009','007',2,1.5)

	select * from THAMGIADT
	go
	
--Nhập data cho bảng KHOA
	Insert Into KHOA(MAKHOA,TENKHOA,NAMTL,PHONG,DIENTHOAI,TRUONGKHOA,NGAYNHANCHUC)
	values (N'CNTT',N'Công nghệ thông tin',1995,'B11','0838123456','002','2005-02-20')
	Insert Into KHOA(MAKHOA,TENKHOA,NAMTL,PHONG,DIENTHOAI,TRUONGKHOA,NGAYNHANCHUC)
	values (N'HH',N'Hóa học',1980,'B41','0838456456','007','2001-10-15')
	Insert Into KHOA(MAKHOA,TENKHOA,NAMTL,PHONG,DIENTHOAI,TRUONGKHOA,NGAYNHANCHUC)
	values (N'SH',N'Sinh học',1980,'B31','0838454545','004','2000-10-11')
	Insert Into KHOA(MAKHOA,TENKHOA,NAMTL,PHONG,DIENTHOAI,TRUONGKHOA,NGAYNHANCHUC)
	values (N'VL',N'Vật lý',1976,'B21','0838223223','005','2003-09-18')
	go
	
--Nhập data cho bảng NGUOITHAN
	Insert Into NGUOITHAN(MAGV,TEN,NGSINH,PHAI)
	values ('001',N'Hùng','1990-01-14',N'Nam')
	Insert Into NGUOITHAN(MAGV,TEN,NGSINH,PHAI)
	values ('001',N'Thủy','1994-12-08',N'Nữ')
	Insert Into NGUOITHAN(MAGV,TEN,NGSINH,PHAI)
	values ('003',N'Hà','1998-09-03',N'Nữ')
	Insert Into NGUOITHAN(MAGV,TEN,NGSINH,PHAI)
	values ('003',N'Thu','1998-09-03',N'Nữ')
	Insert Into NGUOITHAN(MAGV,TEN,NGSINH,PHAI)
	values ('007',N'Mai','2003-03-26',N'Nữ')
	Insert Into NGUOITHAN(MAGV,TEN,NGSINH,PHAI)
	values ('007',N'Vy','2000-02-14',N'Nữ')
	Insert Into NGUOITHAN(MAGV,TEN,NGSINH,PHAI)
	values ('008',N'Nam','1991-05-06',N'Nam')
	Insert Into NGUOITHAN(MAGV,TEN,NGSINH,PHAI)
	values ('009',N'An','1996-08-19',N'Nam')
	Insert Into NGUOITHAN(MAGV,TEN,NGSINH,PHAI)
	values ('010',N'Nguyệt','2006-01-14',N'Nữ')
	go
	
--Nhập data cho bảng GV_DT
	Insert Into GV_DT(MAGV,DIENTHOAI)
	values ('001','0838912112')
	Insert Into GV_DT(MAGV,DIENTHOAI)
	values ('001','0903123123')
	Insert Into GV_DT(MAGV,DIENTHOAI)
	values ('002','0913454545')
	Insert Into GV_DT(MAGV,DIENTHOAI)
	values ('003','0838121212')
	Insert Into GV_DT(MAGV,DIENTHOAI)
	values ('003','0903656565')
	Insert Into GV_DT(MAGV,DIENTHOAI)
	values ('003','0937125125')
	Insert Into GV_DT(MAGV,DIENTHOAI)
	values ('006','0937888888')
	Insert Into GV_DT(MAGV,DIENTHOAI)
	values ('008','0653717171')
	Insert Into GV_DT(MAGV,DIENTHOAI)
	values ('008','0913232323')
	go
	
--Nhập data cho bảng BOMON
	Insert Into BOMON(MABM,TENBM,PHONG,DIENTHOAI,MAKHOA)
	values (N'CNTT',N'Công nghệ tri thức','B15','0838126126',N'CNTT')
	Insert Into BOMON(MABM,TENBM,PHONG,DIENTHOAI,MAKHOA)
	values (N'HHC',N'Hóa hữu cơ','B44','0838222222',N'HH')
	Insert Into BOMON(MABM,TENBM,PHONG,DIENTHOAI,MAKHOA)
	values (N'HL',N'Hóa Lý','B42','0838878787',N'HH')
	Insert Into BOMON(MABM,TENBM,PHONG,DIENTHOAI,TRUONGBM,MAKHOA,NGAYNHANCHUC)
	values (N'HPT',N'Hóa phân tích','B43','0838777777','007',N'HH','2007-10-15')
	Insert Into BOMON(MABM,TENBM,PHONG,DIENTHOAI,TRUONGBM,MAKHOA,NGAYNHANCHUC)
	values (N'HTTT',N'Hệ thống thông tin','B13','0838125125','002',N'CNTT','2004-09-20')
	Insert Into BOMON(MABM,TENBM,PHONG,DIENTHOAI,TRUONGBM,MAKHOA,NGAYNHANCHUC)
	values (N'MMT',N'Mạng máy tính','B16','0838676767','001',N'CNTT','2005-05-15')
	Insert Into BOMON(MABM,TENBM,PHONG,DIENTHOAI,MAKHOA)
	values (N'SH',N'Sinh hóa','B33','0838898989',N'SH')
	Insert Into BOMON(MABM,TENBM,PHONG,DIENTHOAI,MAKHOA)
	values (N'VLĐT',N'Vật lý điện tử','B23','0838234234',N'VL')
	Insert Into BOMON(MABM,TENBM,PHONG,DIENTHOAI,TRUONGBM,MAKHOA,NGAYNHANCHUC)
	values (N'VLUD',N'Vật lý ứng dụng','B24','0838454545','005',N'VL','2006-02-18')
	Insert Into BOMON(MABM,TENBM,PHONG,DIENTHOAI,TRUONGBM,MAKHOA,NGAYNHANCHUC)
	values (N'VS',N'Vi Sinh','B32','0838909090','004',N'SH','2007-01-01')
	go
	
--Cập nhật thêm dữ liệu cho bảng GIAOVIEN
	update GIAOVIEN
	set MABM = 'MMT'
	where (MAGV = '001')
	update GIAOVIEN
	set MABM = 'HTTT'
	where (MAGV = '002')
	update GIAOVIEN
	set MABM = 'HTTT'
	where (MAGV = '003')
	update GIAOVIEN
	set MABM = 'VS'
	where (MAGV = '004')
	update GIAOVIEN
	set MABM = N'VLĐT'
	where (MAGV = '005')
	update GIAOVIEN
	set MABM = 'VS'
	where (MAGV = '006')
	update GIAOVIEN
	set MABM = 'HPT'
	where (MAGV = '007')
	update GIAOVIEN
	set MABM = 'HPT'
	where (MAGV = '008')
	update GIAOVIEN
	set MABM = 'MMT'
	where (MAGV = '009')
	update GIAOVIEN
	set MABM = 'HPT'
	where (MAGV = '010')
	GO	



	/*--------------------------QUERY BASIC-----------------------------*/
	/*
	1.	Select [DISTINCT] <Danh sách các thuộc tính> [as Alias]
		From <Danh sách các table hoặc Query hoặc [as Alias] > 
		[Where <điều kiện> [AND/OR]
		[Group by <danh sách các thuộc tính>] 
		[Having <điều kiện nhóm>]  // điều kiện sau khi gom nhóm hoặc sử dụng các hàm thống kê.
		[Order by <Danh sách các thuộc tính [ASC | DESC] >]
		[UNIO/INTERSET/EXCEPT <câu truy vấn khác (*)>]
		+ Sau SELECT:
			- DISTINCT: liệt kệ những giá trị duy nhất, tránh trùng lặp
			- Danh sách các thuộc tính, đổi tên thuộc tính với AS, *: lấy tất cả thuộc tính
			- Sử dụng hàm thống kê. (SUM, MAX, MIN,...)
		+ SAu FROM:
			- Một hoặc danh sách các bảng (có thể đặt bí danh)
		+ Sau WHERE:
			- Toán tử số học + - * /
			- Toán tử so sánh: ANY(giá trị nào đó trong 1 tập hợp) hoặc ALL(tất cả các giá trị trong tập hợp)
			- Toán tử logic: AND, OR, NOT
			- Toán tử tập hợp: UNION, INTERSET, EXCEPT(MINUS)
			- Quan hệ bao hàm: IN, NOT IN, CONTAINS, DOES NOT CONTAIN
			- Điều kiện tồn tại: EXISTS, NOT EXITS
		+ Hàm tính toán: 
			- SELECT các hàm tính toán FROM <table>

	2.	LIKE, NOT, AND, OR, IN, BETWEEN, IS NULL, IS NOT NULL
		YEAR(NgaySinh) 
		(=> nằm tại điều kiện where)
	3.  TOP:
		select TOP(3) * 
		from tableName
	4. 
		%: đại diện cho nhiều ký tự, 
		_ : đại diện cho 1 ký tự.
		[ ]: đại diện 1 khoảng nào đó.
	5. 
		getdate(): lấy ra ngày hệ thống
		year,mouth, day: 
		datediff(d, ngaybatdau,ngayketthuc): tính khoảng cách giữa 2 khoảng thời gian
	6.	Len : lấy độ dài ký tự
		Cast: cast(Luong as varchar): chuyển Luong thành kiểu varchar
	7. Các phép toán tập hợp:
		select from where group by order
			union(hợp: + 2 bảng thành 1 bảng- không trùng, union all: hợp lấy trùng)| 
				- Có 3 cách thể hiện: UNION, Truy vấn lồng: EXISTS, IN
			intersect(giao:  phần giao, lấy những cột giống nhau, bên này(Bảng A) có bên này(Bảng B) cũng có) |
				- có 3 cách thể hiện: intersect, exists, in
			except(trừ, loại bỏ: trên trừ cho dưới, select 1- select 2, bảng 1 - bảng 2- đã truy vấn)
				- Có 3 cách thể hiện phép trừ: except, not exists, not in.
		select from where group by order
		Luu y: 
			- Các cột phải giống nhau, cùng kiểu dữ liệu.
			- Sử dụng cho > 2 câu lệnh select
	8. Join:
		inner join: 
		left join:
		right join:
	9. Hàm thông kê(kết hợp):
		- COUNT: đếm số dòng dữ liệu hoặc đếm số lượng giá trị của một thuộc tính
		- AVG: tính giá trị trung bình
		- MAX: tính giá trị lớn nhất
		- MIN: tính giá trị nhỏ nhất
		- SUM: tính tổng

	10. Group by - Having:		
		- Sử dụng được khi có nhu cầu gom nhóm dữ liệu các thao tác tính toán. Thường dùng với hàm thông kê (kết hợp)
		- khi sử dụng Group by với các hàm này thì các hàm này chỉ tính toán trên các dòng cùng một nhóm dữ liệu
		- Having là điều kiện sau khi gom nhóm. like WHERE.
		- Cái nào có trong group by mới được Having
		- số cột tại select = tại group by || ngoại trừ hàm count()

	11. Truy vấn lồng:
		- Sau select hoặc sau where
		- Đi theo với IN, ALL, NOT IN, ANY, SOME
		- EXISTS, NOT EXISTS


	*/
	--- Question 1: Cho biết họ tên và lương của tất cả Giáo Viên
	select HOTEN, LUONG
	from GIAOVIEN
	where LUONG >2000
	order by LUONG ASC, HOTEN DESC 
	--- Question 2: Lấy những giáo viên là nam và tên có độ dài >20
	select HOTEN, LUONG ,PHAI
	from GIAOVIEN
	where PHAI = 'Nam' and LEN(HOTEN) >20 -- hoặc LIKE
	--- Question 3: Lấy thông tin giáo viên không có người quản lý
	select * 
	from  GIAOVIEN
	where GVQLCM is null --hoặc not null
	--- Question 4: Cho biết những đề tài có bắt đầu sau ngày 30/04/2005
	select * from DETAI
	where DATEDIFF(d,NGAYBD,'04/30/2005') < 0 --- tính ra số ngày, nếu < 0 thì nó sau ngày 30/04/2005 (thamso2-thamso3 = int theo thamso1)

	--- Question 5: 
	select *
	from GIAOVIEN
	where PHAI = 'Nam'
	union 
	select *
	from GIAOVIEN
	where PHAI = N'Nữ'

	select MAGV
	from GIAOVIEN
	where PHAI = 'Nam'
	intersect
	select MAGV
	from NGUOITHAN
	where PHAI = N'Nữ'

	select *
	from GIAOVIEN
	except
	(select *
	from GIAOVIEN
	where PHAI = N'Nam' 
	union 
	select *
	from GIAOVIEN
	where GVQLCM is null)

	--- Question 6: 
	-- Join(inner join): lấy phần giao
	select HOTEN, TENBM
	from GIAOVIEN 
	join BOMON
	on GIAOVIEN.MaBM = BOMON.MABM
	-- left join:  bảng bên trái và phần giao.
	-- right join: bảng bên phải và phần giao. 
	-- full join: left + right

	--- Question 7: Tìm những giáo viên không tham gia đề tài.
	-- Except :
	-- not in :
	-- not exists : (use nhiều)
	--- Ba toán từ trên về bản chất là giống nhau.
	-- lấy giáo viên đã có - các giáo viên đã tham gia đề tài
	select MAGV, HOTEN as N'Những giáo viên đã tham gia đề tài'
	from GIAOVIEN
	except
	select THAMGIADT.MaGV, GIAOVIEN.HOTEN
	from THAMGIADT join GIAOVIEN
	on GIAOVIEN.MAGV = THAMGIADT.MAGV
	 
	select MaGV, HOTEN
	from GIAOVIEN
	where MAGV not in (select MAGV 
						from THAMGIADT)
	
	select MaGV, HOTEN
	from GIAOVIEN
	where not exists (select MAGV 
						from THAMGIADT 
						where GIAOVIEN.MAGV = THAMGIADT.MAGV)-- nhớ là có điều kiện =.

	--- Question 8: Tìm những giáo viên vừa tham gia đề tài vừa là trưởng bộ môn
	-- INTERSECT: 
	-- EXISTS:
	-- IN:

	(select THAMGIADT.MAGV , HOTEN as N'Những giáo viên tham gia đề tài'
	from THAMGIADT join GIAOVIEN on GIAOVIEN.MAGV = THAMGIADT.MAGV)
	intersect 
	(select TRUONGBM, HOTEN  -- TRuongBM đây chính là MaGV nha.
	from BOMON join GIAOVIEN on GIAOVIEN.MAGV = BOMON.TRUONGBM)


	select MAGV, HOTEN as  N'Những giáo viên tham gia đề tài'
	from GIAOVIEN
	where 
			exists (select TRUONGBM 
					from BOMON
					where GIAOVIEN.MAGV = BOMON.TRUONGBM
					)
			and
			exists (select MAGV 
					from THAMGIADT
					where GIAOVIEN.MAGV = THAMGIADT.MAGV
					)

	select MaGV, HOTEN as  N'Những giáo viên tham gia đề tài'
	from GIAOVIEN
	where 
			MaGV in (select TRUONGBM from BOMON)
			and
			MaGV in(select MAGV from THAMGIADT)

	--- Question 9: Liệt kê những giáo viên có tham gia đề tài và những giáo viên là trưởng bộ môn:
	--- UNION:
	select THAMGIADT.MAGV , HOTEN
	from THAMGIADT join GIAOVIEN on GIAOVIEN.MAGV = THAMGIADT.MAGV
	UNION
	select TRUONGBM, HOTEN
	from BOMON join GIAOVIEN on GIAOVIEN.MAGV = BOMON.TRUONGBM

	select THAMGIADT.MAGV , HOTEN
	from THAMGIADT join GIAOVIEN on GIAOVIEN.MAGV = THAMGIADT.MAGV
	UNION ALL
	select TRUONGBM, HOTEN
	from BOMON join GIAOVIEN on GIAOVIEN.MAGV = BOMON.TRUONGBM

	--- EXISTS:
	select MAGV, HOTEN 
	from GIAOVIEN
	where 
		exists (select MaGV from THAMGIADT
				where GIAOVIEN.MAGV = THAMGIADT.MAGV
		)
		or
		exists (select TRUONGBM from BOMON
				where GIAOVIEN.MAGV = BOMON.TRUONGBM
		)
	--- IN:
	select MAGV , HOTEN
	from GIAOVIEN
	where 
		MAGV in (select MAGV from THAMGIADT)
		or
		MAGV in (select TRUONGBM from BOMON)


	--- Question 10: Tìm các giáo viên mà tham gia tất cả các đề tài.
	-- Phép chia: (có từ tất cả) - (phủ định lại ý nghĩa của đề bài)
	-- Use not exists:
	-- Trong bảng ThamGiaDT có 1 MaGV có tất cả các đề tài.

	select distinct TG1.MAGV, HOTEN as N'Tên giáo viên tham gia tất cả đề tài'
	from THAMGIADT as TG1
	join GIAOVIEN on GIAOVIEN.MAGV = TG1.MAGV
	where not exists(	select MaDT
						from DETAI
						where not exists (	select MaDT
											from THAMGIADT as TG2
											where 
												TG2.MAGV = TG1.MAGV
												and
												DETAI.MADT = TG2.MADT						
										)
					)
	-- Use EXCEPT:

	-- Use Group by:


	--- Quesiton 11:
	select count(MaGV) as N'Số lượng giáo viên', SUM(LUONG)as 'Tổng lương'  from GIAOVIEN

	select count(MaGV) as N'Số lượng giáo viên thuộc HTTT' from GIAOVIEN where MABM = 'HTTT'

	select AVG(LUONG) as N'Lương trung bình của ngành HTTT' from GIAOVIEN where MABM = 'HTTT'

	select min(LUong) as N'Lương min' from GIAOVIEN

	select max(LUong) as N'Lương max' from GIAOVIEN

	
	--- Question 12: Cho biết số giáo viên trong mỗi bộ môn
	--GROUP BY - HAVING:
	
	select GIAOVIEN.MABM, count(MaGV) as N'Số giáo viên'
	from GIAOVIEN
	join BOMON on BOMON.MABM = GIAOVIEN.MABM
	--where TENBM = N'Hệ thống thông tin'
	group by GIAOVIEN.MABM
	--having TENBM = N'Hệ thống thông tin'

	select GIAOVIEN.MABM, count(MaGV) as N'Số giáo viên'
	from GIAOVIEN
	join BOMON on BOMON.MABM = GIAOVIEN.MABM
	where TENBM = N'Hệ thống thông tin'
	Group by GIAOVIEN.MABM

	select GIAOVIEN.MABM, count(MaGV) as N'Số giáo viên'
	from GIAOVIEN
	join BOMON on BOMON.MABM = GIAOVIEN.MABM	
	group by GIAOVIEN.MABM
	having GIAOVIEN.MABM = N'HTTT'


	--- Question 12: Cho biết bộ môn nào có số giáo viên > 1 và giáo viên đó có lương > 1800
	-- so sánh HAVING và WHERE
	select MABM, count(MAGV) as N'Số giáo viên' , LUONG
	from GIAOVIEN
	where LUONG >1800
	group by MABM,LUONG -- số cột tại select = tại group by || ngoại trừ hàm count
	having count(MAGV)  >1

	select MABM
	from GIAOVIEN
	group by MABM
	having count(MAGV)  >2

	
	--- Question 13: 
	-- Truy vấn lồng sau select:
	-- Truy vấn lồng sau from:
	-- Truy vấn lồng sau where(hay dùng nhất):

	select HOTEN, LUONG 
	from GIAOVIEN
	where MABM = 'HTTT'


	--- Question 14: Tìm những giáo viên có lương lớn hơn lương của GV có mã '001'
	select MAGV, HOTEN, LUONG
	from GIAOVIEN
	where LUONG >
			(select LUONG   --- lấy 1 giá trị để so sánh
			from GIAOVIEN 
			where  MAGV = '001'
			)
			and
			HOTEN like N'%Hà'

	select top(1) MAGV, HOTEN, LUONG
	from GIAOVIEN
	where LUONG >
			(select LUONG   --- lấy 1 giá trị để so sánh
			from GIAOVIEN 
			where  MAGV = '001'
			)
		
	--- Question 15: Tìm bộ môn có giáo viên đông nhất
	select top(1)  MaBM, count(MAGV) as SOLUONG
	from GIAOVIEN
	group by MABM		
	order by SOLUONG desc -- order by sử dụng được cột SOLUONG, còn having thì không
	
	


	go
	Select * from THAMGIADT
	Select * from KHOA
	Select * from BOMON
	Select * from CONGVIEC
	Select * from DETAI
	Select * from CHUDE
	Select * from GIAOVIEN
	Select * from NGUOITHAN
	Select * from GV_DT
	/*
		Select [DISTINCT] <Danh sách các thuộc tính> [as Alias]
		From <Danh sách các table hoặc Query hoặc [as Alias] > 
		[Where <điều kiện> [AND/OR]
		[Group by <danh sách các thuộc tính>] 
		[Having <điều kiện nhóm>]  // điều kiện sau khi gom nhóm hoặc sử dụng các hàm thống kê.
		[Order by <Danh sách các thuộc tính [ASC | DESC] >]
		[UNIO/INTERSET/EXCEPT <câu truy vấn khác (*)>]
	*/