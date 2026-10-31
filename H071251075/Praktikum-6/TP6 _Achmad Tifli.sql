SET search_path TO classicmodels;

-- 1
SELECT productcode, productname, msrp, quantityinstock, (
	CASE
		WHEN msrp < 50 AND quantityinstock > 500 THEN 'Ekonomis - Stok Tinggi'
		WHEN msrp < 50 AND quantityinstock <= 500 THEN 'Ekonomis - Stok Rendah'
		WHEN msrp BETWEEN 50 AND 100 THEN 'Harga Menengah'
		WHEN msrp > 100 THEN 'Harga Premium'
	END 
) AS kategori
FROM products
ORDER BY msrp DESC;

-- 2
SELECT productcode, SUM(quantityordered) AS total_terjual, COUNT(DISTINCT ordernumber) AS jumlah_pesanan_berbeda
FROM orderdetails
GROUP BY productcode
HAVING SUM(quantityordered) > (
	SELECT AVG(quantityordered)
	FROM orderdetails
) AND COUNT(DISTINCT ordernumber) > 10
ORDER BY total_terjual DESC

-- 3
SELECT productcode, productname, quantityinstock AS jumlah_stok, msrp
FROM products
WHERE
	quantityinstock > (
	SELECT AVG(quantityinstock) FROM products)
	AND msrp > (
	SELECT AVG(msrp) FROM products)
ORDER BY jumlah_stok DESC;

-- 4
BEGIN;

UPDATE orders
SET status = 'Pengiriman'
WHERE ordernumber = 10100

SAVEPOINT status_pengiriman;

UPDATE orders
SET status = 'Batal'
WHERE ordernumber = 10100

ROLLBACK TO SAVEPOINT status_pengiriman;

COMMIT;

-- 5
CREATE TABLE anggota(
	id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	nama_anggota VARCHAR(50) NOT NULL,
	kota_domisili VARCHAR(20) NOT NULL;
);

CREATE TABLE buku (
	id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	judul_buku VARCHAR(100) NOT NULL,
	genre VARCHAR(20) NOT NULL,
	stok INT DEFAULT 1
);

CREATE TABLE peminjaman (
	id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	id_anggota INT REFERENCES anggota(id),
	id_buku INT REFERENCES buku(id),
	tanggal_pinjam DATE NOT NULL,
	tanggal_kembali DATE,
	denda INT DEFAULT 0
);

CREATE INDEX genre_buku ON buku(genre)
CREATE INDEX domisili_anggota ON anggota(kota_domisili)

-- soal tambahan subquery
SELECT tabel.nama_bulan, tabel.jumlah_pesanan
FROM (
	SELECT EXTRACT(MONTH FROM orderdate) AS nama_bulan, COUNT(*) AS jumlah_pesanan
	FROM orders
	WHERE EXTRACT(YEAR FROM orderdate) = 2004 
	GROUP BY EXTRACT(MONTH FROM orderdate)
) AS tabel
WHERE jumlah_pesanan > 5
ORDER BY tabel.nama_bulan ASC;

-- soal tambahan conditional 
SELECT customernumber, checknumber, paymentdate, amount, (
	CASE 
		WHEN amount > 50000 AND paymentdate IS NOT NULL THEN 'Pembayaran Besar dan Tercatat'
		WHEN amount > 50000 AND paymentdate IS NULL THEN 'Pembayaran Besar dan perlu diperiksa'
		WHEN amount > 10000 AND amount < 50000 THEN 'Pembayaran Menengah'
		ELSE 'Pembayaran Kecil'
	END
) AS kategori
FROM payments
ORDER BY amount DESC;

-- soal tambahan 
SELECT 
	p1.productcode, 
	p1.productname, 
	p1.productline, 
	p1.buyprice,(
	SELECT AVG(p2.buyprice)
	FROM products p2
	WHERE p1.productline = p2.productline
	) AS rata_rata
FROM products p1
WHERE p1.buyprice > (
	SELECT AVG(p2.buyprice)
	FROM products p2
	WHERE p1.productline = p2.productline
)




