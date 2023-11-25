USE Northwind

---- 01. In ra danh sách các khách hàng
SELECT * FROM Customers -- 92 dòng (Có 1 dòng tự thêm vào)

---- 02. In ra danh sách các khách hàng đến từ Ý
SELECT * FROM Customers WHERE Country = 'Italy' -- còn 3/92 dòng

---- 03. In ra danh sách các khách hàng đến từ Mỹ
SELECT * FROM Customers WHERE Country = 'USA' -- còn 13/92 dòng

---- 04. In ra những khách hàng đến từ Mỹ hoặc Ý
SELECT * FROM Customers WHERE Country = 'Italy' AND Country = 'USA' -- 0 dòng
SELECT * FROM Customers WHERE Country = 'Italy' OR Country = 'USA' -- 16 dòng

-- Sắp xếp để gom lại cho tiện theo dõi
SELECT * FROM Customers
WHERE Country = 'Italy' OR Country = 'USA'
ORDER BY Country

---- 05. In ra khách hàng đến từ thủ đô nước Đức
SELECT * FROM Customers WHERE Country = 'Germany' AND City = 'Berlin'

---- 06. In ra thông tin của nhân viên
SELECT * FROM Employees -- 9 dòng

---- 07. In ra thông tin của nhân viên có năm sinh từ năm 1960 trở lại đây
SELECT * FROM Employees WHERE YEAR(BirthDate) >= 1960 -- 4/9 dòng

---- 08. In ra thông tin của nhân viên có tuổi từ 60 trở lên
SELECT (YEAR(GETDATE()) - YEAR(BirthDate)) AS Age, *
FROM Employees
WHERE (YEAR(GETDATE()) - YEAR(BirthDate)) >= 60 -- 6/9 dòng

---- 09. In ra những nhân viên sống ở Luân Đôn
SELECT * FROM Employees WHERE City = 'London' -- 4 dòng

---- 10. In ra những nhân viên không sống ở Luân Đôn
SELECT * FROM Employees WHERE City != 'London'
SELECT * FROM Employees WHERE City <> 'London'

-- Đảo mệnh đề
SELECT * FROM Employees WHERE NOT (City = 'London')

---- 11. In ra hồ sơ của nhân viên đầu tiên (có mã số là 1)
SELECT * FROM Employees WHERE EmployeeID = 1

---- 12. Xem thông tin của đơn hàng
SELECT * FROM Orders -- 830 dòng

---- 13. Xem thông tin của đơn hàng, sắp xếp giảm dần theo trọng lượng
SELECT * FROM Orders ORDER BY Freight DESC

---- 14. Xem thông tin của đơn hàng,
----	 sắp xếp giảm dần theo trọng lượng,
----	 trọng lượng lớn hơn 500kg
SELECT * FROM Orders
WHERE Freight >= 500
ORDER BY Freight DESC -- 13 dòng

---- 15. In thông tin của đơn hàng,
----	 sắp xếp giảm dần theo trọng lượng,
----	 trọng lượng nằm trong khoảng từ 100 đến 500
SELECT * FROM Orders
WHERE Freight >= 100 AND Freight <= 500
ORDER BY Freight DESC -- 174 dòng

---- 16. In thông tin của đơn hàng,
----	 sắp xếp giảm dần theo trọng lượng,
----	 trọng lượng nằm trong khoảng từ 100 đến 500
----	 và được giao bởi đơn vị vận chuyển số 1
SELECT * FROM Orders
WHERE Freight >= 100
	AND Freight <= 500
	AND ShipVia = 1
ORDER BY Freight DESC -- 52 dòng

-- Nhưng không được giao đến Luân Đôn
SELECT * FROM Orders
WHERE Freight >= 100
	AND Freight <= 500
	AND ShipVia = 1
	AND NOT(ShipCity = 'London') -- AND ShipCity != 'London'
				     -- AND ShipCity <> 'London'
ORDER BY Freight DESC -- 50 dòng

---- 17. Liệt kê các khách hàng đến từ Mỹ hoặc Mễ Tây Cơ
SELECT * FROM Customers
WHERE Country = 'USA' OR Country = 'Mexico'
ORDER BY Country -- 18 / 92 dòng (Có 1 dòng tự thêm vào)

---- 18. Liệt kê các khách hàng không đến từ Mỹ hoặc Mễ Tây Cơ
SELECT * FROM Customers
WHERE NOT (Country = 'USA' OR Country = 'Mexico') -- Cách 1
ORDER BY Country

SELECT * FROM Customers
WHERE Country != 'USA' AND Country != 'Mexico' -- Cách 2
ORDER BY Country

---- 19. Liệt kê các nhân viên được sinh ra trong giai đoạn [1960 - 1970]
SELECT * FROM Employees
WHERE YEAR(BirthDate) >= 1960 OR YEAR(BirthDate) >= 1970 -- Cách 1
ORDER BY BirthDate DESC

SELECT * FROM Employees
WHERE YEAR(BirthDate) >= 1960 AND YEAR(BirthDate) <= 1970 -- Cách 2
ORDER BY BirthDate DESC