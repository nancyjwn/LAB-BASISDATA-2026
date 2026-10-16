--NOMOR 1
SELECT 
    customerNumber,
    SUM(amount) AS total_akumulasi_setoran,
    COUNT(checkNumber) AS frekuensi_transaksi,
    MAX(amount) AS setoran_terbesar
FROM payments
GROUP BY customerNumber
HAVING COUNT(checkNumber) > 4 AND AVG(amount) > 20000;

--NOMOR 2
SELECT 
    customerNumber,
    SUM(amount) AS total_setoran
FROM payments
GROUP BY customerNumber
HAVING SUM(amount) > 80000
ORDER BY total_setoran DESC;

--NOMOR 3
SELECT 
    productLine AS "Kategori Barang",
    COUNT(productCode) AS "Jumlah Ragam Produk",
    ROUND(AVG(MSRP), 2) AS "Rata-rata MSRP",
    STRING_AGG(productName, ', ' ORDER BY productName) AS "Daftar Produk"
FROM products
GROUP BY productLine
HAVING COUNT(productCode) > 10;

--NOMOR 4
SELECT DISTINCT reportsTo AS employeeNumber
FROM employees
WHERE reportsTo IS NOT NULL
EXCEPT
SELECT employeeNumber
FROM employees
WHERE jobTitle LIKE '%VP%' OR jobTitle LIKE '%President%';

--NOMOR 5
SELECT 
    productCode,
    SUM(quantityOrdered) AS total_unit_terjual,
    ROUND(AVG(priceEach), 2) AS rata_rata_harga_riil
FROM orderdetails
WHERE priceEach > 100
GROUP BY productCode
HAVING SUM(quantityOrdered) > 50
ORDER BY total_unit_terjual DESC;

--NOMOR 6
SELECT 
    productCode,
    SUM(quantityOrdered) AS total_unit_dipesan,
    SUM(quantityOrdered * priceEach) AS pendapatan_kotor,
    ROUND(AVG(priceEach), 2) AS rata_rata_harga_riil,
    MAX(priceEach) - MIN(priceEach) AS rentang_volatilitas
FROM orderdetails
WHERE quantityOrdered > 20
GROUP BY productCode
HAVING SUM(quantityOrdered * priceEach) > 50000
ORDER BY pendapatan_kotor DESC;

--NOMOR 7
SELECT customerNumber 
FROM customers 
WHERE creditLimit > 80000
INTERSECT
SELECT customerNumber 
FROM orders 
WHERE status IN ('Cancelled', 'On Hold')
EXCEPT
SELECT customerNumber 
FROM payments 
GROUP BY customerNumber 
HAVING SUM(amount) > 100000;

--Study case
SELECT customerNumber, 
		COUNT(*) AS "Jumlah Transaksi Pembayaran",
		SUM(amount) AS "Total Pembayaran",
		ROUND(AVG(amount), 2) AS rata_rata
FROM payments
GROUP BY customerNumber
HAVING COUNT(*) >= 3 AND SUM(amount) > 50000
ORDER BY "Jumlah Transaksi Pembayaran" DESC;