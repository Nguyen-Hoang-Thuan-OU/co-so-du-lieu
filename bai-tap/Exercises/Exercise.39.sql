USE Northwind

---- 01. In ra thông tin các sản phẩm (nhãn hàng/mặt hàng) có trong hệ thống

-- Output 1: mã sản phẩm, tên sản phẩm, mã nhà cung cấp,
--	     mã chủng loại, đơn giá, số lượng trong kho
SELECT p.ProductID, p.ProductName, p.SupplierID, p.CategoryID,
       p.UnitPrice, p.UnitsInStock
FROM Products p

-- Output 2: mã sản phẩm, tên sản phẩm, mã nhà cung cấp,
--	     tên nhà cung cấp, xuất xứ nhà cung cấp (quốc gia)
SELECT p.ProductID, p.ProductName, p.SupplierID,
       s.CompanyName, s.Country
FROM Products p FULL JOIN Suppliers s
ON p.SupplierID = s.SupplierID

-- Output 3: mã sản phẩm, tên sản phẩm, mã chủng loại, tên chủng loại
SELECT p.ProductID, p.ProductName,
       c.CategoryID, c.CategoryName
FROM Products p FULL JOIN Categories c
ON p.CategoryID = c.CategoryID

-- Output 4: mã sản phẩm, tên sản phẩm, mã chủng loại, tên chủng loại,
--	     mã nhà cung cấp, tên nhà cung cấp, xuất xứ nhà cung cấp
SELECT p.ProductID, p.ProductName, c.CategoryID, c.CategoryName,
       s.SupplierID, s.CompanyName, s.Country
FROM Products p FULL JOIN Suppliers s
ON p.SupplierID = s.SupplierID
FULL JOIN Categories c
ON p.CategoryID = c.CategoryID

---- 02. In ra thông tin các sản phẩm được cung cấp bởi nhà cung cấp đến từ Mỹ

-- Output 1: mã sản phẩm, tên sản phẩm, mã nhà cung cấp, tên nhà cung cấp,
--	     quốc gia, đơn giá, số lượng trong kho
SELECT p.ProductID, p.ProductName,
       s.SupplierID, s.CompanyName, s.Country,
       p.UnitPrice, p.UnitsInStock
FROM Products p FULL JOIN Suppliers s
ON p.SupplierID = s.SupplierID

-- Output 2: mã sản phẩm, tên sản phẩm, mã nhà cung cấp, tên nhà cung cấp,
--	     đơn giá, số lượng trong kho, mã chủng loại, tên chủng loại
SELECT p.ProductID, p.ProductName,
       s.SupplierID, s.CompanyName,
       p.UnitPrice, p.UnitsInStock,
       c.CategoryID, c.CategoryName
FROM Products p FULL JOIN Suppliers s
ON p.SupplierID = s.SupplierID
FULL JOIN Categories c
ON p.CategoryID = c.CategoryID

---- 03. In ra thông tin các sản phẩm được cung cấp bởi nhà cung cấp đến từ Anh, Pháp, Mỹ
-- Output: mã sản phẩm, tên sản phẩm, mã nhà cung cấp, tên nhà cung cấp,
--	   quốc gia, đơn giá, số lượng trong kho
SELECT p.ProductID, p.ProductName, s.SupplierID, s.CompanyName,
       s.Country, p.UnitPrice, p.UnitsInStock
FROM Products p FULL JOIN Suppliers s
ON p.SupplierID = s.SupplierID
WHERE s.Country IN ('USA', 'UK', 'France')
ORDER BY s.Country

---- 04. Có bao nhiêu nhà cung cấp?
SELECT COUNT(*) AS [Suppliers in total] FROM Suppliers
SELECT COUNT(SupplierID) AS [Suppliers in total] FROM Suppliers

---- 05. Có bao nhiêu nhà cung cấp đến từ Mỹ
SELECT COUNT(*) AS [Suppliers in total]
FROM Suppliers
WHERE Country = 'USA'

SELECT COUNT(SupplierID) AS [Suppliers in total]
FROM Suppliers
WHERE Country = 'USA'

---- 06. Nhà cung cấp Exotic Liquids cung cấp những sản phẩm nào

-- Output 1: mã sản phẩm, tên sản phẩm, đơn giá, số lượng trong kho
SELECT p.ProductID, p.ProductName, p.UnitPrice, p.UnitsInStock
FROM Products p FULL JOIN Suppliers s
ON p.SupplierID = s.SupplierID
WHERE s.CompanyName = 'Exotic Liquids'

-- Output 2: mã sản phẩm, tên sản phẩm, mã nhóm hàng, tên nhóm hàng
SELECT p.ProductID, p.ProductName,
       c.CategoryID, c.CategoryName
FROM Products p FULL JOIN Suppliers s
ON p.SupplierID = s.SupplierID
FULL JOIN Categories c
ON p.CategoryID = c.CategoryID
WHERE s.CompanyName = 'Exotic Liquids'

-- Output 3: mã nhà cung cấp, tên nhà cung cấp,
--	     mã sản phẩm, tên sản phẩm, mã nhóm hàng, tên nhóm hàng
SELECT s.SupplierID, s.CompanyName,
       p.ProductID, p.ProductName,
       c.CategoryID, c.CategoryName
FROM Products p FULL JOIN Suppliers s
ON p.SupplierID = s.SupplierID
FULL JOIN Categories c
ON p.CategoryID = c.CategoryID
WHERE s.CompanyName = 'Exotic Liquids'

---- 07. Mỗi nhà cung cấp cung cấp bao nhiêu mặt hàng (nhãn hàng)

-- Output 1: mã nhà cung cấp, số lượng mặt hàng
SELECT s.SupplierID, COUNT(p.ProductID) AS [Products in total]
FROM Products p FULL JOIN Suppliers s
ON p.SupplierID = s.SupplierID
GROUP BY s.SupplierID

-- Output 2: mã nhà cung cấp, tên nhà cung cấp, số lượng mặt hàng
SELECT s.SupplierID, s.CompanyName, COUNT(p.ProductID) AS [Products in total]
FROM Products p FULL JOIN Suppliers s
ON p.SupplierID = s.SupplierID
GROUP BY s.SupplierID, s.CompanyName

---- 08. Nhà cung cấp Exotic Liquids cung cấp bao nhiêu nhãn hàng?
-- Output: mã nhà cung cấp, tên nhà cung cấp, số lượng mặt hàng
SELECT s.SupplierID, s.CompanyName, COUNT(p.ProductID) AS [Products in total]
FROM Products p FULL JOIN Suppliers s
ON p.SupplierID = s.SupplierID
WHERE s.CompanyName = 'Exotic Liquids'
GROUP BY s.SupplierID, s.CompanyName

---- 09. Nhà cung cấp nào cung cấp nhiều nhãn hàng nhất?
-- Output: mã nhà cung cấp, tên nhà cung cấp, số lượng nhãn hàng
SELECT s.SupplierID, s.CompanyName, COUNT(p.ProductID) AS [Products in total]
FROM Products p FULL JOIN Suppliers s
ON p.SupplierID = s.SupplierID
GROUP BY s.SupplierID, s.CompanyName
HAVING COUNT(p.ProductID) >= ALL (
					SELECT COUNT(p.ProductID)
					FROM Products p FULL JOIN Suppliers s
					ON p.SupplierID = s.SupplierID
					GROUP BY s.SupplierID
				 )

---- 10. Liệt kê các nhà cung cấp cung cấp từ 3 nhãn hàng trở lên
-- Output: mã nhà cung cấp, tên nhà cung cấp, số lượng nhãn hàng
SELECT s.SupplierID, s.CompanyName, COUNT(p.ProductID) AS [Products in total]
FROM Products p FULL JOIN Suppliers s
ON p.SupplierID = s.SupplierID
GROUP BY s.SupplierID, s.CompanyName
HAVING COUNT(p.ProductID) >= 3

---- 11. Có bao nhiêu nhóm hàng/chủng loại hàng
SELECT COUNT(CategoryID) AS [Categories in total] FROM Categories

---- 12. In ra thông tin các sản phẩm (mặt hàng) kèm thông tin nhóm hàng
-- Output: mã nhóm hàng, tên nhóm hàng, mã sản phẩm, tên sản phẩm
SELECT c.CategoryID, c.CategoryName, p.ProductID, p.ProductName
FROM Products p FULL JOIN Categories c
ON p.CategoryID = c.CategoryID

---- 13. Liệt kê các sản phẩm thuộc nhóm hàng Seafood

-- Output 1: mã sản phẩm, tên sản phẩm

-- Cách 1: Sử dụng JOIN
SELECT p.ProductID, p.ProductName
FROM Products p FULL JOIN Categories c
ON p.CategoryID = c.CategoryID
WHERE c.CategoryName = 'Seafood'

-- Cách 2: Sử dụng truy vấn lồng
SELECT ProductID, ProductName
FROM Products
WHERE CategoryID = (
			SELECT CategoryID
			FROM Categories
			WHERE CategoryName = 'Seafood'
		  )

-- Output 2: mã sản phẩm, tên sản phẩm, mã nhóm hàng, tên nhóm hàng
SELECT p.ProductID, p.ProductName, c.CategoryID, c.CategoryName
FROM Products p FULL JOIN Categories c
ON p.CategoryID = c.CategoryID
WHERE c.CategoryName = 'Seafood'

---- 14. Liệt kê các sản phẩm thuộc nhóm hàng Seafood và Beverages,
--	 sắp xếp theo nhóm hàng

-- Output 1: mã sản phẩm, tên sản phẩm
SELECT p.ProductID, p.ProductName
FROM Products p FULL JOIN Categories c
ON p.CategoryID = c.CategoryID
WHERE c.CategoryName IN ('Seafood', 'Beverages')
ORDER BY c.CategoryID

-- Output 2: mã sản phẩm, tên sản phẩm, mã nhóm hàng, tên nhóm hàng
SELECT p.ProductID, p.ProductName, c.CategoryID, c.CategoryName
FROM Products p FULL JOIN Categories c
ON p.CategoryID = c.CategoryID
WHERE c.CategoryName IN ('Seafood', 'Beverages')
ORDER BY c.CategoryID

---- 15. Mỗi nhóm hàng có bao nhiêu nhãn hàng/mặt hàng

-- Output 1: mã nhóm hàng, số lượng nhãn hàng
SELECT c.CategoryID, COUNT(p.ProductID) AS [Products in total]
FROM Categories c FULL JOIN Products p
ON c.CategoryID = p.CategoryID
GROUP BY c.CategoryID

-- Output 2: mã nhóm hàng, tên nhóm hàng, số lượng nhãn hàng
SELECT c.CategoryID, c.CategoryName, COUNT(p.ProductID) AS [Products in total]
FROM Categories c FULL JOIN Products p
ON c.CategoryID = p.CategoryID
GROUP BY c.CategoryID, c.CategoryName

---- 16. Nhóm hàng nào có nhiều nhãn hàng/mặt hàng nhất
-- Output: mã nhóm hàng, tên nhóm hàng, số lượng nhãn hàng
SELECT c.CategoryID, c.CategoryName, COUNT(p.ProductID) AS [Products in total]
FROM Categories c FULL JOIN Products p
ON c.CategoryID = p.CategoryID
GROUP BY c.CategoryID, c.CategoryName
HAVING COUNT(p.ProductID) >= ALL (
					SELECT COUNT(p.ProductID)
					FROM Categories c FULL JOIN Products p
					ON c.CategoryID = p.CategoryID
					GROUP BY c.CategoryID
				 )

---- 17. Nhóm hàng nào có từ 10 nhãn hàng/mặt trở lên
-- Output: mã nhóm hàng, tên nhóm hàng, số lượng nhãn hàng
SELECT c.CategoryID, c.CategoryName, COUNT(p.ProductID) AS [Products in total]
FROM Categories c FULL JOIN Products p
ON c.CategoryID = p.CategoryID
GROUP BY c.CategoryID, c.CategoryName
HAVING COUNT(p.ProductID) >= 10

---- 18. In ra số lượng nhãn hàng/mặt hàng của 2 nhóm hàng Seafood và Beverages
-- Output: mã nhóm hàng, tên nhóm hàng, số lượng nhãn hàng
SELECT c.CategoryID, c.CategoryName, COUNT(p.ProductID) AS [Products in total]
FROM Categories c FULL JOIN Products p
ON c.CategoryID = p.CategoryID
WHERE c.CategoryName IN ('Seafood', 'Beverages')
GROUP BY c.CategoryID, c.CategoryName

---- 19. In ra tất cả các đơn hàng

-- Output 1: Mã đơn hàng, mã khách hàng, mã nhân viên bán hàng,
--	     ngày đặt hàng, gửi tới quốc gia nào
SELECT o.OrderID, o.CustomerID, o.EmployeeID,
       o.OrderDate, o.ShipCountry
FROM Orders o

-- Output 2: Mã đơn hàng, mã khách hàng, tên khách hàng,
--	     mã nhân viên bán hàng, tên nhân viên bán hàng,
--	     ngày đặt hàng, gửi tới quốc gia nào
SELECT o.OrderID, c.CustomerID, c.ContactName,
       o.EmployeeID, e.LastName + ' ' + e.FirstName AS [Employee Full name],
       o.OrderDate, o.ShipCountry
FROM Orders o FULL JOIN Customers c
ON o.CustomerID = c.CustomerID
FULL JOIN Employees e
ON o.EmployeeID = e.EmployeeID

-- Output 3: Mã đơn hàng, mã khách hàng, tên khách hàng,
--	     mã nhân viên bán hàng, tên nhân viên bán hàng, ngày đặt hàng,
--	     mã công ty vận chuyển, tên công ty vận chuyển, gửi tới quốc gia nào
SELECT o.OrderID, c.CustomerID, c.ContactName,
       o.EmployeeID, e.LastName + ' ' + e.FirstName AS [Employee Full name],
       o.OrderDate, o.ShipVia, s.CompanyName, o.ShipCountry
FROM Orders o FULL JOIN Customers c
ON o.CustomerID = c.CustomerID
FULL JOIN Employees e
ON o.EmployeeID = e.EmployeeID
FULL JOIN Shippers s
ON o.ShipVia = s.ShipperID

---- 20. In ra các đơn hàng gửi tới Mỹ

-- Output 1: Mã đơn hàng, mã khách hàng, tên khách hàng,
--	     mã nhân viên bán hàng, ngày đặt hàng, gửi tới quốc gia nào
SELECT o.OrderID, c.CustomerID, c.ContactName,
       o.EmployeeID, o.OrderDate, o.ShipCountry
FROM Orders o FULL JOIN Customers c
ON o.CustomerID = c.CustomerID
WHERE o.ShipCountry = 'USA'

-- Output 2: Mã đơn hàng, mã khách hàng, tên khách hàng,
--	     mã nhân viên bán hàng, tên nhân viên bán hàng,
--	     ngày đặt hàng, gửi tới quốc gia nào
SELECT o.OrderID, c.CustomerID, c.ContactName,
       o.EmployeeID, e.LastName + ' ' + e.FirstName AS [Employee Full name],
       o.OrderDate, o.ShipCountry
FROM Orders o FULL JOIN Customers c
ON o.CustomerID = c.CustomerID
FULL JOIN Employees e
ON o.EmployeeID = e.EmployeeID
WHERE o.ShipCountry = 'USA'

---- 21. In ra các đơn hàng gửi tới Anh, Pháp, Mỹ

-- Output 1: Mã đơn hàng, mã khách hàng, tên khách hàng,
--	     mã nhân viên bán hàng, ngày đặt hàng, gửi tới quốc gia nào
SELECT o.OrderID, c.CustomerID, c.ContactName,
       o.EmployeeID, o.OrderDate, o.ShipCountry
FROM Orders o FULL JOIN Customers c
ON o.CustomerID = c.CustomerID

-- Output 2: Mã đơn hàng, mã khách hàng, tên khách hàng,
--	     mã nhân viên bán hàng, tên nhân viên bán hàng,
--	     ngày đặt hàng, gửi tới quốc gia nào
SELECT o.OrderID, c.CustomerID, c.ContactName,
       o.EmployeeID, e.LastName + ' ' + e.FirstName AS [Employee Full name],
       o.OrderDate, o.ShipCountry
FROM Orders o FULL JOIN Customers c
ON o.CustomerID = c.CustomerID
FULL JOIN Employees e
ON o.EmployeeID = e.EmployeeID

---- 22. Có tổng cộng bao nhiêu đơn hàng?
SELECT COUNT(o.OrderID) AS [Orders in total] FROM Orders o

---- 23. In ra tổng số chi tiết của mỗi đơn hàng
----	 (mỗi đơn hàng có bao nhiêu dòng chi tiết)

-- Output 1: Mã đơn hàng, số lượng chi tiết đơn hàng
SELECT o.OrderID, COUNT(o.OrderID) AS [Orders in total]
FROM Orders o
GROUP BY o.OrderID

-- Output 2: Mã đơn hàng, mã khách hàng, tên khách hàng,
--	     số lượng chi tiết đơn hàng
SELECT o.OrderID, c.CustomerID, c.ContactName, 
       COUNT(o.OrderID) AS [Orders in total]
FROM Orders o FULL JOIN Customers c
ON o.CustomerID = c.CustomerID
GROUP BY o.OrderID, c.CustomerID, c.ContactName

---- 24. HẮC NÃO!!!!! - Tính tổng tiền của mỗi đơn hàng
----	 (nhớ trừ tiền giảm giá tùy theo từng đơn)

-- Output 1: mã đơn hàng, tổng tiền (830 dòng)

-- Tổng giá tiền của từng món trong đơn hàng
SELECT od.OrderID,
       ((od.UnitPrice * od.Quantity) * (1 - od.Discount)) AS [SubTotal Price]
FROM [Order Details] od

-- Tổng giá tiền của cả đơn hàng
-- Cách 1 - Đơn giản
SELECT od.OrderID,
       SUM(((od.UnitPrice * od.Quantity) * (1 - od.Discount))) AS [SubTotal Price]
FROM [Order Details] od
GROUP BY od.OrderID

-- Cách 2 - Phức tạp
SELECT o.OrderID,
       SUM(((od.UnitPrice * od.Quantity) * (1 - od.Discount))) AS [SubTotal Price]
FROM Orders o FULL JOIN [Order Details] od
ON o.OrderID = od.OrderID
GROUP BY o.OrderID

-- Output 2: Mã đơn hàng, mã khách hàng, tên khách hàng, tổng tiền
SELECT od.OrderID, c.CustomerID, c.ContactName,
       SUM(((od.UnitPrice * od.Quantity) * (1 - od.Discount))) AS [SubTotal Price]
FROM [Order Details] od FULL JOIN Orders o
ON o.OrderID = od.OrderID
FULL JOIN Customers c
ON o.CustomerID = c.CustomerID
GROUP BY od.OrderID, c.CustomerID, c.ContactName

---- 25. In ra các đơn hàng có tổng tiền từ 1000$ trở lên

-- Output 1: mã đơn hàng, tổng tiền
SELECT od.OrderID,
       SUM(((od.UnitPrice * od.Quantity) * (1 - od.Discount))) AS [SubTotal Price]
FROM [Order Details] od
GROUP BY od.OrderID
HAVING SUM(((od.UnitPrice * od.Quantity) * (1 - od.Discount))) >= 1000
ORDER BY SUM(((od.UnitPrice * od.Quantity) * (1 - od.Discount)))

-- Output 2: Mã đơn hàng, mã khách hàng, tên khách hàng, tổng tiền
SELECT od.OrderID, c.CustomerID, c.ContactName,
       SUM(((od.UnitPrice * od.Quantity) * (1 - od.Discount))) AS [SubTotal Price]
FROM [Order Details] od FULL JOIN Orders o
ON o.OrderID = od.OrderID
FULL JOIN Customers c
ON o.CustomerID = c.CustomerID
GROUP BY od.OrderID, c.CustomerID, c.ContactName
HAVING SUM(((od.UnitPrice * od.Quantity) * (1 - od.Discount))) >= 1000
ORDER BY SUM(((od.UnitPrice * od.Quantity) * (1 - od.Discount)))

---- 26. Tính tiền của các đơn hàng gửi tới Mỹ
----	 (tính riêng cho từng đơn hàng)
-- Output: mã đơn hàng, quốc gia, tổng tiền
SELECT od.OrderID, o.ShipCountry,
       SUM(((od.UnitPrice * od.Quantity) * (1 - od.Discount))) AS [SubTotal Price]
FROM [Order Details] od FULL JOIN Orders o
ON od.OrderID = o.OrderID
WHERE o.ShipCountry = 'USA'
GROUP BY od.OrderID, o.ShipCountry

---- 27. Tính tổng tiền của tất cả các đơn hàng gửi tới Mỹ (gom tổng)
-- Output: quốc gia, tổng tiền
SELECT o.ShipCountry,
       SUM(((od.UnitPrice * od.Quantity) * (1 - od.Discount))) AS [SubTotal Price]
FROM [Order Details] od FULL JOIN Orders o
ON od.OrderID = o.OrderID
WHERE o.ShipCountry = 'USA'
GROUP BY o.ShipCountry

---- 28. Tính tiền của các đơn hàng gửi tới Anh, Pháp, Mỹ
----	 (tính riêng cho từng đơn hàng)
-- Output: quốc gia, mã đơn hàng, tổng tiền
SELECT o.ShipCountry, od.OrderID,
       SUM(((od.UnitPrice * od.Quantity) * (1 - od.Discount))) AS [SubTotal Price]
FROM [Order Details] od FULL JOIN Orders o
ON od.OrderID = o.OrderID
WHERE o.ShipCountry IN ('USA', 'UK', 'France')
GROUP BY od.OrderID, o.ShipCountry

---- 29. Tổng số tiền thu được từ tất cả các đơn hàng là bao nhiêu?
SELECT SUM(((od.UnitPrice * od.Quantity) * (1 - od.Discount))) AS [SubTotal Price]
FROM [Order Details] od

---- 30. In ra số lượng đơn hàng của mỗi khách hàng
-- Output: Mã khách hàng, tên khách hàng, số lượng đơn hàng đã mua
SELECT c.CustomerID, c.ContactName, COUNT(o.OrderID) AS [Orders in total]
FROM Orders o FULL JOIN Customers c
ON o.CustomerID = c.CustomerID
GROUP BY c.CustomerID, c.ContactName
ORDER BY COUNT(o.OrderID)

---- 31. Khách hàng nào có nhiều đơn hàng nhất?
-- Output: Mã khách hàng, tên khách hàng, số lượng đơn hàng đã mua
SELECT c.CustomerID, c.ContactName,
       COUNT(o.OrderID) AS [Orders in total]
FROM Orders o FULL JOIN Customers c
ON o.CustomerID = c.CustomerID
GROUP BY c.CustomerID, c.ContactName
--ORDER BY  COUNT(o.OrderID)
HAVING COUNT(o.OrderID) >= ALL (
					SELECT COUNT(o.OrderID)
					FROM Orders o FULL JOIN Customers c
					ON o.CustomerID = c.CustomerID
					GROUP BY c.CustomerID
			       )

---- 32. Có bao nhiêu công ty giao hàng?
SELECT COUNT(ShipperID) AS [Shippers in total]
FROM Shippers

---- 33. In ra số lượng đơn hàng mỗi công ty đã vận chuyển
-- Output: Mã công ty giao hàng, tên công ty giao hàng,
--	   số lượng đơn đã vận chuyển
SELECT s.ShipperID, s.CompanyName,
       COUNT(o.OrderID) AS [Orders in total]
FROM Orders o FULL JOIN Shippers s
ON o.ShipVia = s.ShipperID
GROUP BY s.ShipperID, s.CompanyName

---- 34. Công ty nào vận chuyển nhiều đơn hàng nhất?
-- Output: Mã công ty giao hàng, tên công ty giao hàng,
--	   số lượng đơn đã vận chuyển
SELECT s.ShipperID, s.CompanyName,
       COUNT(o.OrderID) AS [Orders in total]
FROM Orders o FULL JOIN Shippers s
ON o.ShipVia = s.ShipperID
GROUP BY s.ShipperID, s.CompanyName
HAVING COUNT(o.OrderID) >= ALL (
					SELECT COUNT(o.OrderID)
					FROM Orders o FULL JOIN Shippers s
					ON o.ShipVia = s.ShipperID
					GROUP BY s.ShipperID
			       )

---- 35. In ra các đơn hàng vận chuyển bởi công ty Speedy Express

-- Output 1: Mã đơn hàng, ngày đặt hàng, mã công ty giao hàng
SELECT o.OrderID, o.OrderDate, s.ShipperID
FROM Orders o JOIN Shippers s
ON o.ShipVia = s.ShipperID
WHERE s.CompanyName = 'Speedy Express'

-- Output 2: Mã đơn hàng, ngày đặt hàng, gửi tới quốc gia nào,
--	     mã công ty giao hàng, tên công ty giao hàng
SELECT o.OrderID, o.OrderDate, o.ShipCountry,
       s.ShipperID, s.CompanyName
FROM Orders o JOIN Shippers s
ON o.ShipVia = s.ShipperID
WHERE s.CompanyName = 'Speedy Express'

---- 36. Công ty Speedy Express đã vận chuyển bao nhiêu đơn hàng 
-- Output: Mã công ty giao hàng, tên công ty, số lượng đơn đã vận chuyển
SELECT s.ShipperID, s.CompanyName,
       COUNT(o.OrderID) AS [Orders in total]
FROM Orders o JOIN Shippers s
ON o.ShipVia = s.ShipperID
WHERE s.CompanyName = 'Speedy Express'
GROUP BY s.ShipperID, s.CompanyName

---- 37. Thêm công ty giao hàng sau vào database bằng cách chạy lệnh sau,
----	 sau đó in ra số lượng đơn hàng mỗi công ty đã vận chuyển
    
INSERT INTO Shippers VALUES('UPS Vietnam', '(+84) 909...')

-- Output: Mã công ty giao hàng, tên công ty giao hàng,
--	   số lượng đơn đã vận chuyển
SELECT s.ShipperID, s.CompanyName,
       COUNT(o.OrderID) AS [Orders in total]
FROM Orders o FULL JOIN Shippers s
ON o.ShipVia = s.ShipperID
GROUP BY s.ShipperID, s.CompanyName

---- 38. Tiếp nối câu trên,
----	 in ra thông tin vận chuyển hàng của các công ty giao vận,
----	 sắp xếp theo mã số công ty giao vận
-- Output: Mã công ty giao hàng, tên công ty giao hàng,
--	   mã đơn hàng, ngày đặt hàng
SELECT s.ShipperID, s.CompanyName,
       o.OrderID, o.OrderDate
FROM Orders o FULL JOIN Shippers s
ON o.ShipVia = s.ShipperID
ORDER BY s.ShipperID

---- 39. Tiếp nối câu trên,
----	 công ty UPS Vietnam vận chuyển những đơn hàng nào?
-- Output: Mã công ty giao hàng, tên công ty giao hàng,
--	   mã đơn hàng, ngày đặt hàng
SELECT s.ShipperID, s.CompanyName,
       o.OrderID, o.OrderDate
FROM Orders o FULL JOIN Shippers s
ON o.ShipVia = s.ShipperID
WHERE s.CompanyName = 'UPS Vietnam'
ORDER BY s.ShipperID
