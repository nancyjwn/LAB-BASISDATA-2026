SET search_path TO classicmodels;

SELECT 
	customernumber AS nomor_identifikasi_pelanggan,
	SUM(amount) AS total_akumulasi_dana,
	COUNT(amount) AS frekuensi_unik,
	MAX(amount) AS pembayaran_tertinggi
FROM payments
GROUP BY customernumber
HAVING COUNT(amount) > 4 AND AVG(amount) > 20000;


SELECT 
	customernumber AS nomor_identifikasi,
	SUM(amount) AS total_dana
FROM payments
GROUP BY customernumber
HAVING SUM(amount) > 80000
ORDER BY total_dana DESC;


SELECT 
	productline AS nama_kategori_barang,
	COUNT(productcode) AS jumlah_ragam_produk,
	ROUND(AVG(msrp), 2) AS rata_rata_ritel,
	STRING_AGG(productname, ', ' ORDER BY productname) AS daftar_nama_produk
FROM products
GROUP BY productline
HAVING COUNT(productcode) > 10;
	

SELECT employeenumber
FROM employees
EXCEPT
SELECT employeenumber
FROM employees
WHERE
	jobtitle ILIKE '%VP%'
	OR jobtitle ILIKE '%President%';

SELECT 
	productcode AS kode_identifikasi_barang,
	SUM(quantityordered) AS total_terjual,
	ROUND(AVG(priceeach), 2) AS rata_rata
FROM orderdetails
WHERE priceeach > 100
GROUP BY productcode
HAVING SUM(quantityordered) > 50
ORDER BY total_terjual DESC;


SELECT
	productcode AS kode_identifikasi_barang,
	SUM(quantityordered) AS total_pesan,
	SUM(quantityordered * priceeach) AS estimasi,
	ROUND (AVG(priceeach), 2) AS rata_rata,
	MAX(priceeach) - MIN(priceeach) AS selisih
FROM orderdetails
WHERE quantityordered > 20
GROUP BY productcode
HAVING SUM(quantityordered * priceeach) > 50000
ORDER BY estimasi DESC;

SELECT customernumber
FROM customers
WHERE creditlimit > 80000
INTERSECT
SELECT customernumber
FROM orders
WHERE status = 'Cancelled' OR status = 'On Hold'
EXCEPT
SELECT customernumber
FROM payments
WHERE amount > 100000


-- soal tambahan
SELECT 
productcode AS kode_produk,
COUNT(DISTINCT ordernumber) AS jumlah_pesanan_berbeda,
SUM(quantityordered) AS total_pesanan,
ROUND(AVG(quantityordered), 2) AS rata_rata,
SUM(quantityordered * priceeach) AS total_nilai_jual
FROM orderdetails
GROUP BY productcode
HAVING 
COUNT(DISTINCT ordernumber) >= 10
AND SUM(quantityordered) > 800 
AND SUM(quantityordered * priceeach) > 30000;
