USE Northwind

---- 01. In ra danh sách nhân viên
SELECT * FROM Employees

---- 02. Lọc ra những nhân viên chưa xác định được khu vực

-- NULL là trạng thái chứ không phải là giá trị
SELECT * FROM Employees
WHERE Region = 'NULL' -- 0 dòng, vì đây không phải là giá trị

-- NULL không thể tham gia vào toán tử so sánh
SELECT * FROM Employees
WHERE Region = NULL -- 0 dòng, vì đây là toán tử so sánh

-- Sử dụng đúng với tính chất của NULL
SELECT * FROM Employees
WHERE Region IS NULL -- 4 dòng, vì đây là trạng thái

---- 03. Lọc ra những nhân viên đã xác định được khu vực
SELECT * FROM Employees
WHERE Region IS NOT NULL

SELECT * FROM Employees
WHERE NOT (Region IS NULL)

---- 04. Lọc ra những nhân viên với chức danh là Đại diện kinh doanh
----	 và xác định được nơi cư trú
----	 * Đại diện kinh doanh: Sales Representative
SELECT * FROM Employees
WHERE Title = 'Sales Representative' AND Region IS NOT NULL

SELECT * FROM Employees
WHERE Title = 'Sales Representative' AND NOT (Region IS NULL)

---- 05. Liệt kê danh sách khách hàng đến từ Anh, Pháp, Mỹ
----	 và có cả thông tin về số Fax và quốc gia
SELECT * FROM Customers
WHERE Country IN ('UK', 'France', 'USA') AND Fax IS NOT NULL AND Region IS NOT NULL
