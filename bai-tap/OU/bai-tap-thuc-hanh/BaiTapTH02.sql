-- 1. Viết tích Đề-các giữa 2 bảng Customers và Orders, nhận xét số hàng kết quả.
----- Thêm điều kiện kết, nhận xét số hàng kết quả.

select *
from dbo.Customers c, dbo.Orders o
where c.CustomerID = o.CustomerID


-- 2. Lập danh sách các Customer ở thành phố London hoặc ở nước Pháp (France)
---- Danh sách gồm: Customer ID, Company Name, Contact Name, Address, City

select CustomerID, CompanyName, ContactName, Address, City
from dbo.Customers
where City = 'London' or Country = 'France'


-- 3. Lập danh sách các Customer là Sales Manager của nước Mỹ (USA) hoặc là Owner của Mexico.
---- Danh sách gồm như trên, thêm cột Contact Title

select CustomerID, CompanyName, ContactName, Address, City, ContactTitle
from dbo.Customers
where (ContactTitle = 'Sales Manager' and Country = 'USA') or (ContactTitle = 'Owner' and Country = 'Mexico')


-- 4. Lập danh sách các Customer là Manager của nước Mỹ (USA)
----- hoặc: không phải là Owner của Mexico. Danh sách gồm các fields như trên

select CustomerID, CompanyName, ContactName, Address, City, ContactTitle
from dbo.Customers
where (ContactTitle like '%Manager%' and Country = 'USA') or (ContactTitle <> 'Owner' and Country = 'Mexico')


-- 5. Lập danh sách các Order có ngày đặt hàng trong 6 tháng đầu năm 1997.
----- Danh sách gồm: Order ID, Order Date, Customer, Employee trong đó
----- Customer là Company Name của khách hàng, Employee lấy Last Name

-- Cách 1
select OrderID, OrderDate, CompanyName, LastName
from dbo.Orders o, dbo.Customers c, dbo.Employees e
where o.CustomerID = c.CustomerID and e.EmployeeID = o.EmployeeID
		and YEAR(OrderDate) = 1997 and MONTH(OrderDate) <= 6

-- Cách 2
set dateformat dmy

select OrderID, OrderDate, CompanyName, LastName
from dbo.Orders o, dbo.Customers c, dbo.Employees e
where o.CustomerID = c.CustomerID and e.EmployeeID = o.EmployeeID
		and OrderDate between '01/01/1997' and '30/06/1997'


-- 6. Lập danh sách các Order có ngày đặt hàng trong tháng 2 năm 1997.
----- Danh sách gồm: Order ID, Order Date, Customer, Employee, trong đó
----- Customer là Company Name của khách hàng, Employee lấy Last Name

select OrderID, OrderDate, CompanyName, LastName
from dbo.Orders o, dbo.Customers c, dbo.Employees e
where o.CustomerID = c.CustomerID and e.EmployeeID = o.EmployeeID
		and YEAR(OrderDate) = 1997 and MONTH(OrderDate) = 2


-- 7. Lập danh sách các Order có ngày đặt hàng trong tháng 4 hàng năm.
----- Danh sách gồm: Order ID, Order Date, Customer, Employee trong đó
----- Customer là Company Name của khách hàng, Employee lấy Last Name

select OrderID, OrderDate, CompanyName, LastName
from dbo.Orders o, dbo.Customers c, dbo.Employees e
where o.CustomerID = c.CustomerID and e.EmployeeID = o.EmployeeID
		and MONTH(OrderDate) = 4


-- 8. Lập danh sách các Order có ngày đặt hàng các năm chẳn.
----- Danh sách gồm: Order ID, Order Date, Customer, Employee trong đó
----- Customer là Company Name của khách hàng, Employee lấy Last Name

select OrderID, OrderDate, CompanyName, LastName
from dbo.Orders o, dbo.Customers c, dbo.Employees e
where o.CustomerID = c.CustomerID and e.EmployeeID = o.EmployeeID
		and YEAR(OrderDate) % 2 = 0


-- 9. Lập danh sách các Order có ngày đặt hàng là 5, 13, 14, 23.
----- Danh sách gồm: Order ID, Order Date, Customer, Employee trong đó
----- Customer là Company Name của khách hàng, Employee lấy Last Name

select OrderID, OrderDate, CompanyName, LastName
from dbo.Orders o, dbo.Customers c, dbo.Employees e
where o.CustomerID = c.CustomerID and e.EmployeeID = o.EmployeeID
--and (DAY(OrderDate) = 5 or DAY(OrderDate) = 13 or DAY(OrderDate) = 14 or DAY(OrderDate) = 23)
		and DAY(OrderDate) in (5, 13, 14, 23)


-- 10. Danh sách các Order có Ship Country là UK do nhân viên có mã là 2 phụ trách trong năm 1997.
------ Danh sách gồm: Order ID, Order Date, Customer, Freight

select OrderID, OrderDate, c.CompanyName, Freight, EmployeeID, ShipCountry
from dbo.Orders o, dbo.Customers c
where o.CustomerID = c.CustomerID and ShipCountry = 'UK' and EmployeeID = 2 and YEAR(OrderDate) = 1997 


-- 11. Người ta muốn biết có bao nhiêu sản phẩm có tên bắt đầu là Ch.
------ Anh chị hãy lập danh sách này, gồm các cột: Product ID, Product Name, Supplier, Category Name

select COUNT(p.ProductID) as 'So luong san pham'
from dbo.Products p, dbo.Suppliers s, dbo.Categories c
where p.SupplierID = s.SupplierID and p.CategoryID = c.CategoryID and ProductName like 'Ch%'


--12. Lập danh sách các sản phẩm không còn tiếp tục cung cấp nữa (trường Discontinued)
----- và có số lượng tồn kho (trường Unit In stock) lớn hơn không.
----- Danh sách gồm: Product ID, Supplier, Unit Price, Unit In Stock

select ProductID, Suppliers.CompanyName, UnitPrice, UnitsInStock
from Products join Suppliers on Products.SupplierID = Suppliers.SupplierID
where UnitsInStock > 0 and Discontinued = 1


-- 13. Lập danh sách các khách hàng không thuộc nước Mỹ.
------ Danh sách gồm: Company Name, Contact Name, Country, Phone, Fax

select CompanyName, ContactName, Country, Phone, Fax
from dbo.Customers
where Country <> 'USA'


--14. Lập danh sách các khách hàng không thuộc các nước Brazil, Italy, Spain, Venezuela và UK.
----- Danh sách gồm: Company Name, Contact Name, Country, Phone, Fax

select CompanyName, ContactName, Country, Phone, Fax
from dbo.Customers
where Country not in ('Brazil', 'Italy', 'Spain', 'Venezuela', 'UK')

-- 15. Lập danh sách các đơn đặt hàng có Ship country là USA và có Freight > 300
------ hoặc các đơn có Ship Country là Argentina và Freight <5.
------ Danh sách gồm: Order ID, Customer, Employee, Order date, Ship Country, Ship date, Freight

select OrderID, CompanyName, Firstname, Orderdate, ShipCountry, ShippedDate, Freight
from dbo.Orders d, dbo.Customers k, dbo.Employees n
where d.CustomerID = k.CustomerID and d.EmployeeID = n.EmployeeID
		and ShipCountry = 'USA' and Freight > 300


-- 16. Hãy tạo một query để mỗi khi mở query thì tự hiện ra danh sách các Order có
------ Order Date hoặc Required Date là ngày hiện tại. Danh sách gồm: Order ID, Customer,
------ Employee, Order date, Required Date, Ship Country, Freight

select OrderID, CompanyName, Firstname, Orderdate, ShipCountry, ShippedDate, Freight
from dbo.Orders d, dbo.Customers k, dbo.Employees n
where d.CustomerID = k.CustomerID and d.EmployeeID = n.EmployeeID
		and (OrderDate = GETDATE() or RequiredDate = GETDATE())


-- 17. Lập danh sách các đơn hàng trong tháng 4/97 gồm các thông tin sau:
------ Order ID, Order Date, Customer, Employee, Freight, New-Freight
------ trong đó New-Freight = 110% Freight

select OrderID, CompanyName, Firstname, Orderdate, Freight * 1.1 as 'New-Freight'
from dbo.Orders d, dbo.Customers k, dbo.Employees n
where d.CustomerID = k.CustomerID and d.EmployeeID = n.EmployeeID
		and MONTH(OrderDate) = 4 and YEAR(OrderDate) = 1997


-- 18. Người ta muốn có danh sách chi tiết các hoá đơn (Order Details) trong năm 1997.
------ Danh sách gồm các thông tin: Order ID, ProductName, Unit Price, Quantity,
------ ThanhTien, Discount, TienGiamGia, TienPhaiTra trong đó:
------ ThanhTien = UnitPrice*Quantity,
------ TienGiamGia = ThanhTien *Discount,
------ TienPhaiTra = ThanhTien – TienGiamGia

select d.OrderID, ProductName, c.UnitPrice as 'Gia ban', Quantity,
		c.UnitPrice * Quantity as 'Thanh tien',
		TienGiamGia = c.UnitPrice * Quantity * Discount,
		TienPhaiTra = c.UnitPrice * Quantity - c.UnitPrice * Quantity * Discount
from [Order Details] c, Orders d, Products s
where d.OrderID = c.OrderID and c.ProductID = s.ProductID
		and YEAR(OrderDate) = 1997


-- 19. Tương tự như câu 18 nhưng chỉ lấy các record có Discount > 0
------ và có TienPhaiTra <50

select d.OrderID, ProductName, c.UnitPrice as 'Gia ban', Quantity,
		c.UnitPrice * Quantity as 'Thanh tien',
		TienGiamGia = c.UnitPrice * Quantity * Discount,
		TienPhaiTra = c.UnitPrice * Quantity - c.UnitPrice * Quantity * Discount
from [Order Details] c, Orders d, Products s
where d.OrderID = c.OrderID and c.ProductID = s.ProductID
		and YEAR(OrderDate) = 1997
		and Discount > 0
		and c.UnitPrice * Quantity - c.UnitPrice * Quantity * Discount < 50


-- 20. Lập danh sách trị giá tồn kho các Product không còn tiếp tục cung cấp nữa
------ (trường Discontinued là Yes). Danh sách gồm: Product ID, Product Name,
------ Supplier Name, UnitPrice, UintsInStock, Total, Supplier Fax,
------ trong đó Total = UnitPrice*UnitsInStock

select ProductID, ProductName, CompanyName, UnitPrice, UnitsInStock,
		Total = UnitPrice * UnitsInStock
from Products join Suppliers on Products.SupplierID = Suppliers.SupplierID
where Discontinued = 1


-- 21. Lập danh sách nhân viên (Table Employee) có hire date từ năm 1993 trở về trước.
------ Danh sách gồm: Name, Hire date, Title, BirthDate, Home Phone,
------ trong đó trường Name ghép từ các trường: TitleOfCourstesy,
------ chữ đầu trường LastName và trường FirstName

set dateformat dmy

select Employees.EmployeeID, Employees.TitleOfCourtesy,
		-- Employees.LastName, Employees.FirstName,
		[TitleOfCourtesy] + ' ' + LEFT([LastName], 1) + '. ' + [FirstName] as Name,
		Employees.HireDate, Employees.BirthDate, Employees.HomePhone
from Employees
where Employees.HireDate <= '31/12/1993'
--Year(HireDate) < 1994


-- 22. Từ Table Product, đếm số sản phẩm, đơn giá cao nhất, thấp nhất
------ và đơn giá trung bình cuả tất cả sản phẩm

select COUNT(ProductID), MAX(UnitPrice), Min(UnitPrice), AVG(UnitPrice)
from Products


-- 23. Như trên nhưng được nhóm theo loại sản phẩm (Category ID)

select COUNT(ProductID), MAX(UnitPrice), Min(UnitPrice), AVG(UnitPrice)
from Products
group by CategoryID 


-- 24. Đếm số đơn đặt hàng cuả các Order có Ship Country là Belgium, Canada, UK

select COUNT(*), ShipCountry
from Orders
where ShipCountry in ('Belgium', 'Canada', 'UK')
group by ShipCountry


-- 25. Lập danh sách các loại sản phẩm có đơn giá trung bình lớn hơn 30

select c.CategoryID, c.CategoryName, avg(d.UnitPrice)
from Categories c, Products d
where c.CategoryID = d.CategoryID 

-- Lấy được đơn giá trung bình của mỗi loại SP -> group by
group by c.CategoryID, CategoryName
having avg(d.UnitPrice) > 30


-- 26. Tính đơn giá trung bình cuả các sản phẩm có đơn giá lớn hơn 30,
------ nhóm theo loại sản phẩm

select c.CategoryID, c.CategoryName, avg(d.UnitPrice)
from Categories c, Products d
where c.CategoryID = d.CategoryID and d.UnitPrice > 30
group by c.CategoryID, CategoryName


-- 27. Thiết kế query tính doanh số của từng loại sản phẩm (Category) trong năm 1996.
------ Danh sách gồm 2 cột: Category Name, Sales;
------ trong đó SalesTotal = UnitPrice*Quantity*(1-Discount)

select CategoryName, SUM(d.UnitPrice*Quantity*(1-Discount))
from [Order Details] d , Orders o, Products p, Categories c
where d.OrderID = o.OrderID and d.ProductID=p.ProductID
		and p.CategoryID = c.CategoryID
		and YEAR(OrderDate) = 1996
group by CategoryName


-- 28. Thiết kế query tính tỉ lệ tiền cước mua hàng (Freight)
------ của từng khách hàng trong năm 1997. Danh sách gồm các cột:
------ Company Name (của Customer), Freight,
------ SalesTotal = UnitPrice * Quantity*(1-Discount),
------ Percent= Freight/SalesTotal

select Customers.CompanyName, SUM(Orders.Freight) as TongTienCuoc,
		SUM([UnitPrice] * [Quantity] * (1-[Discount])) as TongTienHang,
		SUM([Freight]) / SUM([UnitPrice] * [Quantity] * (1-[Discount])) as TiLe
from (Customers join Orders on Customers.CustomerID = Orders.CustomerID)
		join [Order Details] on Orders.OrderID = [Order Details].OrderID
where YEAR([OrderDate]) = 1997
group by Customers.CompanyName


-- 29. Lập danh sách Customer có Company Name bắt đầu là 1 chữ nào đó được nhập từ bàn phím.
------ Danh sách gồm: Customer ID, CompanyName, ContactName, Address, City, Country, Phone, Fax

--Khái niệm biến

-- 1
DECLARE @tenCty nvarchar(40)
SET @tenCty = 'B'

select CustomerID, CompanyName, ContactName, Address, City, Country, Phone, Fax
from Customers
where CompanyName like @tenCty + '%'


-- 2
DECLARE @tenCty2 nvarchar(40)

select @tenCty2=  CompanyName
		from Customers
		where CustomerID like  'ALFKI'

print @tenCty2

-- 30. Lập danh sách các Order có Order Date trong 1 khoảng thời gian nào đó.
------ Tham số nhập: “From date:” và “To:”.
------ Danh sách gồm: Order ID, Customer, ShipCountry, OrderDate

select 
from 
where 


-- 31. Người ta muốn có danh sách các Order của một quốc gia nào đó của khách hàng
------ trong một năm mua hàng nào đó được nhập từ bàn phím.
------ Anh chị hãy thực hiện Query này. Danh sách gồm các cột như trên.

select 
from 
where 


-- 32. Tạo danh sách các Product thuộc một loại nào đó khi nhập Category ID
------ từ bàn phím. Danh sách gồm: Product Name, Unit Price, Supplier

select 
from 
where 


-- 33. Người ta muốn biết trong một ngày nào đó có số lượng đơn đặt hàng
------ theo từng khách hàng cần phải hoàn tất hay không? (theo Required Date).
------ Anh Chị hãy tạo query để thực hiện điều này.
------ Thí dụ nhập ngày 28/9/95 thì ra kết quả sau:
------ còn nhập ngày 3/10/95 thì được kết quả:

select 
from 
where 


-- 34. Thông thường các khách hàng muốn biết thông tin về đơn hàng
------ của họ đã đặt hàng vào một ngày nào đó.
------ (Khách hàng sẽ báo tên công ty và ngày đặt hàng).
------ Thông tin gồm tất cả các cột của table Order.
------ Anh chị hãy thiết kế query để thực hiện điều này.

select 
from 
where 



-- 35. Tương tự nhưng năm được nhập từ bàn phím;
------ trong đó nếu không nhập năm mà chỉ Enter
------ thì sẽ lấy năm hiện tại để tính.

select 
from 
where 



-- 36. Người ta muốn biết trong một ngày nào đó
------ (nếu chỉ Enter là ngày hiện tại) tổng số
------ đơn đặt hàng và doanh số cuả các đơn hàng đó là bao nhiêu.
------ Thí dụ nhập 7 thang 4 nam 1998 thì kết quả sẽ là:

select 
from 
where 

