---- Tạo mới cả một cơ sở dữ liệu
CREATE DATABASE Cartesian

USE Cartesian

---- Tạo mới một bảng "Từ điển tiếng Anh"
CREATE TABLE EnDict
(
	Nmbr int,
	EnDesc varchar(30)
)

---- Xoá bảng
DROP TABLE EnDict

SELECT * FROM EnDict

---- Chèn dữ liệu số đếm tiếng Anh
INSERT INTO EnDict VALUES (1, 'One')
INSERT INTO EnDict VALUES (2, 'Two')
INSERT INTO EnDict VALUES (3, 'Three')

-- Bổ sung thêm cho OUTER JOIN
INSERT INTO EnDict VALUES (4, 'Four')

---- Tạo mới một bảng "Từ điển tiếng Việt"
CREATE TABLE VnDict
(
	Nmbr int,
	VnDesc nvarchar(30)
)

DROP TABLE VnDict

INSERT INTO VnDict VALUES (1, N'Một')
INSERT INTO VnDict VALUES (2, N'Hai')
INSERT INTO VnDict VALUES (3, N'Ba')

-- Bổ sung thêm cho OUTER JOIN
INSERT INTO VnDict VALUES (5, N'Năm')

SELECT * FROM VnDict
SELECT * FROM EnDict

---- Tạm thời tạo ra một bảng mới với CROSS JOIN
SELECT * FROM VnDict, EnDict

-- Tham chiếu cột qua tên bảng
SELECT * FROM VnDict, EnDict
ORDER BY VnDict.Nmbr

SELECT VnDict.Nmbr, VnDict.VnDesc, EnDict.Nmbr, EnDict.EnDesc
FROM VnDict, EnDict
ORDER BY VnDict.Nmbr

-- Tham chiếu cột qua tên giả (alias)
SELECT * FROM VnDict vn, EnDict en
ORDER BY vn.Nmbr

SELECT vn.Nmbr, vn.VnDesc, en.EnDesc
FROM VnDict vn, EnDict en
ORDER BY vn.Nmbr

SELECT vn.*, en.EnDesc
FROM VnDict vn, EnDict en
ORDER BY vn.Nmbr

-- Cú pháp chuẩn và tường minh
SELECT *
FROM VnDict CROSS JOIN EnDict
ORDER BY VnDict.Nmbr

---- Biến đổi từ CROSS JOIN thành INNER JOIN
SELECT *
FROM VnDict vn, EnDict en
WHERE vn.Nmbr = en.Nmbr