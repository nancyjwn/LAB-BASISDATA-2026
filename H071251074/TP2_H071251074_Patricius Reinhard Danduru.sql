CREATE TABLE prodi (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nama_prodi VARCHAR(100) NOT NULL
);

CREATE TABLE mahasiswa (
    nim VARCHAR(10) PRIMARY KEY,
    nama VARCHAR(100) NOT NULL,
    ipk NUMERIC(3,2) DEFAULT 0.00,
    email VARCHAR(150) UNIQUE,
    id_prodi INT,
    CONSTRAINT fk_mahasiswa_prodi
        FOREIGN KEY (id_prodi)
        REFERENCES prodi (id)
);

INSERT INTO prodi (nama_prodi)
VALUES ('Sistem Informasi')
RETURNING *;

-- nomor 1 --
INSERT INTO mahasiswa (nim, nama, email, id_prodi)
VALUES
    ('H071251069', 'Reza', 'reza@gmail.com', 1),
    ('H071251077', 'Yusuf', 'yusuf@gmail.com', 1),
    ('H071251078', 'Daffa', NULL, 1)
RETURNING *;

-- nomor 2 --
UPDATE mahasiswa
SET ipk = 3.50
WHERE nim = 'H071251069';

UPDATE mahasiswa
SET ipk = 3.75
WHERE nim = 'H071251077';

UPDATE mahasiswa
SET ipk = 3.25
WHERE nim = 'H071251078';

UPDATE mahasiswa
SET ipk = 3.75
WHERE ipk = 3.50;

DELETE FROM mahasiswa
WHERE email IS NULL;

SELECT * FROM mahasiswa
ORDER BY nim ASC;

DELETE FROM mahasiswa;

-- Database Classicmodels --
SET search_path TO "classicmodels", public;

-- nomor 3 --
SELECT customernumber AS "Nomor Pelanggan", customername AS "Nama Pelanggan", 
		phone AS "Telepon", country AS "Negara" FROM customers;

-- nomor 4 --
SELECT productcode, productname, buyprice FROM products
WHERE buyprice > 50
ORDER BY buyprice DESC
LIMIT 7;

-- nomor 5 --
SELECT DISTINCT country AS "Negara Pelanggan"
FROM customers
ORDER BY country ASC
OFFSET 5
LIMIT 5;


-- Study Case --
SELECT productcode, productname, quantityinstock, buyprice, msrp FROM products
WHERE buyprice > 50 AND msrp > 70 AND quantityinstock < 500
ORDER BY buyprice DESC;


