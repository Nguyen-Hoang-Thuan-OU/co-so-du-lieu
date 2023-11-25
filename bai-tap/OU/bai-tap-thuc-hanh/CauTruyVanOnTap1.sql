--Ôn tập câu truy vấn


-- A1. Liệt kê danh sách các nhân viên lập ít hơn 3 đơn hàng.

select e.EmployeeID, LastName, FirstName
from dbo.Employees e, dbo.Orders o
where e.EmployeeID = o.EmployeeID
group by e.EmployeeID, LastName, FirstName
having Count(OrderID) < 3


-- A2. Cho biết khách hàng nào mua nhiều đơn hàng nhất,
------ khách hàng nào mua ít đơn hàng nhất.

(select *
from
	(select top 1 c.CompanyName, COUNT(OrderID) as SLDH
	from orders o, customers c
	where o.CustomerID = c.CustomerID
	group by c.CustomerID, c.CompanyName
	order by COUNT(OrderID) desc) a)
	
union

select *
from
	(select top 1 c.CompanyName, COUNT(OrderID) as SLDH
	from orders o, customers c
	where o.CustomerID = c.CustomerID
	group by c.CustomerID, c.CompanyName
	order by COUNT(OrderID) )b


-- A3. Viết khối lệnh hiển thị tổng số đơn hàng của các khách hàng USA đã đặt, 
------ nếu số đơn hàng ít hơn 1 thì hiện thông báo "số lượng đơn hàng quá ít."

-- Cách 1

select COUNT(OrderID) as SLDH,
	case
		when COUNT(OrderID) < 1 then N'số lượng đơn hàng quá ít'
		else N'số lượng đơn hàng bình thường'
	end as N'Tình Trạng'
from dbo.Customers c, dbo.Orders o
where c.CustomerID = o.CustomerID and c.Country = 'USA'


-- Cách 2

declare @sl int
select @sl = COUNT(OrderID)
	from dbo.Orders o, dbo.Customers c
	where o.CustomerID = c.CustomerID and c.Country = 'USA'
if @sl < 100
	print N'số lượng đơn hàng quá ít' + cast(@sl as nvarchar(10))
else
	print N'số lượng đơn hàng bình thường' + cast(@sl as nvarchar(10))


-- A4. Viết câu lệnh tạo ràng buộc sau trong bảng Orders:
------ Ngày giao hàng phải sau ngày đặt hàng.

alter table dbo.Orders
add constraint chk_OrderDate
check (OrderDate < ShippedDate)


-- A5. Viết khối lệnh hiển thị số đơn hàng nhân viên King Robert đã lập,
------ nếu số đơn hàng ít hơn 3 thì hiện thông báo "số lượng đơn hàng quá ít."



	
-- A6. Viết khối lệnh kiểm tra nhân viên có tên harry potter có trong CSDL chưa, 
------ nếu chưa có thì thêm nhân viên đó vào CSDL.

-- Cách 1

declare @sl int;
select @sl = COUNT(*)
from dbo.Employees
where LastName = 'harry' and FirstName = 'potter'
if @sl = 0
begin
	insert into Employees(LastName, FirstName)
	values('harry', 'potter')
	print 'Them thanh cong'
end

else
	print 'Them that bai'


-- Cách 2

if not exists (select *
				from Employees
				where LastName = 'harry' and FirstName = 'potter'
				
begin
	insert into Employees (LastName, FirstName)
	values ('harry', 'potter')
	print 'Them thanh cong'
end
else
	print 'Them that bai'