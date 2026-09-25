CREATE DATABASE db_rs_sejahtera;
CREATE TABLE poliklinik (
	id_poli INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	nama_poli VARCHAR (50) NOT NULL UNIQUE,
	gedung VARCHAR(50) NOT NULL
);

CREATE TABLE pasien (
	id_pasien INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	nik VARCHAR(16) NOT NULL UNIQUE,
	nama_pasien VARCHAR(150) NOT NULL,
	jenis_kelamin CHAR(1) CHECK (jenis_kelamin IN ('L', 'P'))
);

CREATE TABLE doktor (
	id_dokter INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	nama_dokter VARCHAR(150) NOT NULL,
	no_izin_praktek VARCHAR(30) UNIQUE,
	pengalaman_tahun INT CHECK (pengalaman_tahun >= 0) DEFAULT 0,
	id_poli INT,
	CONSTRAINT idpoli
		FOREIGN KEY (id_poli)
		REFERENCES poliklinik(id_poli)
);

CREATE TABLE rekam_medis (
	id_rm INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	keluhan TEXT NOT NULL,
	biaya_pemeriksaan NUMERIC(15,2) DEFAULT 150000.00,
	id_pasien INT,
	id_dokter INT,
	CONSTRAINT idpasien
		FOREIGN KEY (id_pasien)
		REFERENCES pasien(id_pasien),
	CONSTRAINT iddokter
		FOREIGN KEY (id_dokter)
		REFERENCES doktor(id_dokter)
);

CREATE TABLE resep_obat (
	id_resep INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	nama_obat VARCHAR(100) NOT NULL,
	jumlah INT CHECK (jumlah > 0),
	id_rm INT,
	CONSTRAINT idrm
		FOREIGN KEY (id_rm)
		REFERENCES rekam_medis(id_rm)
);


-- NOMOR 2--
ALTER TABLE pasien
ADD COLUMN gol_darah VARCHAR(2);

ALTER TABLE resep_obat
ALTER COLUMN nama_obat TYPE TEXT;

ALTER TABLE poliklinik
DROP COLUMN gedung;

-- NOMOR 3 --
DROP TABLE rekam_medis;

DROP TABLE resep_obat;


-- TES --
ALTER TABLE doktor
ADD COLUMN spesialisasi VARCHAR(100);

ALTER TABLE doktor
ALTER COLUMN no_izin_praktek TYPE VARCHAR(50);

ALTER TABLE doktor
ADD COLUMN no_telepon VARCHAR(15) NOT NULL

