CREATE TABLE poliklinik (
    id_poli INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nama_poli VARCHAR(50) NOT NULL UNIQUE,
    gedung VARCHAR(50) NOT NULL
);

CREATE TABLE pasien (
    id_pasien INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nik VARCHAR(16) NOT NULL UNIQUE,
    nama_pasien VARCHAR(150) NOT NULL,
    jenis_kelamin CHAR(1) CHECK (jenis_kelamin = 'L' OR jenis_kelamin = 'P')
);

CREATE TABLE dokter (
    id_dokter INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nama_dokter VARCHAR(150) NOT NULL,
    no_izin_praktek VARCHAR(30) UNIQUE,
    pengalaman_tahun INT DEFAULT 0 CHECK (pengalaman_tahun >= 0),
    id_poli INT,
    CONSTRAINT fk_dokter_poli
        FOREIGN KEY (id_poli)
        REFERENCES poliklinik(id_poli)
);

CREATE TABLE rekam_medis (
    id_rm INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    keluhan TEXT NOT NULL,
    biaya_pemeriksaan NUMERIC DEFAULT 150000,
    id_pasien INT,
    id_dokter INT,
    CONSTRAINT fk_rm_pasien
        FOREIGN KEY (id_pasien)
        REFERENCES pasien(id_pasien),
    CONSTRAINT fk_rm_dokter
        FOREIGN KEY (id_dokter)
        REFERENCES dokter(id_dokter)
);

CREATE TABLE resep_obat (
    id_resep INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nama_obat VARCHAR(100) NOT NULL,
    jumlah INT CHECK (jumlah > 0),
    id_rm INT,
    CONSTRAINT fk_resep_rm
        FOREIGN KEY (id_rm)
        REFERENCES rekam_medis(id_rm)
);

SELECT table_name
FROM information_schema.tables
WHERE table_schema = 'public';

SELECT column_name, data_type, character_maximum_length, is_nullable
FROM information_schema.columns
WHERE table_name = 'pasien';

ALTER TABLE pasien
ADD COLUMN gol_darah VARCHAR(2);

ALTER TABLE resep_obat
ALTER COLUMN nama_obat TYPE TEXT;

ALTER TABLE poliklinik
DROP COLUMN gedung;

DROP TABLE resep_obat;
DROP TABLE rekam_medis;

ALTER TABLE rekam_medis
ADD CONSTRAINT check_biaya_pemeriksaan
CHECK (biaya_pemeriksaan >= 0);

ALTER TABLE dokter
ADD CONSTRAINT check_pengalaman_dokter
CHECK (pengalaman_tahun >= 2);

SELECT column_name, data_type, character_maximum_length, is_nullable
FROM information_schema.columns
WHERE table_name = 'rekam_medis';

SELECT column_name, data_type, character_maximum_length, is_nullable
FROM information_schema.columns
WHERE table_name = 'dokter';