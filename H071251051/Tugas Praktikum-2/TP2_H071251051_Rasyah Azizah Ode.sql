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

insert into prodi (nama_prodi)
values 
	('Sistem Informasi'),
	('Ilmu Komputer'),
	('Fisika');
returning *;
	
-- nomor 1
insert into mahasiswa (nim, nama, email, id_prodi)
values 
	('H071251051', 'Rasyah', 'acaazizah00@gmail.com', 1),
	('H071271049', 'dokja', 'cumi@gmail.com', 2),
	('H011291000', 'schrodinger', null, 3)
returning *;

-- nomor 2
update mahasiswa 
set ipk = 3.75
where ipk = 3.50
returning *;

delete from mahasiswa 
where email is null
returning *;

select * from mahasiswa; 

-- nomor 3
select customerNumber as "Nomor Pelanggan", customerName as "Nama Pelanggan", phone as "Telepon", country as "Negara"
from classicmodels.customers;

-- nomor 4
select productCode as productcode, productName as productname, buyPrice as buyprice
from classicmodels.products
where buyPrice > 50
order by buyPrice desc 
limit 7;

-- nomor 5
select distinct country as "Negara Pelanggan"
from classicmodels.customers
order by "Negara Pelanggan" ASC
limit 5 offset 5;

-- Tugas tambahan
set search_path to classicmodels, public;

select productCode, productName, quantityinstock, buyPrice, msrp
from classicmodels.products
where buyPrice > 50  and msrp > 70 and quantityinstock < 500
order by buyPrice desc;
