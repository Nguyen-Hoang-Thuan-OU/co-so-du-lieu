USE Northwind

---- 01. Liệt kê các nhóm hàng
SELECT * FROM Categories

---- 02. In ra các món hàng thuộc nhóm 1, 6, 8

-- Đơn giản
SELECT * FROM Products
WHERE CategoryID IN (1, 6, 8)
ORDER BY CategoryID

-- Phức tạp
SELECT * FROM Products
WHERE CategoryID = 1 OR CategoryID = 6 OR CategoryID = 8
ORDER BY CategoryID

---- 03. In ra các món hàng thuộc nhóm
----	 nước uống (Beverages),
----	 thịt chế biến sẵn (Meat/Poultry)
----	 và hải sản (Seafood)
SELECT * FROM Products
WHERE CategoryID IN (
			SELECT CategoryID FROM Categories
			WHERE CategoryName IN ('Beverages', 'Meat/Poultry', 'Seafood')
		    )

---- 04. Những nhân viên ở Luân Đôn phụ trách những đơn hàng nào
SELECT * FROM Orders
WHERE EmployeeID IN (
			SELECT EmployeeID FROM Employees
			WHERE City = 'London'
		    )
ORDER BY EmployeeID


---- BÀI TẬP VỀ NHÀ

---- 01. Các nhà cung cấp đến từ Mỹ cung cấp những mặt hàng nào
SELECT * FROM Products
WHERE SupplierID IN (
			SELECT SupplierID FROM Suppliers
			WHERE Country = 'USA'
		    )
ORDER BY SupplierID

---- 02. Các nhà cung cấp đến từ Mỹ cung cấp những nhóm hàng nào
SELECT * FROM Categories
WHERE CategoryID IN (
			SELECT CategoryID
			FROM Products
			WHERE SupplierID IN (
						SELECT SupplierID
						FROM Suppliers
						WHERE Country = 'USA'
					    )
		    )

---- 03. Công ty giao vận nào đã vận chuyển hàng đến Sao Paulo
SELECT * FROM Shippers
WHERE ShipperID IN (
			SELECT ShipVia FROM Orders
			WHERE ShipCity = 'Sao Paulo'
		   )

---- 04. Liệt kê các đơn hàng của những khách hàng
----	 đến từ thành phố Berlin, London, Madrid
SELECT * FROM Orders
WHERE ShipCity IN (
			SELECT City FROM Customers
			WHERE City IN ('Berlin', 'London', 'Madrid')
		  )
ORDER BY ShipCity