----------------------ĐỀ THI MÁY CHẲN-----------
MÔN: CSDL NÂNG CAO, NGÀY THI: 05/05/2019
MSSV:
HỌ TÊN SV:

-----------------------------------------------------------------------

PHẦN 1: Phân mảnh ngang chính và phân mảnh ngang dẫn xuất (4 điểm)

Câu 1: (2 điểm) Hãy viết 2 Stored procedure tên: 
(SV TỰ ĐẶT TÊN CHO CÁC PHÂN MẢNH NGANG)

-- Tạo PROC TaoPM_Ngang_PhongBan:
USE QLNhanVien
go
CREATE PROC TaoPhanManhPB
AS
	SELECT * INTO PhongBAnHN
	from PhongBan
	WHERE ChiNhanh = N'Hà nội'
	
	SELECT * INTO PhongBanSG
	from PhongBan
	WHERE ChiNhanh = N'Sài gòn'
go

-- Test PROC TaoPM_Ngang_PhongBan:
exec dbo.TaoPhanManhPB

-- Tạo PROC TaoPM_Ngang_NhanVien:
USE QLNhanVien
go
CREATE PROC TaoPM_Ngang_NhanVien
AS
	SELECT * INTO NhanVienHN
	from NhanVien
	WHERE MaPB in (select MaPB from PhongBAnHN)
	
	SELECT * INTO NhanVienSG
	from NhanVien
	WHERE MaPB in (select MaPB from PhongBanSG)
go

-- Test PROC TaoPM_Ngang_NhanVien:
exec TaoPM_Ngang_NhanVien


Câu 2: (2 điểm) Tạo stored procedure tên SuaPB_Ngang:

-- Tạo PROC SuaPB_Ngang:
CREATE PROC SuaPB_Ngang
@MaPB nvarchar (10),
@TenPB nvarchar(50),
@ChiNhanh nvarchar(50)
AS
	IF @MaPB is null
		print N'Không sửa dữ liệu được vì không có giá trị mã phòng ban!' 
	else if @TenPB is null
		print N'Không sửa dữ liệu được vì không có giá trị tên phòng ban!' 
	else if @ChiNhanh is null
		print N'Không sửa dữ liệu được vì không có giá trị Chi nhanh!' 
	else if @ChiNhanh not in (N'Sài gòn', N'Hà nội')
		print N'Không sửa dữ liệu được vì Chi nhánh không hợp lệ!'
	else if not exists (select * from PhongBan where MaPB=@MaPB)
		print N'Không sửa dữ liệu được vì không tìm thấy giá trị mã phòng ban!'
	else
		begin
			update PhongBan
			set TenPB = @TenPB, ChiNhanh = @ChiNhanh
			where MaPB = @MaPB
			print N'Dữ liệu đã được cập nhật'
		end
go


-- Test PROC SuaPB_Ngang:

exec dbo.SuaPB_Ngang null, N'Thiết kế', N'Sài gòn'
exec dbo.SuaPB_Ngang N'PB01', null, N'Sài gòn'
exec dbo.SuaPB_Ngang N'PB01', N'Thiết kế', null
exec dbo.SuaPB_Ngang N'PB01', N'Nghiên cứu', N'Cần thơ'
exec dbo.SuaPB_Ngang N'PB01', N'Nghiên cứu', N'Sài gòn'
exec dbo.SuaPB_Ngang N'PB07', N'Nghiên cứu', N'Sài gòn'
exec dbo.SuaPB_Ngang N'PB07', N'Nghiên cứu', N'Cần thơ'



------------------------------------------------------------------

PHẦN 2: Phân mảnh dọc (4 điểm)

Câu 3: (1 điểm) Hãy viết Stored procedure tên: TaoPM_Doc_PhongBan:
PhongBan_Doc1(MaPB, TenPB)
PhongBan_Doc2(MaPB, ChiNhanh)

-- Tạo PROC TaoPM_Doc_PhongBan:


-- Test PROC TaoPM_Doc_PhongBan:


-Câu 4: (1 điểm) Hãy viết Stored procedure tên: XemPB_Doc:

-- Tạo PROC XemPB_Doc:


-- Test PROC XemPB_Doc:


Câu 5: (2 điểm) Tạo stored procedure tên ThemPB_Doc:

-- Tạo PROC ThemPB_Doc:


-- Test PROC ThemPB_Doc:


---------------------------------------------------


PHẦN 3: Phân mảnh HỖN HỢP (2 điểm)

Câu 6: (1 điểm) Tạo View tên DanhSachTatCaPB_HH:

-- Tạo View DanhSachTatCaPB_HH:


-- Test View DanhSachTatCaPB_HH:


Câu 7: (1 điểm) Tạo stored procedure tên ThemPB_HH:

-- Tạo PROC ThemPB_HH:


-- Test PROC ThemPB_HH:


--ĐỂ CÓ ĐIỂM, CÁC EM NHỚ LƯU FILE SQL NÀY VÀO Ổ S:\
------------------------HẾT-----------------------------------------

