USE Northwind

---- 01. Liệt kê các nhân viên được sinh ra trong giai đoạn [1960 - 1970]

-- Phong cách cũ với mệnh đề AND
SELECT * FROM Employees
WHERE YEAR(BirthDate) >= 1960 AND YEAR(BirthDate) <= 1970
ORDER BY BirthDate DESC

-- Phong cách mới với mệnh đề BETWEEN và AND
SELECT * FROM Employees
WHERE YEAR(BirthDate) BETWEEN 1960 AND 1970
ORDER BY BirthDate DESC

---- 02. Liệt kê các đơn hàng có trọng lượng từ 100 đến 500
SELECT * FROM Orders
WHERE Freight BETWEEN 100 AND 500
ORDER BY Freight

---- 03. Liệt kê các đơn hàng gửi đến Anh, Pháp và Mỹ

-- Phong cách cũ với mệnh đề WHERE và các toán tử
SELECT * FROM Orders
WHERE ShipCountry = 'UK' OR ShipCountry = 'France' OR ShipCountry = 'USA'
ORDER BY ShipCountry

-- Phong cách mới với mệnh đề BETWEEN và IN
SELECT * FROM Orders
WHERE ShipCountry IN ('UK', 'France', 'USA')
ORDER BY ShipCountry

---- 04. Liệt kê các đơn hàng không gửi đến Anh, Pháp và Mỹ
SELECT * FROM Orders
WHERE ShipCountry NOT IN ('UK', 'France', 'USA')
ORDER BY ShipCountry

---- 05. Liệt kê các đơn hàng trong năm 1996,
----	 nhưng loại trừ các tháng 6, 7, 8 và 9
SELECT * FROM Orders
WHERE YEAR(OrderDate) = 1996 AND MONTH(OrderDate) NOT IN (6, 7, 8, 9)
ORDER BY OrderDate

---- 06. Liệt kê các đơn hàng có trọng lượng từ 100..110

-- Có thể sử dụng theo cách truyền thống đối với tập giá trị số thực
SELECT * FROM Orders
WHERE Freight >= 100 AND Freight <= 110
ORDER BY Freight

-- Hoặc sử dụng theo phong cách BETWEEN và AND
SELECT * FROM Orders
WHERE Freight BETWEEN 100 AND 110
ORDER BY Freight

-- Nhưng sẽ không thể sử dụng toán tử IN
SELECT * FROM Orders
WHERE Freight IN (100, 110)
ORDER BY Freight