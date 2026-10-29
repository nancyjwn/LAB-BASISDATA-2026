SET search_path TO classicmodels, public;

-- Nomor 1
SELECT productCode,
	productName,
	MSRP,
	quantityInStock,
    CASE
        WHEN MSRP < 50 AND quantityInStock > 500
            THEN 'Ekonomis - Stok Tinggi'
        WHEN MSRP < 50 AND quantityInStock <= 500
            THEN 'Ekonomis - Stok Rendah'
        WHEN MSRP >= 50 AND MSRP <= 100
            THEN 'Harga Menengah'
        WHEN MSRP > 100
            THEN 'Harga Premium'
    END AS kategori
FROM products
ORDER BY MSRP DESC;


--Nomor 2
SELECT productcode,
	SUM(quantityOrdered) AS total_unit_terjual,
	COUNT(DISTINCT orderNumber) AS jumlah_pesanan
FROM orderdetails
GROUP BY productCode
HAVING SUM(quantityOrdered) > (
		SELECT AVG(quantityOrdered)
		FROM orderdetails
	)
	AND COUNT(DISTINCT orderNumber) > 10
ORDER BY total_unit_terjual DESC;


--Nomor 3
SELECT productCode,
	productName,
	quantityInStock,
	MSRP
FROM products
WHERE quantityInStock > (
	SELECT AVG(quantityInStock)
	FROM products
	)AND 
	MSRP > (
		SELECT AVG(MSRP)
		FROM products
	)
ORDER BY quantityInStock DESC;


--Nomor 4

BEGIN;

UPDATE orders
SET status = 'Pengiriman'
WHERE orderNumber = 10100;

SAVEPOINT status_pengiriman;

UPDATE orders
SET status = 'Batal'
WHERE orderNumber = 10100;

ROLLBACK TO SAVEPOINT status_pengiriman;

COMMIT;

SELECT * FROM orders
WHERE ordernumber = '10100';


-- Nomor 5
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
    id_anggota INT
	CONSTRAINT fk_anggota_peminjaman
		FOREIGN KEY (id_anggota)
		REFERENCES anggota(id),
    id_buku INT 
	CONSTRAINT fk_buku_peminjaman
		FOREIGN KEY (id_buku)
		REFERENCES buku(id),
    tanggal_pinjam DATE NOT NULL,
    tanggal_kembali DATE,
    denda INT DEFAULT 0
);

CREATE INDEX genre
ON buku(genre);

CREATE INDEX kota
ON anggota(kota_domisili);



-- STUDYCASE
-- Nomor 1
SELECT p1.productcode, 
	p1.productname,
	p1.productline,
	p1.buyprice,
	(SELECT AVG(p2.buyprice)
	FROM products p2
	WHERE p1.productline =  p2.productline
)AS rata_rata_kategori
FROM products p1
WHERE buyprice > (
		SELECT AVG(p2.buyprice)
		FROM products p2
		WHERE p1.productline =  p2.productline
)
ORDER BY productline ASC,buyprice DESC;
	
-- Nomor 2
SELECT c.customernumber,
	c.customername,
	SUM(p.amount) AS total_pembayaran,
	CASE
		WHEN SUM(p.amount) > 100000
			THEN 'Kontribusi Sangat Tinggi'
		WHEN SUM(p.amount) > 50000
			THEN 'Kontribusi Tinggi'
		WHEN SUM(p.amount) BETWEEN 10000 AND 50000
			THEN 'Kontribusi Menengah'
		WHEN SUM(p.amount) <=10000
			THEN 'Kontribusi Rendah'
		END AS kategori_kontribusi
FROM customers as c
JOIN payments as p
ON c.customernumber = p.customernumber
GROUP BY c.customernumber,c.customername
ORDER BY total_pembayaran DESC;
	
	
	