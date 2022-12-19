USE Northwind

---- 01. Liệt kê danh sách nhân viên
SELECT * FROM Employees

---- 02. Năm sinh nào là bé nhất (tuổi lớn nhất)

-- Cách truyền thống
SELECT YEAR(BirthDate) AS [Smallest year]
FROM Employees
WHERE BirthDate <= ALL (SELECT Birthdate FROM Employees)

-- Sử dụng hàm MIN()
SELECT MIN(BirthDate) AS [Smallest year]
FROM Employees

SELECT YEAR(MIN(BirthDate)) AS [Smallest year]
FROM Employees

---- 03. In ra thông tin của nhân viên lớn tuổi nhất

-- Cách truyền thống
SELECT *
FROM Employees
WHERE BirthDate <= ALL (SELECT Birthdate FROM Employees)

-- Cách truyền thống
SELECT *
FROM Employees
WHERE BirthDate = (SELECT MIN(BirthDate) FROM Employees)

---- 04. Trong các đơn hàng, đơn hàng nào có trọng lượng nặng / nhẹ nhất

-- Trọng lượng lớn nhất trong các đơn hàng
SELECT Freight FROM Orders
WHERE Freight >= ALL (SELECT Freight FROM Orders)

SELECT MAX(Freight) AS [Highest freight] FROM Orders

-- Đơn hàng có trọng lượng nặng / nhẹ nhất
SELECT * FROM Orders
WHERE Freight = (SELECT MAX(Freight) FROM Orders)

---- 05. Tổng khối lượng các đơn hàng đã vận chuyển

-- Tổng số đơn hàng
SELECT * FROM Orders

SELECT COUNT(*) FROM Orders

-- Tính tổng khối lượng
SELECT SUM(Freight) AS [Freight in total] FROM Orders

---- 06. Tính trung bình các đơn hàng nặng bao nhiêu
SELECT AVG(Freight) AS [Freight in average] FROM Orders

---- 07. Liệt kê các đơn hàng có trọng lượng
----	 nặng hơn trọng lượng trung bình
SELECT * FROM Orders
WHERE Freight >= (SELECT AVG(Freight) FROM Orders)
ORDER BY Freight

---- 08. Có bao nhiêu đơn hàng nặng hơn trọng lượng trung bình

-- Đơn giản
SELECT COUNT(*) AS [Freight >= AVG in total]
FROM Orders
WHERE Freight >= (SELECT AVG(Freight) FROM Orders)

-- Phức tạp
SELECT COUNT(*) AS [Freight >= AVG in total]
FROM (
	SELECT *
	FROM Orders
	WHERE Freight >= (SELECT AVG(Freight) FROM Orders)
     ) AS [AVG]

---- ÔN TẬP THÊM

---- 01. In danh sách nhân viên
SELECT * FROM Employees

---- 02. Đếm xem mỗi khu vực có bao nhiêu nhân viên
SELECT COUNT(*) AS [Region in total]
FROM Employees

-- Đếm dòng
SELECT Region, COUNT(*) AS [Region in total]
FROM Employees
GROUP BY Region

-- Đếm trực tiếp trạng thái NULLL
SELECT Region, COUNT(Region) AS [Region in total]
FROM Employees
GROUP BY Region

---- 03. Khảo sát đơn hàng
SELECT * FROM Orders

-- Mỗi quốc gia có bao nhiêu đơn hàng
SELECT ShipCountry, COUNT(*) AS [Ship countries in total]
FROM Orders
GROUP BY ShipCountry

--- 04.Quốc gia nào có từ 50 đơn hàng trở lên
SELECT ShipCountry, COUNT(*) AS [Ship countries in total]
FROM Orders
GROUP BY ShipCountry
HAVING COUNT(*) >= 50
ORDER BY COUNT(*)

---- 05. Quốc gia nào nhiều đơn hàng nhất
SELECT ShipCountry, COUNT(*) AS [Ship countries in total]
FROM Orders
GROUP BY ShipCountry
HAVING COUNT(*) >= ALL (SELECT COUNT(*) FROM Orders GROUP BY ShipCountry)

---- 06. Liệt kê các đơn hàng của khách hàng có mã là VINET
SELECT * FROM Orders
WHERE CustomerID = 'VINET'

---- 07. Thống kê tổng số lần mua hàng của khách hàng có mã là VINET

-- Cách 1 - Chạy nhanh: Lọc trước khi đếm
SELECT CustomerID, COUNT(*) AS [VINET buy times in total] FROM Orders
WHERE CustomerID = 'VINET'
GROUP BY CustomerID

-- Cách 2 - Chạy chậm: Đếm hết mới lọc
SELECT CustomerID, COUNT(*) AS [VINET buy times in total] FROM Orders
GROUP BY CustomerID
HAVING CustomerID = 'VINET'