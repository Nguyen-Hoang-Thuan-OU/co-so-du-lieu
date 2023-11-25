-- Loại 2: MAKE-TABLE QUERY


-- 1. Tạo một query đặt tên là TimKhachHangMy (tìm khách hàng Mỹ).
----- Khi chạy, query này sẽ tạo ra một table mới có tên CacKhachHangMy,
----- lấy tất cả các field của bảng Customers.

select * into KhachHangMy
from dbo.Customers
where Country = 'USA'


-- 2. Tạo một query đặt tên là Tim5NhanVienGioi (tìm 5 nhân viên giỏi).
----- Khi chạy, query này sẽ tạo ra một table mới có tên 5NhanVienGioi.
----- Bảng này liệt kê danh sách 5 nhân viên phụ trách nhiều đơn đặt hàng nhất.
----- Các thông tin gồm: mã nhân viên, họ và tên nhân viên (1 cột),
----- tổng số lượng các đơn đặt hàng đã phụ trách.
----- Danh sách sắp xếp giảm dần theo cột tổng số lượng các đơn đặt hàng đã phụ trách.

select top 5 e.EmployeeID, FirstName + ' ' + LastName as N'Họ và tên',
			count(OrderID) as N'Số lượng đơn hàng' into NhanVienGioi
from dbo.Employees e, dbo.Orders o
where e.EmployeeID = o.EmployeeID
group by e.EmployeeID, FirstName, LastName
order by COUNT(o.OrderID) desc


-- 3. Tạo một query đặt tên là Tim10KhachHang (tìm 10 khách hàng).
----- Khi chạy, query này sẽ tạo ra một table mới có tên 10KhachHang.
----- Bảng này liệt kê danh sách 10 khách hàng có nhiều đơn đặt hàng nhất.
----- Các thông tin gồm: mã khách hàng, tên công ty, địa chỉ đầy đủ
----- (1 cột gồm địa chỉ, thành phố và quốc gia), và tổng số lượng các đơn đặt hàng đã đặt.
----- Danh sách sắp xếp giảm dần theo cột tổng số lượng các đơn đặt hàng đã đặt.

select top 5 c.CustomerID, CompanyName, Address + ' ' + Country as N'Địa chỉ',
			count(OrderID) as N'Số lượng đơn hàng' into KhachHang
from dbo.Customers c, dbo.Orders o
where c.CustomerID = o.CustomerID
group by c.CustomerID, CompanyName, Address, Country
order by COUNT(o.OrderID) desc


-- 4. Tạo một query đặt tên là TimTop5QGMuaHang (tìm top 5 quốc gia mua hàng).
----- Khi chạy, query này sẽ tạo ra một table mới có tên Top5QGMuaHang.
----- Bảng này liệt kê danh sách top 5 quốc gia có khách hàng mua nhiều sản phẩm nhất.
----- Gợi ý: (Count(ProductID).

select top 5 c.Country, COUNT(p.ProductID) as N'Số lượng sản phẩm đã mua' into Top5QGMuaHang
from dbo.Customers c, dbo.Orders o, [Order Details] d, dbo.Products p
where c.CustomerID = o.CustomerID and o.OrderID = d.OrderID
		and d.ProductID = p.ProductID
group by c.Country
order by COUNT(p.ProductID) desc


-- 5. Tạo một query đặt tên là Tim5QGItMuaHang (tìm 5 quốc gia ít mua hàng).
----- Khi chạy, query này sẽ tạo ra một table mới có tên NamQGItMuaHang.
----- Bảng này liệt kê danh sách 5 quốc gia có khách hàng mua ít sản phẩm nhất.
----- Gợi ý: (Count(ProductID).select top 5 c.Country, COUNT(p.ProductID) as N'Số lượng sản phẩm đã mua' into QGItMuaHang
from dbo.Customers c, dbo.Orders o, [Order Details] d, dbo.Products p
where c.CustomerID = o.CustomerID and o.OrderID = d.OrderID
		and d.ProductID = p.ProductID
group by c.Country
order by COUNT(p.ProductID) asc-- Loại 3: UPDATE QUERY-- 1. Hãy tạo một query đặt tên là SuaTenQuocGia1 (sửa tên quốc gia)
----- để khi chạy query này sẽ sửa lại tên quốc gia trong bảng CUSTOMERS:
----- “USA” sửa thành “Mỹ”. Tên các quốc gia khác vẫn giữ nguyên.

select * into SuaTenQuocGia1
from dbo.Customers
update SuaTenQuocGia1
set country = 'My'
where country = 'USA'

select * from SuaTenQuocGia1


-- 2. Hãy tạo một query đặt tên là SuaTenQuocGia2 (sửa tên quốc gia)
----- để khi chạy query này sẽ sửa lại tên quốc gia trong bảng CUSTOMERS:
----- “Germany” sửa thành “Đức” và “France” sửa thành “Pháp”.
----- Tên các quốc gia khác vẫn giữ nguyên.

select * into SuaTenQuocGia2
from dbo.Customers
update SuaTenQuocGia2
set country = (case when country = 'Germany' then 'Duc'
				else 'Phap'
				end)
where country in ('Germany', 'France')

select * from SuaTenQuocGia2


-- 3. Hãy tạo một query đặt tên là SuaTenQuocGia3 (sửa tên quốc gia)
----- để khi chạy query này sẽ sửa lại tên quốc gia trong 2 bảng
----- CUSTOMERS và SUPPLIERS: “Germany” sửa thành “Đức” và
----- “France” sửa thành “Pháp”. Tên các quốc gia khác vẫn giữ nguyên.




-- 4. Hãy tạo một query đặt tên là SuaTenLoaiSP (sửa tên loại sản phẩm)
----- để khi chạy query này sẽ sửa tên loại sản phẩm trong bảng LOAISANPHAM:
----- “Beverages” sửa thành “nước giải khát” và “Condiments” sửa thành “gia vị”.
----- Tên các loại sản phẩm khác vẫn giữ nguyên.




-- 5. Hãy tạo một query đặt tên là SuaTenLoaiSP (sửa tên loại sản phẩm)
----- để khi chạy query này sẽ sửa tên loại sản phẩm trong bảng LOAISANPHAM:
----- “Confections” sửa thành “bánh kẹo” và “Seafood” sửa thành “hải sản”.
----- Tên các loại sản phẩm khác vẫn giữ nguyên.




-- 6. Hãy tạo một query đặt tên là SuaPostalCode (sửa mã bưu điện)
----- để khi chạy query này sẽ sửa mã bưu điện của các khách hàng
----- Germany: sửa 2 số đầu thành 18. Mã bưu điện của các khách hàng quốc gia khác giữ nguyên.