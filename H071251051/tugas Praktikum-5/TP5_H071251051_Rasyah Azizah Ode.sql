SET search_path TO classicmodels, public;

-- 1
SELECT
	c.contactfirstname,
	c.customername,
	of.city,
	CONCAT(e.firstname, ' ', e.lastname) AS sales_rep_name
FROM customers AS c
JOIN employees AS e
	ON e.employeenumber = c.salesrepemployeenumber
JOIN offices AS of
	ON of.officecode = e.officecode
WHERE
	c.contactfirstname ILIKE 'A%' AND
	of.city != 'NYC'
ORDER BY c.customername;

-- 2
SELECT
	c.customername,
	SUM(p.amount) AS total_payment,
	MAX(p.amount) AS max_single_payment
FROM customers AS c
JOIN payments AS p
	ON c.customernumber = p.customernumber
GROUP BY c.customername
HAVING SUM(p.amount) > 50000
ORDER BY SUM(p.amount) DESC;

-- 3
select 
	c.customername,
	count(distinct o.ordernumber) as total_order,
	round(avg(od.quantityordered), 2) as avg_quantity_per_order
from customers as c
join orders as o
	on c.customernumber = o.customernumber
join orderdetails as od
	on o.ordernumber = od.ordernumber
group by c.customername
having count(distinct o.ordernumber) > 3
	and avg(od.quantityordered) > 35
order by 
	total_order desc,
	avg_quantity_per_order desc;
	
-- 4
SELECT
    pr.productline,
    SUM(od.quantityordered) AS total_terjual,
    ROUND(AVG(od.priceeach), 2) AS rata_rata_harga,
    ROUND(AVG((pr.msrp - od.priceeach) / pr.msrp * 100.0), 2) AS avg_discount_percentage
FROM products AS pr
JOIN orderdetails AS od
    ON pr.productcode = od.productcode
GROUP BY pr.productline
HAVING
    SUM(od.quantityordered) > 3000
    AND AVG(od.priceeach) > 80
ORDER BY total_terjual DESC;

-- 5
SELECT
    c.customername,
    SUM(od.quantityordered * od.priceeach) AS total_transaksi,
    COUNT(DISTINCT o.ordernumber) AS total_shipped_orders,
    ROUND(SUM(od.quantityordered * od.priceeach) / COUNT(DISTINCT o.ordernumber), 2) AS avg_transaction_per_order
FROM customers AS c
JOIN orders AS o
    ON c.customernumber = o.customernumber
	and o.status = 'Shipped'
JOIN orderdetails AS od
    ON o.ordernumber = od.ordernumber
GROUP BY c.customername
HAVING 
	COUNT(DISTINCT EXTRACT(YEAR FROM o.orderdate)) > 1
ORDER BY total_transaksi DESC
LIMIT 5;

-- 6
SELECT
    c.customername,
    c.city AS customer_city,
    ofc.city AS office_city,
    SUM(od.quantityordered) AS total_unit_terjual,
    ROUND(SUM(od.quantityordered * od.priceeach) / COUNT(DISTINCT o.ordernumber), 2) AS avg_nilai_per_order
FROM customers AS c
JOIN employees AS e
    ON c.salesrepemployeenumber = e.employeenumber
JOIN offices AS ofc
    ON e.officecode = ofc.officecode
JOIN orders AS o
    ON c.customernumber = o.customernumber
JOIN orderdetails AS od
    ON o.ordernumber = od.ordernumber
WHERE ofc.territory = 'EMEA'
GROUP BY
    c.customername,
    c.city,
    ofc.city
HAVING
    COUNT(DISTINCT EXTRACT(YEAR FROM o.orderdate)) > 2
    AND SUM(od.quantityordered) > 1000
    AND SUM(od.quantityordered * od.priceeach) / COUNT(DISTINCT o.ordernumber) > 10000
ORDER BY avg_nilai_per_order DESC;


-- study case 1
select 
	o.ordernumber, 
	o.orderdate, 
	o.status,
	c.customernumber,
	c.customername
from customers as c
right join orders as o
	on c.customernumber = o.customernumber
where status ilike 'shipped' or status ilike 'resolved'  
order by orderdate desc;

-- study case 2
select 
	c.customernumber,
	c.customername,
	p.checknumber,
	p.paymentdate,
	p.amount
from customers as c
join payments as p
	on c.customernumber = p.customernumber
where 
	p.paymentdate > date'2004-01-01' and p.paymentdate < date'2005-01-01' and p.amount >= 10000
order by 
	p.amount desc,
	p.paymentdate desc;










