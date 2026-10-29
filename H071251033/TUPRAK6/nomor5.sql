--TABLE ANGGOTA
CREATE TABLE anggota (
	id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
	nama_anggota VARCHAR(50) NOT NULL,
	kota_domisili VARCHAR(20) NOT NULL
);

--TABLE BUKU
CREATE TABLE buku (
	id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    judul_buku VARCHAR(100) NOT NULL,
    genre VARCHAR(20) NOT NULL,
    stok INTEGER DEFAULT 1
);

--TABLE PEMINJAMAN 
CREATE TABLE peminjaman (
	id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_anggota INTEGER NOT NULL,
    id_buku INTEGER NOT NULL,
    tanggal_pinjam DATE NOT NULL,
    tanggal_kembali DATE,
    denda INTEGER DEFAULT 0,
    CONSTRAINT fk_peminjaman_anggota FOREIGN KEY (id_anggota) REFERENCES anggota(id),
    CONSTRAINT fk_peminjaman_buku FOREIGN KEY (id_buku) REFERENCES buku(id)
);

CREATE INDEX idx_buku_genre ON buku(genre);

CREATE INDEX idx_anggota_kota_domisili ON anggota(kota_domisili);

SELECT * FROM ANGGOTA;
SELECT * FROM buku;
SELECT * FROM peminjaman;