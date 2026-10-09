
-- 1
select 
	ordernumber, 
	upper(productcode) as "Kode Produk",
	quantityordered,
	priceeach 
	from orderdetails
	where
		(quantityordered between 20 and 50
		or priceeach < 30)
		and left(productcode,3) = 'S18'
		order by quantityordered desc;

-- 2
select 
	customernumber,
	customername,
	country,
	concat(contactfirstname, ' ', contactlastname) as "Nama Kontak",
	creditlimit,
	(creditlimit - 10000) as "Selisih Kredit"
	from customers
	where 
		(country = 'USA'
		or country = 'Canada'
		or country = 'France')
		and creditlimit > 30000
		order by creditlimit desc;

-- 3
select 
	productcode,
	productname,
	buyprice,
	msrp,
	greatest(buyprice,msrp) as "Harga Tertinggi",
	least(buyprice,msrp) as "Harga Terendah"
	from products
	where
		productname ilike '%car%';

-- 4
select 
	ordernumber,
	orderdate,
	shippeddate,
	extract(year from orderdate) as "Tahun",
	extract(month from orderdate) as "Bulan",
	shippeddate - orderdate as "Lama Pengiriman",
	age(shippeddate,orderdate) as "Interval Pengiriman",
	current_date as "Tanggal Laporan",
	current_time as "Waktu Laporan"
	from orders
	where
		shippeddate is not null;

-- 5
select
	ordernumber,
	orderdate,
	shippeddate,
	orderdate + interval '10 days' as "Estimasi Kirim",
	coalesce(shippeddate,orderdate + interval '10 days') as "Tanggal Aktual",
	age(shippeddate,orderdate) as "Selisih Waktu"
	from orders
	where
		comments ilike '%customer%'
		and extract(month from orderdate) between 10 and 12
		and ordernumber % 2 != 0
		order by orderdate desc; 


-- livecoding
select customernumber, customername, creditlimit from customers where customername ilike '%a%' and creditlimit between 50000 and 150000 order by creditlimit desc;
