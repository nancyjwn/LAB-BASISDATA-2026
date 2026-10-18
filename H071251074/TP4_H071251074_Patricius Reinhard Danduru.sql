SET search_path TO 'classicmodels', public;

-- nomor 1 --
SELECT
	customernumber,
    SUM(amount) AS total_setoran,
    COUNT(checknumber) AS jumlah_transaksi,
    MAX(amount) AS setoran_terbesar
FROM payments
GROUP BY customernumber
HAVING COUNT(checknumber) > 4 AND AVG(amount) > 20000;

-- nomor 2 --
SELECT
	customernumber,
    SUM(amount) AS total_setoran
FROM payments
GROUP BY customernumber
HAVING SUM(amount) > 80000
ORDER BY total_setoran DESC;

-- nomor 3 --
SELECT
	productline,
    COUNT(productcode) AS jumlah_produk,
    ROUND(AVG(msrp), 2) AS rata_rata_msrp,
    STRING_AGG(productname, ', ' ORDER BY productname) AS daftar_produk
FROM products
GROUP BY productline
HAVING COUNT(productcode) > 10;

-- nomor 4 --
SELECT reportsto AS employeenumber
FROM employees
WHERE reportsto IS NOT NULL
EXCEPT
SELECT employeenumber
FROM employees
WHERE jobtitle LIKE '%VP%' OR jobtitle LIKE '%President%';

-- nomor 5 --
SELECT
	productcode,
    SUM(quantityordered) AS total_unit,
    ROUND(AVG(priceeach), 2) AS rata_rata_harga_jual
FROM orderdetails
WHERE priceeach > 100
GROUP BY productcode
HAVING SUM(quantityordered) > 50
ORDER BY total_unit DESC;

-- nomor 6 --
SELECT
	productcode,
    SUM(quantityordered) AS total_unit,
    SUM(quantityordered * priceeach) AS pendapatan_kotor,
    ROUND(AVG(priceeach), 2) AS rata_rata_harga,
    MAX(priceeach) - MIN(priceeach) AS rentang_harga
FROM orderdetails
WHERE quantityordered > 20
GROUP BY productcode
HAVING SUM(quantityordered * priceeach) > 50000
ORDER BY pendapatan_kotor DESC;

-- nomor 7 --
(SELECT customernumber
    FROM customers
    WHERE creditlimit > 80000
    INTERSECT
    SELECT customernumber
    FROM orders
    WHERE status = 'Cancelled' or status = 'On Hold')
EXCEPT
SELECT customernumber
FROM payments
GROUP BY customernumber
HAVING SUM(amount) >= 100000;

-- study case --
SELECT
	customernumber,
	COUNT(amount) AS jumlah_transaksi,
	SUM(amount) AS total_pembayaran.
	ROUND(AVG(amount), 2) AS rata_rata_pembayaran
FROM payments
GROUP BY customernumber
HAVING SUM(amount) > 100000
ORDER BY total_pembayaran DESC;