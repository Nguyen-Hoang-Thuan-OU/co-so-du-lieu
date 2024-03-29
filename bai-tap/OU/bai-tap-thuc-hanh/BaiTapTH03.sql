-- Tạo Bảng Khoa

create table Khoa
(
	MaKhoa char(4) primary key,
	TenKhoa nvarchar(20) not null,
	NgayThanhLap date,
	NoiDungDaoTao varchar(20),
	GhiChu nvarchar (max)
)


-- Tạo Bảng Lớp

create table Lop
(
	MaLop char(6) primary key,
	TenLop nvarchar(20) not null,
	KhoaHoc char(4),
	GVCN nvarchar (50),
	MaKhoa char (4),
	GhiChu nvarchar (max)
)


-- Tạo Bảng Sinh Viên

create table SinhVien
(
	MaSV char(8) primary key,
	HoSV nvarchar (50) not null,
	TenSV nvarchar (20) not null,
	GioiTinh nvarchar (4),
	NgaySinh date,
	QueQuan nvarchar (50),
	DiaChi nvarchar (100),
	MaLop char (6),
	GhiChu nvarchar (max)
)


-- Tạo Bảng Môn Học

create table MonHoc
(
	MaMH int primary key,
	TenMH nvarchar (20) not null,
	NoiDungMH nvarchar (200),
	MaKhoa char(4),
	SoTinChi int,
	SoTiet int,
	GhiChu nvarchar (max)
)


-- Tạo Bảng Học

create table Hoc
(
	MaSV char(8),
	MaMH int,
	NgayDangKy date,
	NgayThi date,
	DiemTrungBinh int,
	GhiChu nvarchar (max),
	primary key (MaSV, MaMH, NgayDangKy)
)


-- Lớp

Alter table Lop
Add constraint fk_Lop_Khoa_MaKhoa
	Foreign key (MaKhoa) references Khoa
	

-- Sinh Viên

Alter table SinhVien
Add constraint fk_SinhVien_Lop_MaLop
	Foreign key (MaLop) references Lop

	
-- Môn Học

Alter table MonHoc
Add constraint fk_MonHoc_Khoa_MaKhoa
	Foreign key (MaKhoa) references Khoa
	
	
-- Bảng Học

Alter table Hoc
Add constraint fk_MaSV_SinhVien_MaSV
	Foreign key (MaSV) references SinhVien

Alter table Hoc
Add constraint fk_MaMH_MonHoc_MaMH
	Foreign key (MaSV) references MonHoc


-- 7. Tạo query tên ThêmCộtDTDD, viết lệnh SQL để thêm cột ĐiệnThọaiDiĐộng
----- (Short Text, 10) vào bảng SinhViên.

Alter table SinhVien
	Add DTDD char(10)


-- 8. Tạo query tên SửaCộtDTDD, viết lệnh SQL để sửa thiết kế cột
----- ĐiệnThọaiDiĐộng thành (Short Text, 12) của bảng SinhViên.

Alter table SinhVien
	Alter column DTDD char(20)


-- 9. Tạo query tên XóaCộtDTDD, viết lệnh SQL để xoá cột 
----- ĐiệnThọaiDiĐộng của bảng SinhViên.

Alter table SinhVien
	Drop column DTDD


-- 10. Tạo query tên TaoIndexTênSV, viết lệnh SQL để tạo index idxTênSV
------ trong bảng SinhViên.

create index idxTenSV
on SinhVien (TenSV)


-- 11. Tạo query tên TaoIndexSoCMND, viết lệnh SQL để tạo index idxSoCMND
------ (index không trùng dữ liệu) trong bảng SinhViên.

Alter table MonHoc
	add constraint chk_MonHoc_SoTiet
	check (SoTiet between 15 and 60)
	
insert into MonHoc(TenMH, SoTiet)
values ('CSDL', 30)


-- 12. Tạo các query dùng INSERT…VALUES… để thêm thông tin vào các
------ bảng dữ liệu về cá nhân mình, lớp, khoa, môn học, học.
------ Chú ý các thuộc tính not null và thứ tự chạy các câu query này.




-- 13. Tạo query tên XóaIndexTênSV, viết lệnh SQL để xóa index idxTênSV
------ trong bảng SinhViên.




-- 14. Tạo các query dùng DROP TABLE để xoá các bảng
------ SinhViên, Lớp, Khoa, MônHọc,Học.
------ Chú ý thứ tự thực hiện câu lệnh và các ràng buộc khi xoá bảng.


--22. 	Từ Table Product , đếm số sản phẩm, 
--đơn giá cao nhất, thấp nhất và đơn giá trung bình cuả tất cả sản phẩm
select COUNT(ProductID), MAX(UnitPrice), Min(UnitPrice), AVG(UnitPrice)
from Products
--23. 	Như  trên nhưng được nhóm theo loại sản phẩm (Category ID)
select COUNT(ProductID), MAX(UnitPrice), Min(UnitPrice), AVG(UnitPrice)
from Products
group by CategoryID
--24. 	Đếm số đơn đặt hàng cuả các Order có Ship Country là Belgium, Canada, UK
select COUNT(*), ShipCountry
from Orders
where ShipCountry in ('Belgium', 'Canada', 'UK')
group by ShipCountry
--25. 	Lập danh sách các loại sản phẩm có đơn giá trung bình lớn hơn 30
select c.CategoryID, c.CategoryName, avg(d.UnitPrice)
from Categories c, Products d
where c.CategoryID = d.CategoryID 
-- Lấy được đơn giá trung bình của mỗi loại SP -> group by
group by c.CategoryID, CategoryName
having avg(d.UnitPrice)>30
--26. 	Tính đơn giá trung bình cuả các sản phẩm có đơn giá lớn hơn 30, 
--nhóm theo loại sản phẩm
select c.CategoryID, c.CategoryName, avg(d.UnitPrice)
from Categories c, Products d
where c.CategoryID = d.CategoryID and d.UnitPrice >30
group by c.CategoryID, CategoryName

--27. 	Thiết kế query tính doanh số của từng loại sản phẩm (Category) 
--trong năm 1996. 
--Danh sách gồm 2 cột: Category Name, Sales; 
--trong đó SalesTotal = UnitPrice*Quantity*(1-Discount)
select CategoryName, SUM(d.UnitPrice*Quantity*(1-Discount))
from [Order Details] d , Orders o, Products p, Categories c
where d.OrderID = o.OrderID and d.ProductID=p.ProductID and p.CategoryID = c.CategoryID
		and YEAR(OrderDate)=1996
group by CategoryName

--28. 	Thiết kế query tính tỉ lệ tiền cước mua hàng 
(Freight) của từng khách hàng trong năm 1997. 
Danh sách gồm các cột: Company Name (của Customer), Freight, 
SalesTotal = UnitPrice * Quantity*(1-Discount), Percent= Freight/SalesTotal

--29.29. 	Lập danh sách Customer có Company Name
-- bắt đầu là 1 chữ nào đó được nhập từ bàn phím. 
--Danh sách gồm: Customer ID, CompanyName,
-- ContactName, Address, City, Country, Phone, Fax

--Khái niệm biến
DECLARE @tenCty2 nvarchar(40)
--SET @tenCty = 'B'
--SELECT 
select @tenCty2=  CompanyName
		from Customers
		where CustomerID like  'ALFKI'

print @tenCty2




--Khái niệm biến
DECLARE @tenCty nvarchar(40)
SET @tenCty = 'B'
select CustomerID, CompanyName, ContactName, Address, City, Country, Phone, Fax
from Customers
where CompanyName like @tenCty + '%'


--Lấy tên các Cột
SELECT name, 
       type
  FROM dbo.SysColumns
 WHERE name = 'CompanyName'
 
--Lấy tên các ràng buộc
Select  SysObjects.[Name] As [Constraint Name] ,
        Tab.[Name] as [Table Name],
        Col.[Name] As [Column Name]
From SysObjects Inner Join 
	(Select [Name],[ID] From SysObjects) As Tab
	On Tab.[ID] = Sysobjects.[Parent_Obj] 
	Inner Join sysconstraints On sysconstraints.Constid = Sysobjects.[ID] 
	Inner Join SysColumns Col On Col.[ColID] = sysconstraints.[ColID] And Col.[ID] = Tab.[ID]
order by [Tab].[Name]
 
--Lấy tên các Proceduce
SELECT name, 
       type
  FROM dbo.sysobjects
 WHERE (type = 'P')
 


 