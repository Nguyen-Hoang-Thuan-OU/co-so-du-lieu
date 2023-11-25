USE Cartesian

---- CROSS JOIN - tích Đềcác
SELECT * FROM VnDict, EnDict

-- Cú pháp chuẩn
SELECT * FROM VnDict CROSS JOIN EnDict

---- Kết hợp thêm mệnh đề WHERE
---- để trở thành INNER JOIN
SELECT * FROM VnDict, EnDict
WHERE VnDict.Nmbr = EnDict.Nmbr

-- Đặt tên giả (Alias)
SELECT * FROM VnDict vn, EnDict en
WHERE vn.Nmbr = en.Nmbr

-- Cú pháp chuẩn
SELECT * FROM VnDict INNER JOIN EnDict
ON VnDict.Nmbr = EnDict.Nmbr

SELECT * FROM VnDict JOIN EnDict
ON VnDict.Nmbr = EnDict.Nmbr

---- NON-EQUI JOIN của INNER JOIN
SELECT * FROM EnDict en, VnDict vn
WHERE en.Nmbr > vn.Nmbr

SELECT * FROM EnDict en, VnDict vn
WHERE en.Nmbr != vn.Nmbr

SELECT * FROM EnDict en INNER JOIN VnDict vn
ON en.Nmbr != vn.Nmbr