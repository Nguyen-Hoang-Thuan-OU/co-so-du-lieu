USE Northwind

---- 01. Liệt kê danh sách nhân viên
SELECT * FROM Employees

-- Tuy có 9 người khác nhau, nhưng chỉ có 4 danh xưng
SELECT TitleOfCourtesy FROM Employees

SELECT DISTINCT TitleOfCourtesy FROM Employees

SELECT DISTINCT EmployeeID, TitleOfCourtesy FROM Employees

---- 02. In ra thông tin của khách hành
SELECT * FROM Customers -- 92 dòng (Có 1 dòng tự thêm vào)

---- 03. Có bao nhiêu quốc gia xuất hiện trong thông tin khách hàng
SELECT Country FROM Customers

SELECT DISTINCT Country FROM Customers
