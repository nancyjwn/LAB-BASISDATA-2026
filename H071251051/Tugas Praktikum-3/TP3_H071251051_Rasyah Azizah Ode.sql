set search_path to classicmodels, public;

-- nomor 1
select 
 	ordernumber, 
 	upper(productcode) as "Kode Produk", 
	quantityordered, priceeach from orderdetails
where (quantityordered between 20 and 50 or priceeach < 30) and left(productcode, 3) = 'S18'
order by quantityordered desc;

-- nomor 2
select 
	customernumber, 
	customername, 
	country, 
	creditlimit, 
	concat(contactfirstname, ' ', contactlastname) as "Nama Kontak", (creditlimit - 10000) as "Selisih Kredit" from customers
where (country = 'USA' or country = 'Canada' or country = 'France') and creditlimit > 30000
order by creditlimit desc;

-- nomor 3
select
	productcode,
	productname,
	buyprice,
	msrp,
Greatest (buyprice, msrp) as "Harga Tertinggi", least (buyprice, msrp) as "Harga Terendah" from products
where productname ilike '%car%';

-- nomor 4
select ordernumber, orderdate, shippeddate, extract(year from orderdate) as "Tahun", extract(month from orderdate) as "Bulan", (shippeddate - orderdate) as "Lama Pengiriman", age(shippeddate, orderdate) as "Interval Pengiriman", current_date as "Tanggal Laporan", current_time as "Waktu Laporan" from orders 
where shippeddate is not null;

-- nomor 5
SELECT ordernumber, orderdate, shippeddate, 
	orderdate + INTERVAL '10 days' AS "Estimasi Kirim", 
	COALESCE(shippeddate, orderdate), 
	AGE(shippeddate, orderdate) AS "Selisih Waktu" FROM orders
WHERE comments ILIKE '%customer%' 
	AND EXTRACT(MONTH FROM orderdate) BETWEEN 10 AND 12 
	AND ordernumber %2=1 
ORDER BY orderdate DESC; 

-- study case
select productcode, 
	productname, 
	buyprice, 
	Greatest(buyprice, 100) AS "Harga Tertinggi", 
	least(buyprice, 50) as "Harga Terendah" 
from classicmodels.products
WHERE buyprice NOT between 50 and 100
ORDER BY buyprice desc;
	
