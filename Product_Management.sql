use master
go

create database db_proj1
go

use db_proj1
go

use db_proj1
create table product
(
	prodId int primary key,
	prodName varchar(30),
	qty int,
	price decimal(18, 2),
	vat decimal(18, 2),
	totalPrice as (qty * price) + (qty * price * vat)/100
)
go

create table list_sales_details
(
	prodId int,
	prodName varchar(30),
	qty int,
	price decimal(18, 2),
	vat decimal(18, 2),
	totalPrice as (qty * price) + (qty * price * vat)/100
)
go


insert into product values (1, 'Rolex Watch', 40, 20000, 14),
						   (2, 'Polo T-shirt', 30, 850, 5),
						   (3, 'Denim Jacket', 20, 1200, 10),
						   (4, 'Fogg', 35, 450, 2),
						   (5, 'Key Board', 25, 1250, 15),
						   (6, 'EarBuds', 50, 1600, 10),
						   (7, 'Face Wash', 40, 500, 12),
						   (8, 'Calculator', 10, 350, 13)
go


create procedure sp_prodBuy
@prodid int,
@prodname varchar(30),
@qty int,
@price decimal(18, 2),
@vat decimal(18, 2),
@tablename varchar(30),
@operationame varchar(30)
AS
Begin
	if exists( select * from product where qty>=@qty)
	BEGIN
		if(@tablename='Product' and @operationame='buy')
		begin
			update product
			set qty = qty - @qty
			where prodId=@prodid and qty>=@qty
			
			if exists( select * from product where qty-@qty >= @qty)
			begin
				Insert into list_sales_details
				values(@prodId, @prodname, @qty, @price, @vat)
			end
		end
	END
End
go

EXEC sp_prodBuy 1, 'Rolex Watch', 3, 20000, 15, 'product', 'buy'


EXEC sp_prodBuy 4, 'Fogg', 3, 450, 2, 'product', 'buy'
EXEC sp_prodBuy 4, 'Fogg', 34, 450, 2, 'product', 'buy'


EXEC sp_prodBuy 1, 'Rolex Watch', 45, 20000, 15, 'product', 'buy'
go


select * from product
select * from list_sales_details
go


truncate table product
truncate table list_sales_details
go

