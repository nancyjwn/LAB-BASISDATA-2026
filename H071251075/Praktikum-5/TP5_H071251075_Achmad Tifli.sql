SET search_path TO classicmodels;
-- 1
SELECT
	c.contactfirstname,
	c.customername,
	o.city AS kota_asal,
	CONCAT(e.firstname, ' ', e.lastname) AS sales_rep_name
FROM customers c
JOIN employees e
	ON c.salesrepemployeenumber = e.employeenumber
JOIN offices o
	ON e.officecode = o.officecode
WHERE c.contactfirstname ILIKE 'A%'
	AND o.city NOT LIKE 'NYC'
ORDER BY c.customername ASC;

-- 2
SELECT
	c.customername,
	SUM(p.amount) AS total_payment,
	MAX(p.amount) AS max_single_payment
FROM customers c
JOIN payments p
	ON c.customernumber = p.customernumber
GROUP BY customername
HAVING SUM(p.amount) > 50000
ORDER BY total_payment DESC;

-- 3
SELECT 
	c.customername,
	COUNT(DISTINCT o.ordernumber) AS total_order,
	ROUND(AVG(od.quantityordered), 2) AS avg_quantity_per_order
FROM customers c
JOIN orders o
	ON c.customernumber = o.customernumber
JOIN orderdetails od
	ON o.ordernumber = od.ordernumber
GROUP BY c.customername
HAVING COUNT(DISTINCT od.quantityordered) > 3
	AND ROUND(AVG(od.quantityordered), 2) > 35
ORDER BY total_order DESC, avg_quantity_per_order DESC;

-- 4
SELECT
	p.productline,
	SUM(od.quantityordered) AS total_terjual,
	ROUND(AVG(od.priceeach), 2) AS rata_rata_harga_jual,
	ROUND(AVG(((p.MSRP - od.priceEach) / p.MSRP) * 100), 2) AS avg_discount_percentage
FROM products p
JOIN orderdetails od
	ON p.productcode = od.productcode
GROUP BY p.productline
HAVING SUM(od.quantityordered) > 3000
	AND ROUND(AVG(od.priceeach), 2) > 80
ORDER BY total_terjual DESC;

-- 5
SELECT
    c.customerName,
    SUM(od.quantityOrdered * od.priceEach) AS total_transaksi,
    COUNT(DISTINCT o.orderNumber) AS total_shipped_orders,
    ROUND(
        SUM(od.quantityOrdered * od.priceEach) / COUNT(DISTINCT o.orderNumber),2) AS avg_transaction_per_order
FROM customers c
JOIN orders o
    ON c.customerNumber = o.customerNumber
JOIN orderDetails od
    ON o.orderNumber = od.orderNumber
WHERE o.status = 'Shipped'
GROUP BY c.customerName
HAVING COUNT(DISTINCT EXTRACT(YEAR FROM o.orderDate)) > 1
ORDER BY total_transaksi DESC
LIMIT 5;

-- 6
SELECT
    c.customerName,
    c.city AS customer_city,
    o2.city AS office_city,
    SUM(od.quantityOrdered) AS total_unit_terjual,
    ROUND(SUM(od.quantityOrdered * od.priceEach) / COUNT(DISTINCT o.orderNumber), 2) AS avg_nilai_per_order
FROM customers c
JOIN employees e
    ON c.salesRepEmployeeNumber = e.employeeNumber
JOIN offices o2
    ON e.officeCode = o2.officeCode
JOIN orders o
    ON c.customerNumber = o.customerNumber
JOIN orderDetails od
    ON o.orderNumber = od.orderNumber
WHERE o2.territory = 'EMEA'
GROUP BY c.customerNumber, c.customerName, c.city, o2.city
HAVING
    COUNT(DISTINCT EXTRACT(YEAR FROM o.orderDate)) > 2
    AND SUM(od.quantityOrdered) > 1000
    AND (SUM(od.quantityOrdered * od.priceEach) / COUNT(DISTINCT o.orderNumber)) > 10000
ORDER BY avg_nilai_per_order DESC;

-- soal tambahan
SELECT 
	o.ordernumber,
	o.orderdate,
	o.status,
	c.customernumber,
	c.customername
FROM orders o
JOIN customers c
	ON o.customernumber = c.customernumber
WHERE status = 'Shipped' OR status = 'Resolved'
ORDER BY orderdate DESC;
	
SELECT 
	e.firstname || ' ' || e.lastname,
	ofc.city,
	COUNT(DISTINCT c.customernumber),
	COALESCE(SUM(p.amount))
FROM employees e
JOIN offices ofc
	ON e.officecode = ofc.officecode
JOIN customers c
	ON e.employeenumber = c.salesrepemployeenumber
JOIN payments p
	ON c.customernumber = p.customernumber
GROUP BY e.firstname, e.lastname, ofc.city
HAVING COUNT(DISTINCT c.customernumber) > 3 AND SUM(p.amount) > 50000
ORDER BY SUM(p.amount) DESC;

	






















