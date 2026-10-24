SET search_path TO 'classicmodels', public;

-- nomor 1 --
SELECT 
	c.contactfirstname,
	c.customername,
	ofc.city,
	CONCAT(ep.firstname, ' ', ep.lastname) AS sales_rep_name
FROM customers c
JOIN employees ep ON c.salesrepemployeenumber = ep.employeenumber
JOIN offices ofc ON ep.officecode = ofc.officecode
WHERE c.contactfirstname ILIKE 'A%' AND ofc.city NOT LIKE 'NYC'
ORDER BY c.customername;

-- nomor 2 --
SELECT
	c.customername,
	SUM(pm.amount) AS total_payment,
	MAX(pm.amount) AS max_single_payment
FROM customers c
JOIN payments pm ON c.customernumber = pm.customernumber
GROUP BY c.customername
HAVING SUM(pm.amount) > 50000
ORDER BY total_payment DESC;

-- nomor 3 --
SELECT
	c.customername,
	COUNT(DISTINCT o.ordernumber) AS total_order,
	ROUND(AVG(od.quantityordered), 2) AS avg_quantity_per_order
FROM orders o
JOIN customers c ON o.customernumber = c.customernumber
JOIN orderdetails od ON o.ordernumber = od.ordernumber
GROUP BY c.customername
HAVING COUNT(DISTINCT o.ordernumber) > 3 AND AVG(od.quantityordered) > 35
ORDER BY total_order DESC, avg_quantity_per_order DESC;

-- nomor 4 --
SELECT
	p.productLine,
	SUM(od.quantityordered) AS total_terjual,
	ROUND(AVG(od.priceeach), 2) AS rata_rata_harga,
	ROUND(AVG(1 - od.priceeach / p.msrp) * 100, 2) AS avg_discount_percentage
FROM orderdetails od
JOIN products p ON od.productcode = p.productcode
JOIN orders o ON od.ordernumber = o.ordernumber
WHERE o.status = 'Shipped'
GROUP BY p.productline
HAVING SUM(od.quantityordered) > 3000 AND AVG(od.priceeach) > 80
ORDER BY total_terjual DESC;

-- nomor 5 --
SELECT
    c.customername,
    SUM(od.quantityordered * od.priceeach) AS total_transaksi,
    COUNT(DISTINCT o.ordernumber) AS total_shipped_orders,
    ROUND(SUM(od.quantityordered * od.priceeach) / COUNT(DISTINCT o.ordernumber), 2) AS avg_transaction_per_order
FROM customers c
JOIN orders o ON c.customernumber = o.customernumber
JOIN orderdetails od ON o.ordernumber = od.ordernumber
WHERE o.status = 'Shipped'
GROUP BY c.customername
HAVING COUNT(DISTINCT EXTRACT(YEAR FROM o.orderdate)) > 1
ORDER BY total_transaksi DESC
LIMIT 5;

-- nomor 6 --
SELECT
    c.customername,
    c.city AS customer_city,
    ofc.city AS office_city,
    SUM(od.quantityordered) AS total_unit_terjual,
    ROUND(SUM(od.priceeach * od.quantityordered) / COUNT(DISTINCT o.ordernumber), 2) AS avg_nilai_per_order
FROM customers c
JOIN orders o ON c.customernumber = o.customernumber
JOIN orderdetails od ON o.ordernumber = od.ordernumber
JOIN employees ep ON c.salesrepemployeenumber = ep.employeenumber
JOIN offices ofc ON ep.officecode = ofc.officecode
WHERE ofc.territory ILIKE 'EMEA'
GROUP BY c.customernumber, c.customername, c.city, ofc.city
HAVING COUNT(DISTINCT EXTRACT(YEAR FROM o.orderdate)) > 2
   AND SUM(od.quantityordered) > 1000
   AND SUM(od.priceeach * od.quantityordered) / COUNT(DISTINCT o.ordernumber) > 10000
ORDER BY avg_nilai_per_order DESC;


-- Study Case (Pemanasan) --
SELECT
	o.ordernumber,
	o.orderdate,
	o.status,
	c.customernumber,
	c.customername
FROM customers c
JOIN orders o ON c.customernumber = o.customernumber
WHERE o.status IN ('Shipped', 'Resolved')
ORDER BY o.orderdate DESC;

-- Study Case (nomor 2) --
SELECT
	ep.employeenumber,
	CONCAT(ep.firstname, ' ', ep.lastname) AS "Nama Lengkap Karyawan",
	ep.jobtitle,
	ofc.city,
	CONCAT(m.firstname, ' ', m.lastname) AS "Nama Lengkap Atasan"
FROM employees ep
JOIN offices ofc ON ep.officecode = ofc.officecode
LEFT JOIN employees m ON ep.reportsto = m.employeenumber
WHERE ep.jobtitle ILIKE '%Sales%' OR ep.jobtitle ILIKE '%manager%'
ORDER BY ofc.city, "Nama Lengkap Karyawan";