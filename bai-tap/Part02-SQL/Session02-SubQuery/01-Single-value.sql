USE Northwind

---- 01. In ra danh sách nhân viên
SELECT * FROM Employees

SELECT FirstName FROM Employees WHERE EmployeeID = 1

---- 02. Liệt kê các nhân viên ở Luân Đôn
SELECT * FROM Employees WHERE City = 'London'

---- 03. Liệt kê những ai cùng quê với King Robert

-- * Câu hỏi trực tiếp: Quê quán của King Robert

-- Lấy được ra chính xác King Robert
SELECT * FROM Employees WHERE FirstName = 'Robert'

-- Trả về duy nhất một ô chứa giá trị
SELECT City FROM Employees WHERE FirstName = 'Robert'

-- * Câu hỏi gián tiếp: Những nhân viên cùng quê với King Robert
SELECT * FROM Employees

		-- ≈ WHERE City = 'London'
WHERE City = (
		SELECT City FROM Employees
		WHERE FirstName = 'Robert'
	     )

      -- Loại King Robert ra khỏi kết quả tìm kiếm,
      -- vì đang chỉ cần tìm người có cùng quê quán với King Robert			 
      AND FirstName != 'Robert'

---- 04. Liệt kê các đơn hàng và sắp xếp giảm dần theo cân nặng
SELECT * FROM Orders ORDER BY Freight DESC

-- * Hỏi trực tiếp: Liệt kê các đơn hàng có trọng lượng lớn hơn 252kg
SELECT * FROM Orders
WHERE Freight > 252
ORDER BY Freight DESC -- 47 dòng

-- * Hỏi gián tiếp: Liệt kê các đơn hàng
--		    có trọng lượng lớn hơn hoặc bẳng đơn hàng số 10555

-- Đi lấy trọng lượng của đơn hàng số 10555
SELECT Freight FROM Orders
WHERE OrderID = 10555

-- Liệt kê các đơn hàng
-- có trọng lượng lớn hơn hoặc bẳng đơn hàng số 10555
SELECT * FROM Orders
WHERE Freight >= (
			SELECT Freight FROM Orders
			WHERE OrderID = 10555
		 )
      AND OrderID != 10555
ORDER BY Freight DESC -- 46 dòng


---- BÀI TẬP VỀ NHÀ

---- 01. Liệt kê danh sách các đơn vị vận chuyển hàng
SELECT * FROM Shippers

---- 02. Liệt kê danh sách các đơn hàng
----	 được vận chuyển bởi công ty giao vận có mã số là 1

-- Nhanh gọn
SELECT * FROM Orders
WHERE ShipVia = 1
				
-- Dài dòng
SELECT * FROM Orders
WHERE ShipVia = (
			SELECT ShipperID FROM Shippers
			WHERE ShipperID = 1
		)

---- 03. Liệt kê danh sách các đơn hàng
----	 được vận chuyển bởi công ty giao vận có tên là Speedy Express
SELECT * FROM Orders
WHERE ShipVia = (
			SELECT ShipperID FROM Shippers
			WHERE CompanyName = 'Speedy Express'
		)

---- 04. Liệt kê danh sách các đơn hàng
----	 được vận chuyển bởi công ty giao vận có tên là Speedy Express
----	 và có trọng lượng từ 50-100
SELECT * FROM Orders
WHERE ShipVia = (
			SELECT ShipperID FROM Shippers
			WHERE CompanyName = 'Speedy Express'
		)
      AND (Freight BETWEEN 50 AND 100)
ORDER BY Freight

---- 05. Liệt kê các mặt hàng
----	 cùng chủng loại (Category) với mặt hàng Filo Mix
SELECT * FROM Products
WHERE CategoryID = (
			SELECT CategoryID FROM Products
			WHERE ProductName = 'Filo Mix'
		   )
      AND ProductName != 'Filo Mix'

---- 06. Liệt kê các nhân viên trẻ tuổi hơn nhân viên Janet

-- Nhanh gọn
SELECT * FROM Employees
WHERE BirthDate > (
			SELECT BirthDate FROM Employees
			WHERE FirstName = 'Janet'
		  )
				
-- Dài dòng
SELECT YEAR(GETDATE()) - YEAR(BirthDate) AS Age, *
FROM Employees
WHERE YEAR(GETDATE()) - YEAR(BirthDate) < (
						SELECT YEAR(GETDATE()) - YEAR(BirthDate)
						FROM Employees
						WHERE FirstName = 'Janet'
					  )
ORDER BY BirthDate