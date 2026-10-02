-- 1
insert into mahasiswa (nim, nama, email, id_prodi)
values ('H071251079', 'rafly', 'rrrr@mail.duasinggit', 2),
('H071251030', 'tsaqif', 'soksigma@aku.sigma',2),
('H00000','pria misterius',NULL,2) returning *;

-- 2
update mahasiswa set ipk = 3.75 where ipk = 3.50 returning *;

delete from mahasiswa where email is null returning *;

-- 3
select 
	customerNumber as "Nomor Pelanggan",
	customerName as "Nama Pelanggan",
	phone as Telepon,
	country as Negara
	from customers;

-- 4
select productcode, productname, buyprice 
	from products where buyprice > 50 order by buyprice desc limit 7;

-- 5
select distinct country as "Negara Pelanggan"
	from customers order by country asc limit 5 offset 5; 


-- livecoding
select ordernumber, orderdate, requireddate, status from orders where status = 'In Process' or status = 'On Hold' order by requireddate asc limit 5;