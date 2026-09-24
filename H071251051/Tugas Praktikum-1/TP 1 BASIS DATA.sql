-- soal 1
CREATE DATABASE db_rs_sejahtera;

CREATE TABLE poliklinik (
	id_poli GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	nama_poli VARCHAR(50) NOT NULL UNIQUE,
	gedung VARCHAR(50) NOT NULL
);

CREATE TABLE pasien (
	id_pasien GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	nik VARCHAR(16) NOT NULL UNIQUE,
	nama_pasien VARCHAR(150) NOT NULL,
	jenis_kelamin CHAR(1) CHECK (jenis_kelamin = 'L' OR jenis_kelamin = 'P')
);

CREATE TABLE dokter (
	id_dokter GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	nama_dokter VARCHAR(150) NOT NULL,
	no_izin_praktek VARCHAR(30) UNIQUE,
	pengalaman_tahun INT DEFAULT 0 CHECK (pengalaman_tahun >= 0),
	id_poli INT,
	CONSTRAINT fk_dokter_poliklinik
		FOREIGN KEY (id_poli) REFERENCES poliklinik(id_poli)	
);

CREATE TABLE rekam_medis (
	id_rm GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	keluhan TEXT NOT NULL,
	biaya_pemeriksaan NUMERIC(12,2) DEFAULT 150000,
	id_pasien INT,
	id_dokter INT,
	CONSTRAINT fk_rm_pasien
		FOREIGN KEY (id_pasien) REFERENCES pasien(id_pasien),
	CONSTRAINT fk_rm_dokter
		FOREIGN KEY (id_dokter) REFERENCES dokter(id_dokter)
);

CREATE TABLE resep_obat (
	id_resep GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	nama_obat VARCHAR(100) NOT NULL,
	jumlah INT CHECK (jumlah > 0),
	id_rm INT,
	CONSTRAINT fk_ro_rm
		FOREIGN KEY (id_rm) REFERENCES rekam_medis(id_rm)
);

-- soal 2
ALTER TABLE pasien
ADD COLUMN gol_darah VARCHAR(2);

ALTER TABLE resep_obat
ALTER COLUMN nama_obat TYPE TEXT;

ALTER TABLE poliklinik
DROP COLUMN gedung; 

-- soal 3
DROP TABLE resep_obat;

DROP TABLE rekam_medis;


-- UNTUK KASI KEMBALI :)
ALTER TABLE poliklinik
ADD COLUMN gedung VARCHAR(50) NOT NULL;


-- SHOW Us
SELECT table_name, column_name, data_type, character_maximum_length, is_nullable
FROM information_schema.columns
WHERE table_schema ='public'
ORDER BY table_name, ordinal_position;


-- soal tambahan 
-- membuat tabel ruangan dengan ketentuan berikut:
-- 1. id_ruangan: angka bulat otomatis, Primary Key
-- 2. nama_ruangan: maksimal 100 karakter, wajib diisi, dan tidak boleh ada nama ruangan yang sama
-- 3. jenis_ruangan: maksimal 50 karakter, wajib diisi
-- 4. kapasitas: angka bulat, wajib diisi, dan harus lebih besar dari 0
-- 5. lantai: diisi dengan angka dan tidak boleh kosong


CREATE TABLE ruangan1 (
	id_ruangan int GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	nama_ruangan VARCHAR(100) NOT NULL UNIQUE,
	jenis_ruangan VARCHAR(50) NOT NULL,
	kapasitas INT NOT NULL CHECK (kapasitas > 0),
	lantai INT NOT NULL
);

SELECT table_name
FROM information_schema.columns
WHERE table_schema = 'public';

select version();