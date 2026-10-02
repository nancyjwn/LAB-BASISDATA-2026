SET search_path TO classicmodels, public;

-- Nomor 3
SELECT customerNumber AS "Nomor Pelanggan",customerName AS "Nama Pelanggan",phone AS "Telepon", country AS "Negara"
FROM customers;

-- Nomor 4
SELECT productcode, productname,buyprice FROM products
WHERE buyprice > 50
ORDER BY buyprice DESC
LIMIT 7;

-- Nomor 5
SELECT DISTINCT country AS "Negara Pelanggan" FROM customers
ORDER BY country ASC
LIMIT 5 OFFSET 5 ;

-- Soal tambahan
SELECT customernumber,customername,country,creditlimit FROM customers
ORDER BY creditlimit DESC
LIMIT 10 OFFSET 10;