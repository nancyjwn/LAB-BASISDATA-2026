-- Database di praktikum_db
CREATE TABLE prodi (
	id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	nama_prodi VARCHAR (100) NOT NULL
);

CREATE TABLE mahasiswa (
	nama VARCHAR(100) NOT NULL,
	nim VARCHAR(10) PRIMARY KEY,
	ipk NUMERIC(3,2) DEFAULT 0.00,
	email VARCHAR(100) UNIQUE,
	id_prodi INT,
	CONSTRAINT fk_mahasiswa_prodi
		FOREIGN KEY (id_prodi)
		REFERENCES prodi(id)
);

SELECT table_name
FROM information_schema.tables
WHERE table_schema = 'public'

SELECT column_name,
	   data_type,
	   character_maximum_length,
	   is_nullable
FROM information_schema.columns
WHERE table_name = 'prodi'

INSERT INTO prodi(nama_prodi)
VALUES ('Sistem Informasi'),
	   ('Teknik Informatika'),
	   ('Kecerdasan Buatan');

SELECT * FROM prodi;

-- Soal Nomor 1
INSERT INTO mahasiswa (nama, nim, email, id_prodi)
VALUES ('Teguh', 'H071251001', NULL, 1),
	   ('Glenn', 'H071251002', 'glenn@gmail.com', 1),
	   ('Tanto', 'H071251010', 'tanto@student.unhas.ac.id', 1)
RETURNING *;

-- Soal Nomor 2
UPDATE mahasiswa
SET ipk = 3.50
WHERE nim = 'H071251010';

UPDATE mahasiswa
SET ipk = 3.75
WHERE ipk = 3.50;

DELETE FROM mahasiswa
WHERE email IS NULL;

SELECT * FROM mahasiswa;

-- Soal Nomor 3
SELECT customerNumber AS "Nomor Pelanggan",
       customerName AS "Nama Pelanggan",
       phone AS "Telepon",
       country AS "Negara"
FROM customers;

-- Soal Nomor 4
SELECT productCode,
       productName,
       buyPrice
FROM products
WHERE buyPrice > 50
ORDER BY buyPrice DESC
LIMIT 7;

-- Soal Nomor 5
SELECT DISTINCT country AS "Negara Pelanggan"
FROM customers
ORDER BY country ASC
LIMIT 5
OFFSET 5;

--Soal tambahan
SELECT
	customernumber,
	customername,
	city,
	creditlimit
FROM customers
WHERE country = 'USA' AND creditlimit >= 100000
ORDER BY creditlimit DESC;