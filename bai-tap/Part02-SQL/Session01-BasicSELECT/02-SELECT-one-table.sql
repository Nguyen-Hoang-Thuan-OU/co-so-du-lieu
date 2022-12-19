USE Northwind

---- 01. Xem toàn bộ thông tin của các khách hàng đang giao dịch với mình
SELECT * FROM Customers

-- Trùng khoá chính
INSERT INTO Customers(CustomerID, CompanyName, ContactName)
	VALUES('ALFKI', 'Open University', 'Nguyen Hoang Thuan')

-- Khác khoá chính
INSERT INTO Customers(CustomerID, CompanyName, ContactName)
	VALUES('OUNHT', 'Open University', 'Nguyen Hoang Thuan')

---- 02. Xem toàn bộ thông tin của nhân viên
SELECT * FROM Employees

---- 03. Xem toàn bộ sản phẩm dang có trong kho
SELECT * FROM Products

---- 04. Xem tóm tắt toàn bộ thông tin của đơn hàng đã mua
SELECT * FROM Orders -- 830 đơn hàng / hoá đơn

---- 05. Xem toàn bộ thông tin của đơn vị vận chuyển / giao vận
SELECT * FROM Shippers

INSERT INTO Shippers(CompanyName, Phone) VALUES('Fedex Vietnam', '(084)90')

---- 06. Xem chi tiết toàn bộ thông tin của những món hàng trong đơn hàng đã mua
SELECT * FROM [Order Details]

---- 07. In ra thông tin khách hàng, chỉ gồm các cột
----	 CustomerID, CompanyName, ContactName, Country
SELECT CustomerID, CompanyName, ContactName, Country
FROM Customers

---- 08. In ra thông tin nhân viên, chỉ gồm các cột
----	 EmployeeID, LastName, FirstName, Title, BirthDate
SELECT EmployeeID, LastName, FirstName, Title, BirthDate
FROM Employees

---- 09. Ghép tên và tính tuổi của nhân viên
SELECT EmployeeID, LastName + ' ' + FirstName AS [Full name],
	Title, YEAR(BirthDate) AS [Year BirthDate],
	YEAR(GETDATE()) - YEAR(BirthDate) AS Age
FROM Employees

---- 10. In ra chi tiết thông tin mua hàng

-- Công thức tính tổng tiền phải trả cho từng món
-- (có áp dụng giảm giá):
-- (Số lượng * Đơn giá) - (Số lượng * Đơn giá * Giảm giá)
-- (Số lượng * Đơn giá) * (1 - Giảm giá)
SELECT *, ((UnitPrice * Quantity) * (1 - Discount)) AS [SubTotal Price]
FROM [Order Details]

