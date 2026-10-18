
-- 1
select 
	customernumber as "nomor pelanggan",
	sum(amount) as "total setoran",
	count(distinct checknumber) as "jumlah transaksi",
	max(amount) as "setoran terbesar"
from payments
group by customernumber
having count(distinct checknumber) > 4 and
avg(amount) > 20000

--2
select
	customernumber as "nomor pelanggan",
	sum(amount) as "total setoran"
from payments 
group by customernumber
having sum(amount) > 80000
order by "total setoran" desc

-- 3
select
	productline as "kategori barang",
	count(productcode) as "jumlah produk",
	round(avg(msrp),2) as "rata rata harga ecerang",
	string_agg(productname, ', ' order by productname) as "daftar nama produk"
from products
group by productline
having count(productcode) > 10

-- 4
select
	reportsto as "nomor staff"
from employees
where reportsto is not null
except
select
	employeenumber as "nomor staff"
from employees
where jobtitle = 'President'
or jobtitle like 'VP%'

-- 5
select
	productcode as "kode barang",
	sum(quantityordered) as "total terjual",
	round(avg(priceeach),2) as "rata rata penjualan"
from orderdetails
where priceeach > 100
group by productcode
having sum(quantityordered) > 50
order by "total terjual" desc

-- 6
select
	productcode as "kode barang",
	sum(quantityordered) as "total barang dipesan",
	sum(quantityordered * priceeach) as "pendapatan kotor",
	round(avg(priceeach),2) as "rata rata harga",
	(max(priceeach) - min(priceeach)) as "rentang harga"
from orderdetails
where quantityordered > 20
group by productcode
having sum(quantityordered * priceeach) > 50000
order by "pendapatan kotor" desc

-- 7
(
select
	customernumber as "nomor pelanggan"
from customers
where creditlimit > 80000
intersect
select
	customernumber as "nomor pelanggan"
from orders
where status in ('Cancelled','On Hold')
)
except
select 
	customernumber as "nomor pelanggan"
from payments
group by customernumber
having sum(amount) > 100000

-- livecoding
select
	ordernumber,
	count(distinct productcode) as produk_unik,
	sum(quantityordered) as total_unit_pesanan,
	sum(priceeach * quantityordered) as total_nilai_pesanan
from orderdetails
group by ordernumber
having sum(priceeach * quantityordered) > 10000 and count(distinct productcode) >= 3

select
	ordernumber,
from orderdetails
except
select
	ordernumber,
from orders
where is not 
	

select * from orderdetails

