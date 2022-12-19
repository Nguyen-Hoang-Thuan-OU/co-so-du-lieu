USE Northwind

---- 01. In ra danh sách nhân viên
SELECT * FROM Employees

---- 02. In ra danh sách nhân viên với thứ tự tăng dần theo năm sinh
----	 Mặc định sẽ sắp xếp tăng dần (ASC)
SELECT * FROM Employees ORDER BY BirthDate
SELECT * FROM Employees ORDER BY BirthDate ASC

---- 03. In ra danh sách nhân viên với thứ tự giảm dần theo năm sinh
SELECT * FROM Employees ORDER BY BirthDate DESC

---- 04. Tính tiền chi tiết mua hàng
SELECT * FROM [Order Details]

SELECT *, ((UnitPrice * Quantity) * (1 - Discount)) AS [SubTotal Price]
FROM [Order DetailS]

---- 05. Tính tiền chi tiết mua hàng, giảm dần theo tổng số tiền đã bỏ ra
SELECT *, ((UnitPrice * Quantity) * (1 - Discount)) AS [SubTotal Price]
FROM [Order DetailS]
ORDER BY [SubTotal Price] DESC

---- 06. In ra danh sách nhân viên giảm dần theo tuổi
SELECT EmployeeID, FirstName, BirthDate, YEAR(GETDATE()) - YEAR(BirthDate) AS Age
FROM Employees
ORDER BY Age DESC