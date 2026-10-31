SET search_path TO 'classicmodels', public;

-- nomor 1 --
SELECT
	productcode,
	productname,
	msrp,
	quantityinstock,
	CASE
		WHEN msrp < 50 AND quantityinstock > 500 THEN 'Ekonomis - Stok Tinggi'
		WHEN msrp < 50 AND quantityinstock <= 500 THEN 'Ekonomis - Stok Rendah'
		WHEN msrp BETWEEN 50 AND 100 THEN 'Harga Menengah'
		ELSE 'Harga Premium'
	END AS kategori
FROM products
ORDER BY msrp DESC;

-- nomor 2 --
SELECT
    productcode,
    SUM(quantityordered) AS total_unit_terjual,
    COUNT(DISTINCT ordernumber) AS jumlah_pesanan
FROM orderdetails
GROUP BY productcode
HAVING SUM(quantityordered) > (
	SELECT AVG(quantityordered)
	FROM orderdetails
    )
		AND COUNT(DISTINCT ordernumber) > 10
ORDER BY total_unit_terjual DESC;

-- nomor 3 --
SELECT
    productcode,
    productname,
    quantityinstock,
    msrp
FROM products
WHERE quantityinstock > (
	SELECT AVG(quantityinstock)
	FROM products
    )
  		AND msrp > (
	SELECT AVG(msrp)
	FROM products
    )
ORDER BY quantityinstock DESC;

-- nomor 4 --
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

-- nomor 5 --
CREATE DATABASE db_perpustakaan;

CREATE TABLE anggota (
	id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY, 
	nama_anggota VARCHAR(50) NOT NULL,
	kota_domisili VARCHAR(20) NOT NULL
);

CREATE TABLE buku (
	id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY, 
	judul_buku VARCHAR(100) NOT NULL,
	genre VARCHAR(20) NOT NULL,
	stok INT DEFAULT 1
);

CREATE TABLE peminjaman (
	id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	id_anggota INT,
	id_buku INT,
	tanggal_pinjam DATE NOT NULL,
	tanggal_kembali DATE,
	denda INT DEFAULT 0,
	CONSTRAINT fk_peminjaman_anggota
		FOREIGN KEY (id_anggota)
		REFERENCES anggota(id),
	CONSTRAINT fk_peminjaman_buku
		FOREIGN KEY (id_buku)
		REFERENCES buku(id)
);

CREATE INDEX index_buku_genre ON buku(genre);

CREATE INDEX index_anggota_kota_domisili ON anggota(kota_domisili);


-- Study Case 2 --
-- Conditional Logic --
SELECT
	customernumber,
	checknumber,
	paymentdate,
	amount AS jumlah_pembayaran,
	CASE
		WHEN amount >= 50000 AND paymentdate IS NOT NULL THEN 'Pembayaran Besar dan Tercatat'
		WHEN amount >= 50000 AND paymentdate IS NULL THEN 'Pembayaran Besar Perlu Diperiksa'
		WHEN amount BETWEEN 10000 AND 50000 THEN 'Pembayaran Menengah'
		WHEN amount < 10000 THEN 'Pembayaran Kecil'
	END AS kategori_transaksi
FROM payments;

-- Subquery --
SELECT
	m.bulan,
	m.jumlah_pesanan
FROM 
(SELECT
	EXTRACT(MONTH FROM orderdate) AS bulan,
	COUNT(*) AS jumlah_pesanan
 FROM orders
 WHERE EXTRACT(YEAR FROM orderdate) = 2004
 GROUP BY EXTRACT(MONTH FROM orderdate)
) AS m
WHERE m.jumlah_pesanan > 5
ORDER BY m.bulan;