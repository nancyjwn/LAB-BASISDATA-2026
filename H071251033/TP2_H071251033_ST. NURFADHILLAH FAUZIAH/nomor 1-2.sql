CREATE TABLE prodi (
	id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	nama_prodi VARCHAR(100) NOT NULL
);

CREATE TABLE mahasiswa (
	nim VARCHAR(10) PRIMARY KEY,
	nama VARCHAR(100) NOT NULL,
	ipk NUMERIC(3, 2) DEFAULT 0.00,
	email VARCHAR(150) UNIQUE,
	id_prodi INT,
	CONSTRAINT fk_mahasiswa_prodi
		FOREIGN KEY (id_prodi)
		REFERENCES prodi(id)
);


--NOMOR 1
INSERT INTO prodi (nama_prodi)
VALUES 
    ('Sistem Informasi'), 
    ('Teknik Informatika');  

INSERT INTO mahasiswa (nim, nama, email, id_prodi) 
VALUES ('H071251001', 'Dilla', 'dilla@student.unhas.ac.id', 1),
		('H071251002', 'Rara', 'rara@student.unhas.ac.id', 1),
		('H071251003', 'Aca', NULL, 2)
RETURNING nim, nama, ipk, email, id_prodi;


--NOMOR 2
UPDATE mahasiswa SET ipk = 3.50;

UPDATE mahasiswa 
SET ipk = 3.75 
WHERE ipk = 3.50;

DELETE FROM mahasiswa 
WHERE email IS NULL 
RETURNING nim, nama, ipk, email, id_prodi;

SELECT * FROM mahasiswa;