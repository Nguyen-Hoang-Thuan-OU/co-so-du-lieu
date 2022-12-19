---- Tạo một CSDL lớn
CREATE DATABASE DBDesign_OneTable

USE DBDesign_OneTable

---- Xoá bảng StudentV1
DROP TABLE StudentV1

---- Tạo cấu trúc bảng
---- để lưu trữ hồ sơ sinh viên, bao gồm:
-- Mã số (để phân biệt giữa các sv với nhau)
-- Tên
-- Năm sinh
-- Địa chỉ

-- Tạo bảng nhưng chưa gài ràng buộc
CREATE TABLE StudentV1
(
	StudentID char(8),
	LastName nvarchar(40),
	FirstName nvarchar(10),
	DOB datetime,
	[Address] nvarchar(50)
)

SELECT * FROM StudentV1

---- Đưa dữ liệu vào bảng StudentV1

-- Trường hợp 1: Đưa vào đủ thông tin vào các cột
INSERT INTO StudentV1
	VALUES ('SE123456', N'Nguyễn', N'An', '2003-01-01', N'... TP.Hồ Chí Minh')

-- Trường hợp 2: Một số cột chưa có dữ liệu
--		 (Được quyền bỏ trống nếu cột được phép trống)
INSERT INTO StudentV1
	VALUES ('SE123457', N'Lê', N'Bình', '2003-02-01', NULL)

-- Giá trị bên địa chỉ trong là NULL,
-- không còn là trạng thái NULL
INSERT INTO StudentV1
	VALUES ('SE123458', N'Võ', N'Cường', '2003-02-01', N'NULL')

-- Chỉ định cột cần nhập giá trị,
-- những cột còn lại tự động gán trạng thái NULL
-- (nếu được cho phép)
INSERT INTO StudentV1 (StudentID, LastName, FirstName)
	VALUES ('SE123459', N'Trần', N'Dũng')

-- Được phép thay đổi thứ tự của cột và thứ tự nhập giá trị
INSERT INTO StudentV1 (LastName, FirstName, StudentID)
	VALUES (N'Phạm', N'Em', 'SE123460')

-- Nguy hiểm: Có sinh viên với tất cả thông tin đều bỏ trống
INSERT INTO StudentV1 (LastName, FirstName, StudentID)
	VALUES (NULL, NULL, NULL)

SELECT * FROM StudentV1

-- Nguy hiểm: Có hai sinh viên bị trùng MSSV
INSERT INTO StudentV1 (LastName, FirstName, StudentID)
	VALUES (N'Đỗ', N'Giang', 'SE123460')


---- Xoá bảng StudentV2
DROP TABLE StudentV2

-- Tạo bảng có gài thêm ràng buộc
CREATE TABLE StudentV2
(
	StudentID char(8) PRIMARY KEY,
	LastName nvarchar(40) NOT NULL,
	FirstName nvarchar(10) NOT NULL,
	DOB datetime,
	[Address] nvarchar(50)
)

SELECT * FROM StudentV2

---- Đưa dữ liệu vào bảng StudentV2

-- Đúng định dạng
INSERT INTO StudentV2
	VALUES ('SE123456', N'Nguyễn', N'An', '2003-01-01', N'... TP.Hồ Chí Minh')

-- Thử nhập giá trị NULL trên những cột cấm NULL
INSERT INTO StudentV2 (StudentID, LastName, FirstName)
	VALUES (NULL, NULL, NULL)

-- Thử nhập trùng khoá chính
INSERT INTO StudentV2
	VALUES ('GD123456', N'Lê', N'Bình', '2003-01-01', N'... TP.Hồ Chí Minh')

-- Trống những cột được phép trống
INSERT INTO StudentV2
	VALUES ('SE123457', N'Võ', N'Cường', NULL, NULL)

INSERT INTO StudentV2 (StudentID, LastName, FirstName)
	VALUES ('SE123458', N'Trần', N'Dũng')

SELECT * FROM StudentV2


---- Xoá bảng StudentV3
DROP TABLE StudentV3

-- Thiết kế thừa từ khoá (vì đã được cài mặc định)
CREATE TABLE StudentV3
(
	StudentID char(8) NOT NULL PRIMARY KEY,
	LastName nvarchar(40) NOT NULL,
	FirstName nvarchar(10) NOT NULL,
	DOB datetime NULL,
	[Address] nvarchar(50) NULL
)

SELECT * FROM StudentV3


---- Xoá bảng StudentV4
DROP TABLE StudentV4

-- Khai báo NOT NULL trước,
-- sau đó mới khai báo là khoá chính
-- (Cách này sẽ tiện lợi cho việc khai báo
--  khi có đến hai cột cùng làm khoá chính)
CREATE TABLE StudentV4
(
	StudentID char(8) NOT NULL,
	LastName nvarchar(40) NOT NULL,
	FirstName nvarchar(10) NOT NULL,
	DOB datetime NULL,
	[Address] nvarchar(50) NULL,
	
	PRIMARY KEY(StudentID) -- Database Engine
			       -- sẽ tự đặt tên cho khoá chính
)

SELECT * FROM StudentV4

INSERT INTO StudentV4
	VALUES ('SE123456', N'Nguyễn', N'An', '2003-01-01', N'... TP.Hồ Chí Minh')


---- Xoá bảng StudentV5
DROP TABLE StudentV5

---- Được tạo và chuyển đổi từ ERD bằng công cụ tự động
---- trong phần mềm Visual Paradigm
CREATE TABLE StudentV5 (
  StudentID char(8) NOT NULL, 
  LastName  varchar(50) NOT NULL, 
  FirstName varchar(50) NOT NULL, 
  PRIMARY KEY (StudentID)
);

SELECT * FROM StudentV5


---- Xoá bảng StudentV6
DROP TABLE StudentV6

-- Đặt tên tuỳ chỉnh cho ràng buộc khoá chính
CREATE TABLE StudentV6
(
	StudentID char(8) NOT NULL,
	LastName nvarchar(40) NOT NULL,
	FirstName nvarchar(10) NOT NULL,
	DOB datetime NULL,
	[Address] nvarchar(50) NULL,
	
	--PRIMARY KEY(StudentID) -- Database Engine
				 -- sẽ tự đặt tên cho khoá chính
	CONSTRAINT PK_STUDENTV6 PRIMARY KEY (StudentID)
)


---- Xoá bảng StudentV7
DROP TABLE StudentV7

-- Tách việc gài ràng buộc sang một nơi riêng
CREATE TABLE StudentV7
(
	StudentID char(8) NOT NULL,
	LastName nvarchar(40) NOT NULL,
	FirstName nvarchar(10) NOT NULL,
	DOB datetime NULL,
	[Address] nvarchar(50) NULL,
	
	--PRIMARY KEY(StudentID) -- Database Engine
				 -- sẽ tự đặt tên cho khoá chính
	--CONSTRAINT PK_STUDENTV7 PRIMARY KEY (StudentID)
)

-- Điều chỉnh cấu trúc của bảng StudentV7
-- để thêm ràng buộc khoá chính
ALTER TABLE StudentV7
ADD CONSTRAINT PK_STUDENTV7 PRIMARY KEY (StudentID)

-- Điều chỉnh cấu trúc của bảng StudentV7
-- để xoá ràng buộc khoá chính
ALTER TABLE StudentV7
DROP CONSTRAINT PK_STUDENTV7



