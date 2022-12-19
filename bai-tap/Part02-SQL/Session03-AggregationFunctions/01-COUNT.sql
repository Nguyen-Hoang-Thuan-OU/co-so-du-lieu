USE Northwind

---- 01. In ra danh sách nhân viên
SELECT * FROM Employees

---- 02. Đếm số lượng nhân viên (do câu lệnh SELECT trả về)
SELECT COUNT(*) AS [Number of employees] FROM Employees

---- 03. Có bao nhiêu nhân viên ở Luân Đôn
SELECT COUNT(*) AS [Number of employees in London]
FROM Employees
WHERE City = 'London'

---- 04. Đếm số lần xuất hiện của thành phố
----	 (Cứ xuất hiện là đếm, không quan tâm bị trùng)
SELECT COUNT(City) AS [Number of cities] FROM Employees

---- 05. Đếm số lượng vùng, miền / bang (Region)
SELECT COUNT(Region) AS [Number of region] FROM Employees

----06. Đếm số lượng vùng, miền / bang (Region) đang là NULL
SELECT COUNT(*) AS [Number of region]
FROM Employees
WHERE Region IS NULL

---- 07. Có bao nhiêu thành phố trong bảng nhân viên
----	 (Không tính những thành phố trùng nhau)
SELECT * FROM Employees

SELECT City FROM Employees -- 9 dòng

SELECT DISTINCT City FROM Employees -- 5 dòng

-- Câu truy vấn lồng trong FROM
SELECT *
FROM (SELECT DISTINCT City FROM Employees) AS Cities

-- Đếm số lần xuất hiện của thành phố
SELECT COUNT(*)
FROM (SELECT DISTINCT City FROM Employees) AS Cities

-- Cách khác
SELECT COUNT(*) FROM Employees -- 9 dòng

SELECT COUNT(City) FROM Employees -- 9 dòng

SELECT COUNT(DISTINCT City) FROM Employees -- 5 dòng

---- 08. Đếm xem mỗi thành phố có bao nhiêu nhân viên
SELECT * FROM Empolyees

SELECT COUNT(City) FROM Employees
GROUP BY City

SELECT Country, City, COUNT(City) AS [Number of employees]
FROM Employees
GROUP BY Country, City

SELECT Country, City, COUNT(*) AS [Number of employees]
FROM Employees
GROUP BY Country, City

---- 09. Thành phố nào có từ hai nhân viên trở lên

-- Đếm xem mỗi thành phố có bao nhiêu nhân viên
SELECT Country, City, COUNT(City) AS [Number of employees]
FROM Employees
GROUP BY Country, City

-- Lọc lại kết quả sau khi đã đếm
SELECT Country, City, COUNT(City) AS [Number of employees] -- COUNT(*)
FROM Employees
GROUP BY Country, City
HAVING COUNT(City) >= 2 -- COUNT(*)

---- 10. Đếm số nhân viên của hai thành phố Seattle và London
SELECT Country, City, COUNT(City) AS [Number of employees]
FROM Employees
WHERE City IN ('Seattle', 'London')
GROUP BY Country, City

---- 11. Giữa hai thành phố, thành phố nào có nhiều hơn 3 nhân viên
SELECT Country, City, COUNT(City) AS [Number of employees]
FROM Employees
WHERE City IN ('Seattle', 'London')
GROUP BY Country, City
HAVING COUNT(City) >= 3

---- 12. Đếm xem có bao nhiêu đơn hàng đã bán ra
SELECT COUNT(*) AS [Total orders] FROM Orders

-- Nước Mỹ có bao nhiêu đơn hàng
SELECT COUNT(*) AS [Total orders in USA]
FROM Orders
WHERE ShipCountry = 'USA'

-- Tổng đơn hàng của Mỹ, Anh và Pháp
SELECT COUNT(*) AS [Total orders in USA, UK and France]
FROM Orders
WHERE ShipCountry IN ('USA', 'UK', 'France')

-- Mỹ, Anh và Pháp, mỗi quốc gia có bao nhiêu đơn hàng
SELECT ShipCountry, COUNT(*) AS [Total orders in USA, UK and France]
FROM Orders
WHERE ShipCountry IN ('USA', 'UK', 'France')
GROUP BY ShipCountry

---- Trong ba quốc gia: Mỹ, Anh và Pháp,
---- quốc gia nào có từ 100 đơn hàng trở lên
SELECT ShipCountry, COUNT(*) AS [Total orders in USA, UK and France]
FROM Orders
WHERE ShipCountry IN ('USA', 'UK', 'France')
GROUP BY ShipCountry
HAVING COUNT(*) >= 100

---- BÀI TẬP VỀ NHÀ

---- 13. Đếm xem có bao nhiêu mặt hàng có trong kho
SELECT COUNT(*) AS [Total products] FROM Products

---- 14. Đếm xem có bao nhiêu lượt quốc gia đã mua hàng
SELECT COUNT(DISTINCT ShipCountry) AS [Total countries]
FROM Orders

---- 15. Đếm xem có bao nhiêu quốc gia đã mua hàng
----	 (Mỗi quốc gia đếm một lần)
SELECT ShipCountry, COUNT(DISTINCT ShipCountry) AS [Total countries]
FROM Orders
GROUP BY ShipCountry

---- 16. Đếm số lượng đơn hàng của mỗi quốc gia
SELECT ShipCountry, COUNT(ShipCountry) AS [Total orders]
FROM Orders
GROUP BY ShipCountry

---- 17. Quốc gia nào có từ 10 đơn hàng trở lên
SELECT ShipCountry, COUNT(ShipCountry) AS [Total orders]
FROM Orders
GROUP BY ShipCountry
HAVING COUNT(ShipCountry) >= 10

---- 18. Đếm xem mỗi loại hàng có bao nhiêu mặt hàng
SELECT CategoryID, COUNT (ProductName)
FROM Products
GROUP BY CategoryID

---- 19. Trong ba quốc gia: Mỹ, Anh và Pháp,
----	 quốc gia nào có nhiều đơn hàng nhất
SELECT ShipCountry, COUNT(*) AS [Total orders]
FROM Orders
WHERE ShipCountry IN ('USA', 'UK', 'France')
GROUP BY ShipCountry
HAVING COUNT(*) >= ALL (
				SELECT COUNT(*)
				FROM Orders
				WHERE ShipCountry IN ('USA', 'UK', 'France')
				GROUP BY ShipCountry
		       )

---- 20. Quốc gia nào có nhiều đơn hàng nhất
SELECT ShipCountry, COUNT(OrderID) AS [Total orders]
FROM Orders
GROUP BY ShipCountry
HAVING COUNT(OrderID) >= ALL (
				SELECT COUNT(OrderID)
				FROM Orders
				GROUP BY ShipCountry
			     )

---- 21. Thành phố nào có nhiều nhân viên nhất
SELECT Country, City, COUNT(City) AS [Total number of employees]
FROM Employees
GROUP BY Country, City
HAVING COUNT(City) >= ALL (
				SELECT COUNT(City)
				FROM Employees
				GROUP BY City
			  )