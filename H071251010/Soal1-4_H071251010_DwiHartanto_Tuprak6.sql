-- Soal 1
SELECT productCode,
       productName,
       MSRP,
       quantityInStock,
    CASE WHEN MSRP < 50 AND quantityInStock > 500
         	THEN 'Ekonomis - Stok Tinggi'
       	 WHEN MSRP < 50 AND quantityInStock <= 500
            THEN 'Ekonomis - Stok Rendah'
       	 WHEN MSRP BETWEEN 50 AND 100
            THEN 'Harga Menengah'
       	 WHEN MSRP > 100
            THEN 'Harga Premium'
    END AS kategori
FROM products
ORDER BY MSRP DESC;

-- Soal 2
SELECT productCode,
       SUM(quantityOrdered) AS totalUnitTerjual,
       COUNT(DISTINCT orderNumber) AS jumlahPesananBerbeda
FROM orderdetails
GROUP BY productCode
HAVING SUM(quantityOrdered) > (SELECT AVG(quantityOrdered) FROM orderdetails)
       AND COUNT(DISTINCT orderNumber) > 10
ORDER BY totalUnitTerjual DESC;

-- Soal 3
SELECT productCode,
       productName,
       quantityInStock,
       MSRP
FROM products
WHERE quantityInStock > (SELECT AVG(quantityInStock) FROM products)
AND MSRP > (SELECT AVG(MSRP) FROM products)
ORDER BY quantityInStock DESC;

-- Soal 4
BEGIN;

-- 1. Mengubah status menjadi Pengiriman
UPDATE orders
SET status = 'Pengiriman'
WHERE orderNumber = 10100;

-- 2. Menandai kondisi yang ingin dipertahankan
SAVEPOINT status_pengiriman;

-- 3. Melakukan perubahan kedua yang nantinya akan dibatalkan
UPDATE orders
SET status = 'Batal'
WHERE orderNumber = 10100;

-- 4. Membatalkan perubahan setelah savepoint.
ROLLBACK TO SAVEPOINT status_pengiriman;

-- 5. Menyimpan perubahan yang masih dipertahankan.
COMMIT;

--Study Case Conditional
SELECT c.customerNumber,
	   c.customerName,
	   SUM(DISTINCT(p.amount)) AS total_pembayaran,
	CASE WHEN SUM(p.amount) > 100000 THEN 'Kontribusi Sangat Tinggi'
		 WHEN SUM(p.amount) BETWEEN 50000 AND 100000 THEN 'Kontribusi Tinggi'
		 WHEN SUM(p.amount) BETWEEN 10000 AND 50000 THEN 'Kontribusi Menengah'
		 WHEN SUM(p.amount) <= 10000 THEN 'Kontribusi Rendah'
	END AS kategori_kontribusi
FROM customers c
JOIN payments p
ON c.customerNumber = p.customerNumber
GROUP BY c.customerNumber
ORDER BY total_pembayaran DESC;

SELECT p1.productCode,
 	   p1.productName,
	   p1.productLine,
	   p1.buyPrice,
	   (SELECT AVG(p2.buyPrice) FROM products p2)
FROM products p1
WHERE buyPrice > (SELECT AVG(p2.buyPrice) FROM products p2 WHERE p2.productLine = p1.productLine)
ORDER BY p1.productLine ASC, p1.buyPrice DESC;
	