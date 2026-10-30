-- Soal 5
CREATE TABLE anggota (
    id SERIAL PRIMARY KEY,
    nama_anggota VARCHAR(50) NOT NULL,
    kota_domisili VARCHAR(20) NOT NULL
);

CREATE TABLE buku (
    id SERIAL PRIMARY KEY,
    judul_buku VARCHAR(100) NOT NULL,
    genre VARCHAR(20) NOT NULL,
    stok INTEGER DEFAULT 1
);

CREATE TABLE peminjaman (
    id SERIAL PRIMARY KEY,
    id_anggota INTEGER,
    id_buku INTEGER,
    tanggal_pinjam DATE NOT NULL,
    tanggal_kembali DATE,
    denda INTEGER DEFAULT 0,

    CONSTRAINT fk_peminjaman_anggota
        FOREIGN KEY (id_anggota)
        REFERENCES anggota(id),

    CONSTRAINT fk_peminjaman_buku
        FOREIGN KEY (id_buku)
        REFERENCES buku(id)
);

CREATE INDEX idx_buku_genre
ON buku (genre);

CREATE INDEX idx_anggota_kota_domisili
ON anggota (kota_domisili);


-- Pengujian: menambahkan anggota dengan seluruh kolom wajib
INSERT INTO anggota (nama_anggota, kota_domisili)
VALUES ('Tanto', 'Makassar');

-- Pengujian: menambahkan buku tanpa menentukan stok agar DEFAULT 1 digunakan.
INSERT INTO buku (judul_buku, genre)
VALUES ('Belajar SQL Dasar', 'Pendidikan');

-- Pengujian: membuat transaksi peminjaman dengan tanggal kembali masih NULL.
INSERT INTO peminjaman (id_anggota, id_buku, tanggal_pinjam)
VALUES (1, 1, DATE '2026-10-29');

SELECT *
FROM peminjaman;

SELECT *
FROM anggota;

SELECT *
FROM buku;