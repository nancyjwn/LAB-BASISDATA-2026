
-- 1
select
	productcode,
	productname,
	msrp,
	quantityinstock,
	case
		when msrp < 50 and quantityinstock > 500 then 'Ekonomis - Stok Tinggi'
		when msrp < 50 and quantityinstock <= 500 then 'Ekonomis - Stok Rendah'
		when msrp between 50 and 100 then 'Harga Menengah'
		when msrp > 100 then 'Harga Premium'
	end as kategoriproduk
from products
order by msrp desc

--2
select
	productcode,
	sum(quantityordered) as total_unit_terjual,
	count(distinct ordernumber) as jumlah_pesanan
from orderdetails
group by productcode
having 
	sum(quantityordered) > (select avg(quantityordered) from orderdetails)
	and count(distinct ordernumber) > 10
order by total_unit_terjual desc

-- 3
select
	productcode,
	productname,
	quantityinstock,
	msrp
from products
where
	quantityinstock > (select avg(quantityinstock) from products)
	and msrp > (select avg(msrp) from products)
order by quantityinstock desc

-- 4
begin;

update orders set status = 'Pengiriman' where ordernumber = 10100 returning*;

savepoint status_pengiriman;

update orders set status = 'Batal' where ordernumber = 10100 returning*;
		
rollback to savepoint status_pengiriman;

commit;

-- ubah kembali
update orders set status = 'Shipped' where ordernumber = 10100 returning*;

-- 5
create table anggota (
	id integer generated always as identity primary key,
	nama_anggota varchar(50) not null,
	kota_domisili varchar(20) not null
);

create table buku (
	id integer generated always as identity primary key,
	judul_buku varchar(100) not null,
	genre varchar(20) not null,
	stok integer default 1
);

create table peminjaman (
	id integer generated always as identity primary key,
	id_anggota integer references anggota(id),
	id_buku integer references buku(id),
	tanggal_pinjam date not null,
	tanggal_kembali date null,
	denda integer default 0
);

create index idx_buku_genre on buku(genre);
create index idx_anggota_kota_domisili on anggota(kota_domisili);


-- livecoding
select
	p.productcode,
	p.productname,
	p.productline,
	p.buyprice
from products p
where p.buyprice = (select max(buyprice) from products pr where p.productline = pr.productline)
order by p.productline asc

select
	productcode,
	productname,
	msrp,
	buyprice,
	msrp - buyprice as selisih_harga,
	case
		when msrp - buyprice > 100 then 'Margin Nominal Tinggi'
		when msrp - buyprice between 51 and 100 then 'Margin Nominal Menengah'
		when msrp - buyprice between 1 and 50 then 'Margin Nominal Rendah'
		else 'Tidak Ada Selisih Positif'
	end as kategori_produk
from products
order by selisih_harga desc;

select
	productcode,
	productname,
	productline,
	buyprice,
	(select round(avg(buyprice),2) from products p2 where p1.productline = p2.productline) as rataRataHarga
from products p1
where buyprice > (select round(avg(buyprice),2) from products p2 where p1.productline = p2.productline)
order by buyprice desc	

select * from orders


select * from products