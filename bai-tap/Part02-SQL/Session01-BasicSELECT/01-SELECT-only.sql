-- Chọn cơ sở dữ liệu để sử dụng
-- (Tại một thời điểm, chỉ có thể sử dụng một CSDL)
USE Northwind

-- Xem thông tin của các khách hàng
SELECT * FROM Customers

-- Xem thông tin của các nhân viên
SELECT * FROM Employees

--------------------------------------------------------------------------------

---- 01. Lấy ngày và giờ hiện tại
SELECT GETDATE()

SELECT GETDATE() AS [Hôm nay là ngày]

SELECT GETDATE() AS HômNayLàNgày

---- 02. Bây giờ tháng mấy rồi hỡi em?
SELECT MONTH(GETDATE()) AS [Bây giờ tháng mấy?]

---- 03. Trị tuyệt đối của (-5) là bao nhiêu?
SELECT ABS(-5) AS [Trị tuyệt đối của (-5) là]

---- 04. Kết quả của 5 + 5 là bao nhiêu?
SELECT 5 + 5 [Kết quả của 5 + 5 là]

---- 05. In ra tên của mình
SELECT N'Nguyễn Hoàng Thuận' AS [My fullname is]

SELECT N'Nguyễn' + N' Hoàng Thuận' AS [My fullname is]

---- 06. Tính tuổi
SELECT YEAR(GETDATE()) - 2000 AS [My age is]

SELECT N'Nguyễn Hoàng Thuận - ' + CONVERT(VARCHAR, YEAR(GETDATE()) - 2000) + ' years old'
AS [My profile]

SELECT N'Nguyễn Hoàng Thuận - ' + CAST(YEAR(GETDATE()) - 2000 AS VARCHAR) + ' years old'
AS MyProfile

---- 07. Phép nhân hai số
SELECT 10 * 10 AS [Kết quả của 10 x 10 là]