-- 1
select
	c.contactfirstname,
	c.customername,
	o.city,
	e.firstname || ' ' || e.lastname as sales_rep_name
from customers c
inner join employees e on c.salesrepemployeenumber = e.employeenumber
inner join offices o on e.officecode = o.officecode
where 
	c.contactfirstname ilike 'A%'
	and o.city != 'NYC'
order by c.customername asc

-- 2
select
	c.customername,
	sum(p.amount) as total_payment,
	max(p.amount) as max_singe_payment
from customers c
inner join payments p on c.customernumber = p.customernumber
group by c.customername
having sum(p.amount) > 50000
order by total_payment desc

-- 3
select
	c.customername,
	count(distinct o.ordernumber) as total_order,
	round(avg(od.quantityordered), 2) as avg_quantity_per_order
from customers c
inner join orders o on c.customernumber = o.customernumber
inner join orderdetails od on od.ordernumber = o.ordernumber
group by c.customername
having 
	count(distinct o.ordernumber) > 3
	and avg(od.quantityordered) > 35
order by total_order desc, avg_quantity_per_order desc

-- 4
select
	p.productline,
	sum(od.quantityordered) as total_terjual,
	round(avg(od.priceeach), 2) as rata_rata_harga,
	round(avg((p.msrp - od.priceeach) / p.msrp * 100)) as avg_discount_percentage
from products p
inner join orderdetails od on p.productcode = od.productcode
group by p.productline
having
	sum(od.quantityordered) > 3000
	and avg(od.priceeach) > 80
order by total_terjual desc

-- 5
SELECT c.customername,
       SUM(od.quantityordered * od.priceeach) AS total_transaksi,
       COUNT(DISTINCT sh.ordernumber) AS total_shipped_orders,
       ROUND(SUM(od.quantityordered * od.priceeach) / COUNT(DISTINCT o.ordernumber), 2) AS avg_transaction_per_order
FROM customers c
INNER JOIN orders o ON c.customernumber = o.customernumber
INNER JOIN orderdetails od ON o.ordernumber = od.ordernumber
LEFT JOIN orders sh ON sh.ordernumber = o.ordernumber
                   AND sh.status = 'Shipped'
GROUP BY c.customernumber, c.customername
HAVING COUNT(DISTINCT EXTRACT(YEAR FROM o.orderdate)) > 1
ORDER BY total_transaksi DESC
LIMIT 5;

-- 6
select 
	c.customername,
	c.city as customer_city,
	ofc.city as office_city,
	sum(od.quantityordered) as total_unit_terjual,
	round(sum(od.quantityordered * od.priceeach) / count(distinct o.ordernumber), 2) as avg_nilai_per_order
from customers c
inner join orders o on c.customernumber = o.customernumber
inner join orderdetails od on o.ordernumber = od.ordernumber
inner join employees e on c.salesrepemployeenumber = e.employeenumber
inner join offices ofc on e.officecode = ofc.officecode
where ofc.territory = 'EMEA'
group by c.customername, c.city, ofc.city
having
	count(distinct extract(year from o.orderdate)) > 2
	and sum(od.quantityordered) > 1000
	and sum(od.quantityordered * od.priceeach) / count(distinct o.ordernumber) > 10000
order by avg_nilai_per_order desc


-- livecoding

select
	o.customernumber,
	o.orderdate,
	o.status,
	c.customernumber,
	c.customername
from customers c 
full outer join orders o on c.customernumber = o.customernumber
where o.status = 'Shipped' or o.status = 'Resolved'
order by o.orderdate desc


select
	c.country,
	count(distinct c.customernumber),
	count(distinct o.ordernumber),
	sum(od.quantityordered)
from customers c
inner join orders o on c.customernumber = o.customernumber
inner join orderdetails od on o.ordernumber = od.ordernumber
group by c.country
having 
	count(distinct c.customernumber) > 3
	and sum(od.quantityordered) > 1000
order by sum(od.quantityordered) desc



select * from orders

select * from offices