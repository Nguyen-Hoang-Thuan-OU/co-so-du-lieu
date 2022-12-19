USE Northwind

---- Tạo mới một bảng tên là Num có một cột tên là Numbr
---- và bên trong chứa một loạt các dòng số nguyên
CREATE TABLE Num
(
	Numbr int
)

---- Kiểm tra xem đã tạo bảng thành công hay chưa
SELECT * FROM Num

---- Đưa dữ liệu vào bảng
INSERT INTO Num values (1)
INSERT INTO Num values (1)
INSERT INTO Num values (2)
INSERT INTO Num values (9)
INSERT INTO Num values (5)
INSERT INTO Num values (100)
INSERT INTO Num values (101)

---- 01. In ra những số > 5
SELECT * FROM Num WHERE Numbr > 5

---- 02. In ra số lớn nhất trong các số đã nhập

-- Biết trước mới làm vậy
SELECT * FROM Num WHERE Numbr = 101

-- Chuẩn chỉ
					-- Danh sách các số nguyên tố
SELECT * FROM Num WHERE Numbr >= ALL (SELECT * FROM Num)

---- 03. In ra số nhỏ nhất trong các số đã nhập
SELECT * FROM Num WHERE Numbr <= ALL (SELECT * FROM Num)

SELECT * FROM Num WHERE Numbr > ALL (SELECT * FROM Num)	-- Rỗng

---- 04. Nhân viên nào lớn tuổi nhất

-- So sánh theo năm sinh (Năm sinh càng nhỏ thì càng lớn tuổi)
SELECT YEAR(GETDATE()) - YEAR(BirthDate) AS Age, *
FROM Employees
WHERE BirthDate <= ALL (SELECT BirthDate FROM Employees)

-- So sánh theo tuổi
SELECT YEAR(GETDATE()) - YEAR(BirthDate) AS Age, *
FROM Employees
WHERE YEAR(GETDATE()) - YEAR(BirthDate)
	>= ALL (
			SELECT YEAR(GETDATE()) - YEAR(BirthDate)
			FROM Employees
	       )

---- 05. Đơn hàng nào có trọng lượng nặng nhất
SELECT * FROM orders
--ORDER BY Freight
WHERE Freight >= ALL (SELECT Freight FROM orders)