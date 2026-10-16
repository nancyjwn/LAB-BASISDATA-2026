set search_path to classicmodels, public;

-- nomor 1
select
	customernumber,
	sum(amount) as "Total setoran",
	count(distinct customernumber) as "Frekuensi Penyetoran",
	max(amount) as "Nilai Setoran terbesar"
from payments
group by customernumber
having count(distinct checknumber) > 4 and round(avg(amount), 2) > 20000; 

-- nomor 2
select
	customernumber,
	sum(amount) as "Total Setoran" from payments
group by customernumber
having sum(amount) > 80000
order by "Total Setoran" desc;

-- nomr 3
select 
	productline,
	count(productcode) as "Jumlah Ragam Produk",
	round (avg(msrp), 2) as "Rata-Rata Harga Jual Ritel",
	string_agg(productname, ', ' order by productname) as "Daftar Nama Produk"
from products
group by productline
having count(productcode) > 10;

-- nomor 4
select reportsto from employees
where reportsto is not null
except 
select employeenumber from employees
where jobtitle like '%VP%' or jobtitle like 'President%';

-- nomor 5
select 
	productcode,
	sum(quantityordered) as "Total Unit Terjual",
	round (avg(priceeach), 2) as "Harga Riil Penjualan"
from orderdetails
where priceeach > 100
group by productcode
having sum(quantityordered) > 50
order by "Total Unit Terjual" desc;

-- nomor 6
select 
	productcode,
	sum(quantityordered) as "Total Keseluruhan Unit yang dipesan",
	sum(quantityordered * priceeach) as "Estimasi Pendapatan Kotor",
	round(avg(priceeach), 2) as "Rata-Rata Harga Riil",
	(max(priceeach) - min(priceeach)) as "Rentang Volatilitas"
from orderdetails
where quantityordered > 20 
group by productcode
having sum(quantityordered * priceeach) > 50000
order by "Estimasi Pendapatan Kotor" desc;

-- nomor 7
(select customernumber from customers
where creditlimit > 80000
intersect 
select customernumber from orders
where status in ('Cancelled', 'On Hold'))
except
select customernumber from  payments
group by customernumber 
having sum(amount) > 100000;

-- study case
select 
	productline, 
	count(quantityinstock) as "Jumlah Lini",
	min(buyprice) as "Harga Tertinggi",
	max(buyprice) as "Harga Terendah",
	round(avg(buyprice), 2) > 50  
from products
group by productline
having count(quantityinstock) >= 5  and avg(buyprice) > 50;



	