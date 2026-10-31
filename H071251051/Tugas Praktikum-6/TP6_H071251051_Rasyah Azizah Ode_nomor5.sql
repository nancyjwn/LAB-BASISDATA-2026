-- nomor 1
-- Tabel anggota
create table anggota (
    id int generated always as identity primary key,
    nama_anggota varchar(50) not null,
    kota_domisili varchar(20) not null
);

-- Tabel buku
create table buku (
    id int generated always as identity primary key,
    judul_buku varchar(100) not null,
    genre varchar(20) not null,
    stok int default 1
);

-- Tabel peminjaman
create table peminjaman (
    id int generated always as identity primary key,
    id_anggota int not null,
    id_buku int not null,
    tanggal_pinjam date not null,
    tanggal_kembali date,
    denda int default 0,
    constraint fk_peminjaman_anggota 
        foreign key (id_anggota) 
        references anggota(id),
        
    constraint fk_peminjaman_buku 
        foreign key (id_buku) 
        references buku(id) 
);

-- Indeks
create index idx_buku_genre on buku(genre);
create index idx_kota_domisili on anggota(kota_domisili);

-- show us
select 
    'anggota' as nama_tabel, count(*) as total_data from anggota
union all
select 
    'buku' AS nama_tabel, count(*) as total_data from buku
union all
select 
    'peminjaman' as nama_tabel, count(*) as total_data from peminjaman;