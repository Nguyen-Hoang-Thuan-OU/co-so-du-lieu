USE Cartesian

---- 01. Liệt kê các cặp từ điển tiếng Anh-Việt
SELECT * FROM EnDict e, VnDict v
WHERE e.Nmbr = v.Nmbr

SELECT *
FROM EnDict e INNER JOIN VnDict v
ON e.Nmbr = v.Nmbr

SELECT *
FROM EnDict e JOIN VnDict v
ON e.Nmbr = v.Nmbr

---- 02. Đi tìm tung tích của 4-Four và 5-Năm

-- Sử dụng tích Đềcác
SELECT * FROM EnDict e, VnDict v

-- Xem lại hai bảng
SELECT * FROM EnDict
SELECT * FROM VnDict

---- 03. Lấy tiếng Anh để làm chuẩn,
----	 tìm các nghĩa tiếng Việt tương đương,
----	 nếu không có thì vẫn phải hiển thị rỗng
SELECT *
FROM EnDict e LEFT OUTER JOIN VnDict v
ON e.Nmbr = v.Nmbr

SELECT *
FROM EnDict e LEFT JOIN VnDict v
ON e.Nmbr = v.Nmbr

---- 04. Lấy tiếng Việt để làm chuẩn
SELECT *
FROM VnDict v LEFT OUTER JOIN EnDict e
ON v.Nmbr = e.Nmbr

-- Vẫn lấy tiếng việt làm mốc,
-- nhưng lại để tiếng Việt ở phía bên phải
SELECT *
FROM EnDict e RIGHT JOIN VnDict v
ON e.Nmbr = v.Nmbr

---- 05. Bên cạnh phần chung,
----	 lấy luôn phần riêng của cả hai bên
SELECT *
FROM EnDict e FULL OUTER JOIN VnDict v
ON e.Nmbr = v.Nmbr

SELECT *
FROM EnDict e FULL JOIN VnDict v
ON e.Nmbr = v.Nmbr

---- 06. In ra bộ từ điển Anh Việt
----	 (với tiếng Anh làm chuẩn)
----	 của những con số từ 3 trở lên
SELECT *
FROM EnDict e LEFT JOIN VnDict v
ON e.Nmbr = v.Nmbr
WHERE e.Nmbr >= 3 -- có 4

SELECT *
FROM EnDict e LEFT JOIN VnDict v
ON e.Nmbr = v.Nmbr
WHERE v.Nmbr >= 3 -- mất 4

---- 07. In ra bộ từ điển Anh Việt / Việt Anh
----	 của những con số từ 3 trở lên
SELECT *
FROM EnDict e FULL JOIN VnDict v
ON e.Nmbr = v.Nmbr
WHERE e.Nmbr >= 3 -- có 4, mất 5

SELECT *
FROM EnDict e FULL JOIN VnDict v
ON e.Nmbr = v.Nmbr
WHERE v.Nmbr >= 3 -- có 5, mất 4

SELECT *
FROM EnDict e FULL JOIN VnDict v
ON e.Nmbr = v.Nmbr
WHERE e.Nmbr >= 3 OR v.Nmbr >= 3 -- có đầy đủ
