set search_path to classicmodels, public;

-- nomor 1
select 
    productCode,
    productName,
    MSRP,
    quantityInStock,
    case 
        when MSRP < 50 and quantityInStock > 500 then 'Ekonomis - Stok Tinggi'
        when MSRP < 50 and quantityInStock <= 500 then 'Ekonomis - Stok Rendah'
        when MSRP between 50 and 100 then 'Harga Menengah'
        when MSRP > 100 then 'Harga Premium'
    end as kategori
from 
    products
order by  
    MSRP desc;

-- nomor 2
SELECT 
    productCode,
    SUM(quantityOrdered) AS total_unit_terjual,
    COUNT(DISTINCT orderNumber) AS jumlah_pesanan
FROM 
    orderdetails
GROUP BY 
    productCode
HAVING 
    SUM(quantityOrdered) > (SELECT AVG(quantityOrdered) FROM orderdetails) 
    AND COUNT(DISTINCT orderNumber) > 10
ORDER BY 
    total_unit_terjual DESC;

-- nomor 3
select 
	productcode,
	productname,
	quantityinstock,
	msrp
from products
where 
	quantityinstock > (select avg(quantityinstock) from products)
	and msrp > (select avg(msrp) from products)
order by quantityinstock desc;

-- nomor 4
select ordernumber, status
from orders
where ordernumber = 10100;

begin;

update orders
set status = 'Pengiriman'
where ordernumber = 10100;

savepoint status_pengiriman;

update orders
set status = 'Batal'
where ordernumber = 10100;

rollback to savepoint status_pengiriman;

commit;

-- study case
-- case when
select
	productcode,
	productname, 
	msrp,
	buyprice,
	(msrp - buyprice) as selisih_harga,
	case
		when (msrp - buyprice) > 100 then 'margin nominal tinggi'
		when (msrp - buyprice) > 50  then 'margin nominal menengah'
		when (msrp - buyprice) > 0 then 'margin nominal rendah'
		else 'tidak ada selisih positif'
	end as kategori 
from products
order by selisih_harga desc;

-- subquery
select
	p1.productcode,
	p1.productname,
	p1.productline,
	p1.buyprice
from products p1
where
	 p1.buyprice = (select max(p2.buyprice) from products p2 where p1.productline = p2.productline)
order by p1.productline asc;




	
