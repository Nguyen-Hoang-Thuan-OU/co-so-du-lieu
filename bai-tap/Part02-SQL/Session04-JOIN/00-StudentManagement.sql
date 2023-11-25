---- Xoá CSDL Quản lý sinh viên
DROP DATABASE StudentManagement

---- Tạo CSDL Quản lý sinh viên
CREATE DATABASE StudentManagement

---- Sử dụng CSDL Quản lý sinh viên
USE StudentManagement

--------------------------------------------------------------------------------

---- Xoá bảng Chuyên ngành
DROP TABLE Major

---- Tạo mới bảng Chuyên ngành
CREATE TABLE Major
(
	MajorID char(2) PRIMARY KEY,	-- PK Primary Key - Khóa chính
	MajorName varchar(30),
	Hotline varchar(11)
)

---- Tạo dữ liệu cho bảng Chuyên ngành
INSERT INTO Major VALUES('SE', 'Software Engineering', '090x')
INSERT INTO Major VALUES('IA', 'Information Assurance', '091x')
INSERT INTO Major VALUES('GD', 'Graphic Design', '092x')
INSERT INTO Major VALUES('JP', 'Japanese', '093x')
INSERT INTO Major VALUES('KR', 'Korean', '094x')

---- Xem dữ liệu trong bảng chuyên ngành
SELECT * FROM Major

------------------------------------------------------------

---- Xoá bảng Chuyên ngành
DROP TABLE Student

---- Tạo mới bảng Sinh viên
CREATE TABLE Student
(
	StudentID char(8) PRIMARY KEY,	-- PK Primary Key - Khóa chính
	LastName nvarchar(30),
	FirstName nvarchar(10),
	DOB date,
	Address nvarchar(50), 
	MajorID char(2) REFERENCES Major(MajorID)	-- FK Foreign Key - Khóa ngoại
)

---- Tạo dữ liệu cho bảng Sinh viên

-- Sinh viên SE
INSERT INTO Student(StudentID, LastName, FirstName, MajorID)
		VALUES('SE1', N'Nguyễn', N'Một', 'SE');
INSERT INTO Student(StudentID, LastName, FirstName, MajorID)
		VALUES('SE2', N'Lê', N'Hai', 'SE');
INSERT INTO Student(StudentID, LastName, FirstName, MajorID)
		VALUES('SE3', N'Trần', N'Ba', 'SE');

-- Sinh viên IA
INSERT INTO Student(StudentID, LastName, FirstName, MajorID)
		VALUES('SE4', N'Phạm', N'Bốn', 'IA');
INSERT INTO Student(StudentID, LastName, FirstName, MajorID)
		VALUES('SE5', N'Lý', N'Năm', 'IA');
INSERT INTO Student(StudentID, LastName, FirstName, MajorID)
		VALUES('SE6', N'Võ', N'Sáu', 'IA');

-- Sinh viên GD
INSERT INTO Student(StudentID, LastName, FirstName, MajorID)
		VALUES('GD7', N'Đinh', N'Bảy', 'GD');
INSERT INTO Student(StudentID, LastName, FirstName, MajorID)
		VALUES('GD8', N'Huỳnh', N'Tám', 'GD');

-- Sinh viên JP
INSERT INTO Student(StudentID, LastName, FirstName, MajorID)
		VALUES('JP9', N'Ngô', N'Chín', 'JP');

---- Xem dữ liệu trong bảng chuyên ngành
SELECT * FROM Student

---- Đừng vội thêm vào để xem FULL OUTER JOIN ra sao
INSERT INTO Student(StudentID, LastName, FirstName, MajorID)
		VALUES('UNK', N'Đặng', N'Mười', NULL);

--------------------------------------------------------------------------------

SELECT * FROM Major
SELECT * FROM Student

---- 01. In ra thông tin chi tiết kèm chuyên ngành của sinh viên

-- In ra thông tin tóm tắt, không kèm chuyên ngành
SELECT * FROM Student

-- Chỉ có thông tin chuyên ngành, không có sinh viên
SELECT * FROM Major

-- Sử dụng JOIN để ghép thêm thông tin theo chiều nganh
SELECT * FROM Student s, Major m
WHERE s.MajorID = m.MajorID

-- Loại bỏ cột MajorID bị thừa
SELECT s.*, m.MajorName, m.Hotline
FROM Student s, Major m
WHERE s.MajorID = m.MajorID

-- Sử dụng cách chuẩn,
-- nhưng vẫn bị mất dữ liệu do đây là INNER JOIN
SELECT s.*, m.MajorName, m.Hotline
FROM Student s INNER JOIN Major m
ON s.MajorID = m.MajorID

---- 02. In ra thông tin chi tiết của sinh viên kèm chuyên ngành,
----	 nhưng chỉ quan tâm đến sinh viên SE và IA
SELECT s.*, m.MajorName, m.Hotline
FROM Student s INNER JOIN Major m
ON s.MajorID = m.MajorID
WHERE s.MajorID IN ('SE', 'IA')

-- Sử dụng thử tích Đềcác
SELECT *
FROM Student s, Major m
WHERE s.MajorID = m.MajorID
      AND s.MajorID IN ('SE', 'IA')

---- 03. In ra thông tin các sinh viên kèm chuyên ngành,
----	 chuyên ngành nào dù không có sinh viên thì vẫn in ra
SELECT *
FROM Student s RIGHT OUTER JOIN Major m
ON s.MajorID = m.MajorID

SELECT s.*, m.*
FROM Major m LEFT OUTER JOIN Student s
ON s.MajorID = m.MajorID

SELECT * FROM Major
SELECT * FROM Student

---- 04. Có bao nhiêu chuyên ngành
SELECT COUNT(*) AS [Majors in total] FROM Major

---- 05. Mỗi chuyên ngành có bao nhiêu sinh viên

-- Đơn giản, nhưng bị thiếu
SELECT MajorID, COUNT(MajorID) AS [Students in total]
FROM Student
GROUP BY MajorID

-- Phức tạp
SELECT m.MajorID, m.MajorName, COUNT(s.StudentID) AS [Students in total]
FROM Student s RIGHT OUTER JOIN Major m
ON s.MajorID = m.MajorID
GROUP BY m.MajorID, m.MajorName

---- 06. Chuyên ngành nào có từ 3 sinh viên trở lên
SELECT m.MajorID, m.MajorName, COUNT(s.StudentID) AS [Students in total]
FROM Student s RIGHT OUTER JOIN Major m
ON s.MajorID = m.MajorID
GROUP BY m.MajorID, m.MajorName
HAVING COUNT(s.MajorID) >= 3

---- 07. Chuyên ngành nào có ít sinh viên nhất
SELECT m.MajorID, m.MajorName, COUNT(s.MajorID) AS [Students in total]
FROM Student s RIGHT OUTER JOIN Major m
ON s.MajorID = m.MajorID
GROUP BY m.MajorID, m.MajorName
HAVING COUNT(s.MajorID) <= ALL (
					SELECT COUNT(s.StudentID)
					FROM Student s RIGHT OUTER JOIN Major m
					ON s.MajorID = m.MajorID
					GROUP BY m.MajorID, m.MajorName
			       )

---- 08. Đếm số sinh viên của chuyên ngành SE
SELECT m.MajorID, m.MajorName, COUNT(s.StudentID) AS [Students in total]
FROM Student s RIGHT OUTER JOIN Major m
ON s.MajorID = m.MajorID
WHERE m.MajorID = 'SE'
GROUP BY m.MajorID, m.MajorName