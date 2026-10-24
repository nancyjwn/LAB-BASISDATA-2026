SET search_path TO classicmodels, public;

-- Nomor 1
SELECT c.contactfirstname,
	c.customername,
	o.city AS office_city,
	CONCAT(e.firstname, ' ', e.lastname) AS sales_rep_name
FROM customers c
JOIN employees e 
	ON c.salesrepemployeenumber = e.employeenumber
JOIN offices o 
	ON e.officecode = o.officecode
WHERE c.contactfirstname ILIKE 'A%' AND 
	o.city != 'NYC'
ORDER BY c.customername ASC;

-- Nomor 2
SELECT c.customername, 
	SUM(p.amount) AS total_payment,
	MAX(p.amount) AS max_single_payment
FROM customers c
JOIN payments p 
	ON c.customernumber = p.customernumber
GROUP BY c.customernumber, c.customername
HAVING SUM(p.amount) > 50000
ORDER BY total_payment DESC;

-- Nomor 3
SELECT c.customername,
	COUNT(DISTINCT o.ordernumber) AS total_order, 
	ROUND(AVG(od.quantityordered), 2) AS avg_quantity_per_order
FROM customers c
JOIN orders o 
	ON c.customernumber = o.customernumber
JOIN orderdetails od 
	ON o.ordernumber = od.ordernumber
GROUP BY c.customerNumber, c.customerName
HAVING COUNT(DISTINCT o.ordernumber) > 3 AND
	AVG(od.quantityordered) > 35
ORDER BY total_order DESC, avg_quantity_per_order DESC;

-- Nomor 4
SELECT p.productline,
	SUM(od.quantityordered) AS total_terjual, 
	ROUND(AVG(od.priceeach), 2) AS rata_rata_harga, 
	ROUND(AVG(((p.msrp - od.priceeach) / p.msrp) * 100), 2) AS avg_discount_percentage
FROM products p
JOIN orderdetails od
	ON p.productcode = od.productcode
GROUP BY p.productline
HAVING SUM(od.quantityordered) > 3000 AND AVG(od.priceeach) > 80
ORDER BY total_terjual DESC;

-- Nomor 5
SELECT
    c.customerName,
    SUM(od.quantityOrdered * od.priceEach) AS total_transaksi,
    COUNT(DISTINCT o.orderNumber) AS total_shipped_orders,
    ROUND(SUM(od.quantityOrdered * od.priceEach) / COUNT(DISTINCT o.orderNumber),2) AS avg_transaction_per_order
FROM customers c
JOIN orders o
    ON c.customerNumber = o.customerNumber
JOIN orderdetails od
    ON o.orderNumber = od.orderNumber
WHERE o.status = 'Shipped'
GROUP BY c.customerName
HAVING COUNT(DISTINCT EXTRACT(YEAR FROM o.orderDate)) > 1
ORDER BY total_transaksi DESC
LIMIT 5;

-- Nomor 6
SELECT c.customername,
	c.city AS customer_city,
	of.city AS office_city,
	SUM(od.quantityordered) AS total_unit_terjual,
	ROUND(SUM(od.quantityordered * od.priceeach) / COUNT(DISTINCT o.ordernumber), 2) AS avg_nilai_per_order
FROM customers c
JOIN employees e 
	ON c.salesrepemployeenumber = e.employeenumber
JOIN offices of
	ON e.officecode = of.officecode
JOIN orders o 
	ON c.customernumber = o.customernumber
JOIN orderdetails od 
	ON o.ordernumber = od.ordernumber
WHERE of.territory = 'EMEA'
GROUP BY c.customername, c.city, of.city
HAVING 
    COUNT(DISTINCT EXTRACT(YEAR FROM o.orderdate)) > 2
    AND SUM(od.quantityordered) > 1000
    AND (SUM(od.quantityordered * od.priceeach) / COUNT(DISTINCT o.ordernumber)) > 10000
ORDER BY avg_nilai_per_order DESC;


-- STUDY CASE
SELECT o.ordernumber, o.orderdate, o.status, c.customernumber, c.customername
FROM customers c
FULL OUTER JOIN orders o
	ON o.customernumber = c.customernumber
WHERE o.status = 'Shipped' OR o.status = 'Resolved'
ORDER BY orderdate DESC;


SELECT c.customername, 
	COUNT(DISTINCT o.ordernumber) AS jumlah_pesanan, 
	SUM(od.quantityordered) AS total_unit_dipesan, 
	SUM(od.quantityordered * od.priceeach) AS total_nilai_transaksi
FROM customers AS c
JOIN orders AS o 
	ON c.customernumber = o.customernumber
JOIN orderdetails AS od
	ON od.ordernumber = o.ordernumber
GROUP BY c.customername
HAVING COUNT(DISTINCT o.ordernumber) >= 4 AND
	SUM(od.quantityordered * od.priceeach) >80000
ORDER BY total_nilai_transaksi DESC;
	

	
	

	
