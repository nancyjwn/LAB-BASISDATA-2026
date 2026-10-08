
SET search_path TO classicmodels, public;

-- Soal 1
SELECT ordernumber,
	UPPER(productcode) AS "Kode Produk",
	quantityordered,
	priceeach
FROM orderdetails
WHERE (quantityordered BETWEEN 20 AND 50 OR priceeach < 30 )AND
	LEFT(productcode, 3) = 'S18'
ORDER BY quantityordered DESC;


-- Soal 2
SELECT customerNumber,
    customerName,
    country,
    CONCAT(contactFirstName, ' ', contactLastName) AS "Nama Kontak",
    creditLimit,
    (creditLimit - 10000) AS "Selisih Kredit"
FROM customers
WHERE (country ='USA' OR country = 'Canada' OR country = 'France')
	AND creditLimit > 30000
ORDER BY creditLimit DESC;


-- Soal 3
SELECT productcode,
	productname,
	buyprice,
	msrp, 
	GREATEST(buyprice,msrp) AS "Harga Tertinggi", 
	LEAST(buyprice,msrp) AS "Harga Terendah" 
FROM products
WHERE productname ILIKE '%car%';

-- Soal 4
SELECT 
	ordernumber,
	orderdate,
	shippeddate,
	EXTRACT(YEAR FROM orderdate) AS "Tahun",
	EXTRACT(MONTH FROM orderdate) AS "Bulan",
	shippeddate - orderdate AS "Lama Pengiriman",
	AGE(shippeddate,orderdate) AS "	Interval Pengiriman",
	CURRENT_DATE AS "Tanggal Laporan",
	CURRENT_TIME AS "Waktu Laporan"
FROM orders
WHERE shippeddate IS NOT NULL;

-- Soal 5
SELECT ordernumber,
	orderdate,
	shippeddate,
	orderdate + INTERVAL '10 DAYS' AS "Estimasi Kirim", 
	COALESCE(shippeddate, orderdate + INTERVAL '10 DAYS') AS "Tanggal Aktual",
	AGE(shippeddate,orderdate) AS "Selisih Waktu"
FROM orders
WHERE comments ILIKE '%customer%' AND
	EXTRACT(MONTH FROM orderdate) BETWEEN 10 AND 12 AND
	ordernumber % 2 = 1
ORDER BY orderdate DESC;


-- Soal Tambahan

SELECT customernumber,
	UPPER(customername) AS " Customer_name",
	SUBSTRING (customername,1,4) AS "nama_code",
	country,
	creditlimit AS "credit_limit"
FROM customers
WHERE (country = 'USA' OR country = 'France' OR country = 'Germany' OR country ='UK')AND
	customername ILIKE '%o%' AND
	creditlimit >= 80000
ORDER BY creditlimit DESC;





