--SOAL 1
SELECT 
    ordernumber, 
    UPPER(productcode) AS "Kode Produk", 
    quantityordered, 
    priceeach
FROM orderdetails
WHERE (quantityordered BETWEEN 20 AND 50 OR priceeach < 30) AND LEFT(productcode, 3) = 'S18'
ORDER BY quantityordered DESC;

--SOAL 2
SELECT 
    customernumber, 
    customername, 
    country, 
    creditlimit,
    CONCAT(contactfirstname, ' ', contactlastname) AS "Nama Kontak",
    (creditlimit - 10000) AS "Selisih Kredit"
FROM customers
WHERE country IN ('USA', 'Canada', 'France') AND creditlimit > 30000
ORDER BY creditlimit DESC;

--SOAL 3
SELECT 
    productcode, 
    productname, 
    buyprice, 
    msrp,
    GREATEST(buyprice, msrp) AS "Harga Tertinggi",
    LEAST(buyprice, msrp) AS "Harga Terendah"
FROM products
WHERE productname ILIKE '%car%';

--SOAL 4
SELECT 
    ordernumber, 
    orderdate, 
    shippeddate,
    EXTRACT(YEAR FROM orderdate) AS tahun,
    EXTRACT(MONTH FROM orderdate) AS bulan,
    (shippeddate - orderdate) AS "Lama Pengiriman",
    AGE(shippeddate, orderdate) AS "Interval Pengiriman",
    CURRENT_DATE AS "Tanggal Laporan",
    CURRENT_TIME AS "Waktu Laporan"
FROM orders
WHERE shippeddate IS NOT NULL;

--SOAL 5
SELECT 
    ordernumber, 
    orderdate, 
    shippeddate,
    (orderdate + INTERVAL '10 days') AS "Estimasi Kirim",
    COALESCE(shippeddate, orderdate + INTERVAL '10 days') AS "Tanggal Aktual",
    AGE(shippeddate, orderdate) AS "Selisih Waktu"
FROM orders
WHERE comments ILIKE '%customer%' AND EXTRACT(MONTH FROM orderdate) BETWEEN 10 AND 12 AND ordernumber % 2 = 1
ORDER BY orderdate DESC;

--Studycase
SELECT customernumber, customername, country, creditlimit FROM customers
WHERE country IN ('USA', 'Canada') AND creditlimit > 75000;