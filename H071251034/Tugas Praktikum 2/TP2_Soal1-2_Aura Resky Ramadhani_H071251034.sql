--1
INSERT INTO prodi(nama_prodi) VALUES ('Sistem Informasi');

INSERT INTO mahasiswa(nim, nama, email, id_prodi)
VALUES 
	('H071251034', 'Aura Resky Ramadhani', 'aurars@unhas.ac.id', 1),
	('H071251032', 'Salwa Ainiyyah','jalwa@unhas.ac.id', 1),
	('H071251028', 'Aliyah Fitraturramadhani', NULL , 1)
RETURNING*;

--2

INSERT INTO mahasiswa (nim, nama, ipk, email, id_prodi) 
VALUES 
	('H071251101', 'Waddah fajri', 3.50, 'wadda@gmail.com', 1),
	('H071251102', 'nita aminarti', 3.50, 'nitnit@gmail.com', 1),
	('H071251111', 'Nafisah nailal', 3.75, 'pisya@gmail.com', 1)
RETURNING *;


UPDATE mahasiswa
SET ipk = 3.75
WHERE ipk = 3.50;

DELETE FROM mahasiswa
WHERE email is NULL;

SELECT * FROM mahasiswa;