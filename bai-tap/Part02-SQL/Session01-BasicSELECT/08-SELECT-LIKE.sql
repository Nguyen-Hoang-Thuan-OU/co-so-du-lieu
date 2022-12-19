USE Northwind

---- 01. In ra danh sách nhân viên
SELECT * FROM Employees

---- 02. Tìm những nhân viên có tên bắt đầu bằng chữ A
SELECT * FROM Employees
WHERE FirstName = 'A%' -- 0 dòng, vì sai ý nghĩa và cú pháp

SELECT * FROM Employees
WHERE FirstName LIKE 'A%'

-- In ra tên đầy đủ
SELECT EmployeeID, FirstName + ' ' + LastName AS [FullName], Title
FROM Employees
WHERE FirstName LIKE 'A%'

-- Sử dụng hàm CONCAT(), chỉ hỗ trợ từ SQL Server 2012 trở lên
SELECT EmployeeID, CONCAT(FirstName, ' ', LastName) AS [FullName], Title
FROM Employees
WHERE FirstName LIKE 'A%'

---- 03. Tìm những nhân viên có tên kết thúc bằng chữ A
SELECT EmployeeID, FirstName + ' ' + LastName AS [FullName], Title
FROM Employees
WHERE FirstName LIKE '%a'

---- 04. Tìm những nhân viên tên có 4 kí tự

-- Sử dụng hàm kiểm tra độ dài của chuỗi
SELECT EmployeeID, FirstName + ' ' + LastName AS [FullName], Title
FROM Employees
WHERE LEN(FirstName) = 4

-- Sử dụng toán tử LIKE
SELECT EmployeeID, FirstName + ' ' + LastName AS [FullName], Title
FROM Employees
WHERE FirstName LIKE '____'

---- 05. Xem danh sách các sản phẩm / món đồ đang có
SELECT * FROM Products -- 77 dòng

---- 06. Những sản phẩm có tên bắt đầu bằng 'Ch'
SELECT * FROM Products WHERE ProductName LIKE 'Ch%' -- 6 dòng

-- Trong tên có chứa 'Ch', không quan tâm nằm ở đầu, ở giữa hay ở cuối
SELECT * FROM Products WHERE ProductName LIKE '%Ch%' -- 14 dòng

---- 07. Những sản phẩm trong tên có 5 kí tự
SELECT * FROM Products WHERE ProductName LIKE '_____' -- 3 dòng

----- 08. Những sản phẩm mà từ cuối cùng trong tên có 5 kí tự
SELECT * FROM Products
WHERE ProductName LIKE '% _____' OR ProductName LIKE '_____' -- 14 dòng
