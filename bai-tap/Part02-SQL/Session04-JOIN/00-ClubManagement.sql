---- Xoá CSDL Quản lý CLB
DROP DATABASE ClubManagement

---- Tạo mới CSDL Quản lý CLB
CREATE DATABASE ClubManagement

---- Sử dụng CSDL Quản lý CLB
USE ClubManagement

--------------------------------------------------------------------------------

---- Xoá bảng CLB
DROP TABLE Club

---- Tạo mới bảng CLB
CREATE TABLE Club
(
	ClubID char(5) PRIMARY KEY,	-- PK Primary Key - Khóa chính
	ClubName nvarchar(50),
	Hotline varchar(11)
)

---- Thêm dữ liệu vào bảng CLB
INSERT INTO Club
	VALUES('SiTi', N'Cộng đồng Sinh viên Tình nguyện', '090x')
INSERT INTO Club
	VALUES('SkllC', N'Skillcetera', '091x')
INSERT INTO Club
	VALUES('CSG', N'CLB Truyền thông Cóc Sài Gòn', '092x')
INSERT INTO Club
	VALUES('FEV', N'FPT Event Club', '093x')
INSERT INTO Club
	VALUES('FCode', N'FPT Code', '094x')

---- Xem bảng CLB
SELECT * FROM Club

------------------------------------------------------------

---- Xoá bảng Sinh viên
DROP TABLE Student

---- Tao mới bảng Sinh viên
CREATE TABLE Student
(
	StudentID char(8) PRIMARY KEY,	-- PK Primary Key - Khóa chính
	LastName nvarchar(30),
	FirstName nvarchar(10),
	DOB date,
	Address nvarchar(50)	
)

---- Thêm dữ liệu vào bảng Sinh viên
INSERT INTO Student(StudentID, LastName, FirstName)
	VALUES('SE1', N'Nguyễn', N'Một');
INSERT INTO Student(StudentID, LastName, FirstName)
	VALUES('SE2', N'Lê', N'Hai');
INSERT INTO Student(StudentID, LastName, FirstName)
	VALUES('SE3', N'Trần', N'Ba');
INSERT INTO Student(StudentID, LastName, FirstName)
	VALUES('SE4', N'Phạm', N'Bốn');
INSERT INTO Student(StudentID, LastName, FirstName)
	VALUES('SE5', N'Lý', N'Năm');

---- Xem bảng Sinh viên
SELECT * FROM Student

------------------------------------------------------------

---- Xoá bảng Sự đăng ký
DROP TABLE Registration

---- Tạo mới bảng Sự đăng ký
CREATE TABLE Registration
(
	RegID int IDENTITY(1, 1) PRIMARY KEY,	-- PK Primary Key - Khóa chính - Tăng tự động từ 1	      
	StudentID char(8),
	ClubID char(5),    
	JoinedDate date,
	LeavedDate date
	CONSTRAINT FK_Reg_Club FOREIGN KEY (ClubID) REFERENCES Club(ClubID),		-- FK Foreign Key - Khóa ngoại
	CONSTRAINT FK_Reg_Student FOREIGN KEY (StudentID) REFERENCES Student(StudentID)	-- FK Foreign Key - Khóa ngoại
)

---- Thêm dữ liệu vào Sự đăng ký
-- SiTi 3, SkllC 2, CSG 2, FEV 0, FCODE 0

-- SE1 3
INSERT INTO Registration(StudentID, ClubID)
	VALUES('SE1', 'SiTi')
INSERT INTO Registration(StudentID, ClubID)
	VALUES('SE1', 'SkllC')
INSERT INTO Registration(StudentID, ClubID)
	VALUES('SE1', 'CSG')

-- SE2 3
INSERT INTO Registration(StudentID, ClubID)
	VALUES('SE2', 'SiTi')
INSERT INTO Registration(StudentID, ClubID)
	VALUES('SE2', 'SkllC')
INSERT INTO Registration(StudentID, ClubID)
	VALUES('SE2', 'CSG')

-- SE3 1
INSERT INTO Registration(StudentID, ClubID)
	VALUES('SE3', 'SiTi')

-- SE4 0, SE5 0

---- Xem bảng Sự đăng ký
SELECT * FROM Registration

--------------------------------------------------------------------------------

SELECT * FROM Student
SELECT * FROM Club
SELECT * FROM Registration

---- 01. Liệt kê các sinh viên đang theo học
SELECT * FROM Student

---- 02. Liệt kê các sinh viên đang theo học
----	 kèm những CLB đang tham gia
-- Output 1: Mã SV, tên SV, mã CLB
-- Output 2: Mã SV, tên SV, mã CLB, tên CLB

-- Output 1
SELECT s.StudentID, s.FirstName + ' ' + s.LastName AS [Full name], r.ClubID
FROM Student s LEFT OUTER JOIN Registration r
ON s.StudentID = r.StudentID

-- Output 2
SELECT s.StudentID, s.FirstName + ' ' + s.LastName AS [Full name],
       r.ClubID, c.ClubName
FROM Student s LEFT OUTER JOIN Registration r
ON s.StudentID = r.StudentID
LEFT OUTER JOIN Club c ON c.ClubID = r.ClubID

---- 02. In ra thông tin tham gia CLB của các sinh viên
-- Output 1: Mã SV, tên SV, mã CLB, tên CLB, ngày tham gia
SELECT s.StudentID, s.FirstName + ' ' + s.LastName AS [Full name],
       c.ClubID, c.ClubName, r.JoinedDate
FROM Student s FULL OUTER JOIN Registration r
ON s.StudentID = r.StudentID
FULL OUTER JOIN Club c ON c.ClubID = r.ClubID

---- BÀI TẬP VỀ NHÀ

---- 01. Đếm số CLB mà mỗi sinh viên đã tham gia
-- Output: Mã SV, tên SV, số CLB đã tham gia
SELECT s.StudentID, s.FirstName + ' ' + s.LastName AS [Full name],
       COUNT(r.ClubID) AS [Club in total]
FROM Student s FULL JOIN Registration r
ON s.StudentID = r.StudentID
GROUP BY s.StudentID, s.FirstName + ' ' + s.LastName
ORDER BY s.StudentID

---- 02. Sinh viên SE1 đã tham gia bao nhiêu CLB
-- Output: Mã SV, tên SV, số CLB đã tham gia
SELECT s.StudentID, s.FirstName + ' ' + s.LastName AS [Full name],
       COUNT(r.ClubID) AS [Club in total]
FROM Student s FULL JOIN Registration r
ON s.StudentID = r.StudentID
WHERE s.StudentID = 'SE1'
GROUP BY s.StudentID, s.FirstName + ' ' + s.LastName

---- 03. Sinh viên nào tham gia nhiều CLB nhất
SELECT s.StudentID, s.FirstName + ' ' + s.LastName AS [Full name],
       COUNT(r.ClubID) AS [Club in total]
FROM Student s FULL JOIN Registration r
ON s.StudentID = r.StudentID
GROUP BY s.StudentID, s.FirstName + ' ' + s.LastName
HAVING COUNT(r.ClubID) >= ALL (
				SELECT COUNT(r.ClubID)
				FROM Student s FULL JOIN Registration r
				ON s.StudentID = r.StudentID
				GROUP BY s.StudentID
			      )
ORDER BY s.StudentID

---- 04. CLB "Cộng đồng Sinh viên Tình nguyện"
----	 có những SV nào tham gia
----	 (Có thể không sử dụng câu truy vấn lồng)

-- Sử dụng truy vấn lồng
SELECT *
FROM Registration
WHERE ClubID = (
			SELECT ClubID
			FROM Club
			WHERE ClubName = N'Cộng đồng Sinh viên Tình nguyện'
	       )

-- Sử dụng JOIN
SELECT r.*, c.ClubName, c.Hotline
FROM Registration r FULL JOIN Club c
ON r.ClubID = c.ClubID
WHERE c.ClubName = N'Cộng đồng Sinh viên Tình nguyện'

---- 05. Mỗi CLB có bao nhiêu thành viên
-- Output: Mã CLB, tên CLB, số thành viên đã tham gia
SELECT c.ClubID, COUNT(r.StudentID) AS [Students in total]
FROM Registration r FULL JOIN Club c
ON r.ClubID = c.ClubID
GROUP BY c.ClubID

--- 06. CLB nào có đông thành viên nhất
-- Output: Mã CLB, tên CLB, số thành viên đã tham gia
SELECT c.ClubID, c.ClubName,
       COUNT(r.StudentID) AS [Students in total]
FROM Registration r FULL JOIN Club c
ON r.ClubID = c.ClubID
GROUP BY c.ClubID, c.ClubName
HAVING COUNT(r.StudentID) >= ALL (
					SELECT COUNT(r.StudentID)
					FROM Registration r FULL JOIN Club c
					ON r.ClubID = c.ClubID
					GROUP BY c.ClubID
				 )

---- 07. CLB SiTi và CSG có bao nhiêu thành viên
----	 (Đếm riêng cho từng CLB)
-- Output: Mã CLB, tên CLB, số thành viên đã tham gia
SELECT c.ClubID, c.ClubName,
       COUNT(r.StudentID) AS [Students in total]
FROM Registration r FULL JOIN Club c
ON r.ClubID = C.ClubID
WHERE c.ClubID IN ('SiTi', 'CSG')
GROUP BY c.ClubID, c.ClubName

---- 08. Có tổng cộng bao nhiêu lượt SV tham gia CLB
----	 (Tổng lượt tham gia - Mỗi SV có thể gồm nhiều lượt)
SELECT COUNT(StudentID) AS [Students in total]
FROM Registration

