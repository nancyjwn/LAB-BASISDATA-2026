--NOMOR 1
SELECT productcode, productname, msrp, quantityinstock,
    CASE 
        WHEN msrp < 50 AND quantityinstock > 500 THEN 'Ekonomis - Stok Tinggi'
        WHEN msrp < 50 AND quantityinstock <= 500 THEN 'Ekonomis - Stok Rendah'
        WHEN msrp >= 50 AND msrp <= 100 THEN 'Harga Menengah'
        WHEN msrp > 100 THEN 'Harga Premium'
    END AS kategori_produk
FROM products
ORDER BY msrp DESC;

--NOMOR 2
SELECT 
    productcode,
    SUM(quantityordered) AS total_unit_terjual,
    COUNT(DISTINCT ordernumber) AS jumlah_pesanan_berbeda
FROM orderdetails
GROUP BY productcode
HAVING SUM(quantityordered) > (SELECT AVG(quantityordered) FROM orderdetails) AND (SELECT COUNT(DISTINCT ordernumber) > 10)
ORDER BY total_unit_terjual DESC;

--NOMOR 3
SELECT productcode, productname, quantityinstock, msrp
FROM products
WHERE quantityinstock > (SELECT AVG(quantityinstock) FROM products)
  AND msrp > (SELECT AVG(msrp) FROM products)
ORDER BY quantityinstock DESC;

--NOMOR 4
SELECT ordernumber, status FROM orders 
WHERE ordernumber = 10100;
--status: shipped

BEGIN;

UPDATE orders
SET status = 'Pengiriman'
WHERE ordernumber = 10100;

SAVEPOINT status_pengiriman;

UPDATE orders
SET status = 'Batal'
WHERE ordernumber = 10100;

ROLLBACK TO SAVEPOINT status_pengiriman;

COMMIT;

--STUDYCASE
SELECT 
	productcode, 
	productname, 
	msrp, 
	buyprice, 
	(msrp - buyprice) AS selisih_harga,
CASE
	WHEN (msrp - buyprice) > 100 THEN 'Margin Nominal Tinggi'
	WHEN (msrp - buyprice) > 50 THEN 'Margin Nominal Menengah'
	WHEN (msrp - buyprice) > 0 THEN 'Margin Nominal Rendah'
	ELSE 'Tidak Ada Selisih Positif'
END AS kategori_produk
FROM products
ORDER BY selisih_harga DESC;

--STUDYCASE SUBQUERY
SELECT 
	p1.productcode, 
	p1.productname, 
	p1.productline AS kategori_produk,
	p1.buyprice
FROM products p1
WHERE p1.buyprice = (SELECT MAX(p2.buyprice) FROM products p2 WHERE p2.productline = p1.productline)
ORDER BY p1.productline ASC;