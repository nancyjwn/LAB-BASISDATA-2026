--Soal 1
SELECT customerNumber AS "Nomor Pelanggan",
       SUM(amount) AS "Total Setoran",
       COUNT(DISTINCT checkNumber) AS "Frekuensi Setoran",
       MAX(amount) AS "Setoran Terbesar"
FROM payments
GROUP BY customerNumber
HAVING COUNT(DISTINCT checkNumber) > 4 AND AVG(amount) > 20000
ORDER BY SUM(amount) DESC;

--Soal 2
SELECT customerNumber AS "Nomor Pelanggan",
       SUM(amount) AS "Total Setoran"
FROM payments
GROUP BY customerNumber
HAVING SUM(amount) > 80000
ORDER BY SUM(amount) DESC;

-- Soal 3
SELECT productLine AS "Kategori Barang",
       COUNT(DISTINCT productCode) AS jumlah_produk,
       ROUND(AVG(MSRP), 2) AS rata_rata_harga_jual,
       STRING_AGG(productName, ', ' ORDER BY productName) AS daftar_nama_produk
FROM products
GROUP BY productLine
HAVING COUNT(DISTINCT productCode) > 10
ORDER BY jumlah_produk DESC;

--Soal 4
SELECT DISTINCT reportsTo AS employeeNumber
FROM employees
WHERE reportsTo IS NOT NULL
EXCEPT
SELECT employeeNumber
FROM employees
WHERE jobTitle LIKE '%VP%'
   OR jobTitle LIKE '%President%'
ORDER BY employeeNumber;

-- Soal 5
SELECT productCode,
       SUM(quantityOrdered) AS total_unit_terjual,
       ROUND(AVG(priceEach), 2) AS rata_rata_harga
FROM orderdetails
WHERE priceEach > 100
GROUP BY productCode
HAVING SUM(quantityOrdered) > 50
ORDER BY total_unit_terjual DESC;

-- Soal 6
SELECT productCode,
       SUM(quantityOrdered) AS total_unit,
       SUM(quantityOrdered * priceEach) AS total_pendapatan,
       ROUND(AVG(priceEach), 2) AS rata_rata_harga,
       MAX(priceEach) - MIN(priceEach) AS rentang_volatilitas
FROM orderdetails
WHERE quantityOrdered > 20
GROUP BY productCode
HAVING SUM(quantityOrdered * priceEach) > 50000
ORDER BY total_pendapatan DESC;

-- Soal 7
(SELECT customerNumber
   	    FROM customers
    	WHERE creditLimit > 80000
 INTERSECT
 SELECT customerNumber
   	    FROM orders
        WHERE status IN ('Cancelled', 'On Hold')
)
EXCEPT
(SELECT customerNumber
        FROM payments
        GROUP BY customerNumber
        HAVING SUM(amount) > 100000
)
ORDER BY customerNumber;

-- Soal Tambahan
SELECT ordernumber, 
COUNT(productcode) AS "Jumlah Jenis Produk", 
SUM(quantityOrdered) AS "Total Unit Dipesan", 
SUM(priceEach * quantityOrdered) AS nilai_penjualan, 
AVG(priceEach) AS "Rata-rata Harga Jual"
FROM orderdetails
GROUP BY ordernumber
HAVING COUNT(productcode) >= 4 AND SUM(priceEach * quantityOrdered) > 15000
ORDER BY nilai_penjualan DESC;