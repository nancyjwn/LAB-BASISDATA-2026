-- nomor 1
INSERT INTO mahasiswa(nim, nama, email,id_prodi)
VALUES
	('H071251075','Achmad Tifli','tifli@gmail.com', 1),
	('H071251078','Asep','asep@gmail.com', 1),
	('H071251026','Ucup',NULL, 1);

SELECT * FROM mahasiswa;

-- nomor 2
UPDATE mahasiswa
SET ipk = 3.75
WHERE ipk = 3.50;

DELETE FROM mahasiswa
WHERE email IS NULL;

SELECT * FROM mahasiswa;

-- nomor 3
SET search_path TO classicmodels;
SELECT
	customernumber AS "Nomor Pelanggan",
	customername AS "Nama Pelanggan",
	phone AS "Telepon",
	country AS "Negara"
	FROM customers;
	
-- nomor 4
SELECT productcode, productname, buyprice FROM products
WHERE buyprice > 50
ORDER BY buyprice DESC
LIMIT 7;

-- nomor 5
SELECT DISTINCT country AS "Negara Pelanggan" FROM customers
ORDER BY country ASC 
LIMIT 5 OFFSET 5;

-- soal tambahan 
SELECT customernumber, customername, city, creditlimit FROM customers
WHERE country = 'USA'
ORDER BY creditlimit DESC;