-- Soal 1
SELECT c.contactFirstName,
       c.customerName,
       ofc.city AS office_city,
       CONCAT(e.firstName, ' ', e.lastName) AS sales_rep_name
FROM customers c
INNER JOIN employees e
    ON c.salesRepEmployeeNumber = e.employeeNumber
INNER JOIN offices ofc
    ON e.officeCode = ofc.officeCode
WHERE c.contactFirstName ILIKE 'A%'
  AND ofc.city <> 'NYC'
ORDER BY c.customerName ASC;

-- Soal 2
SELECT c.customerName,
       SUM(p.amount) AS total_payment,
       MAX(p.amount) AS max_single_payment
FROM customers c
INNER JOIN payments p
    ON c.customerNumber = p.customerNumber
GROUP BY
    c.customerNumber,
    c.customerName
HAVING SUM(p.amount) > 50000
ORDER BY total_payment DESC;

-- Soal 3
SELECT c.customerName,
       COUNT(DISTINCT o.orderNumber) AS total_order,
       ROUND(AVG(od.quantityOrdered), 2) AS avg_quantity_per_order
FROM customers c
INNER JOIN orders o
    ON c.customerNumber = o.customerNumber
INNER JOIN orderdetails od
    ON o.orderNumber = od.orderNumber
GROUP BY
    c.customerNumber,
    c.customerName
HAVING COUNT(DISTINCT o.orderNumber) > 3
   AND AVG(od.quantityOrdered) > 35
ORDER BY
    total_order DESC,
    avg_quantity_per_order DESC;


--Soal 4
SELECT p.productLine,
       SUM(od.quantityOrdered) AS total_terjual,
       ROUND(AVG(od.priceEach), 2) AS rata_rata_harga,
       ROUND(AVG(((p.MSRP - od.priceEach) / p.MSRP) * 100), 2) AS avg_discount_percentage
FROM products p
INNER JOIN orderdetails od
    ON p.productCode = od.productCode
GROUP BY p.productLine
HAVING SUM(od.quantityOrdered) > 3000
   AND AVG(od.priceEach) > 80
ORDER BY total_terjual DESC;

-- Soal 5
SELECT c.customerName,
       SUM(od.quantityOrdered * od.priceEach) AS total_transaksi,
       COUNT(DISTINCT os.orderNumber) AS total_shipped_orders,
	   ROUND(SUM(od.quantityOrdered * od.priceEach) / COUNT(DISTINCT o.orderNumber),2) AS avg_transaction_per_order
FROM customers c
INNER JOIN orders o
    ON c.customerNumber = o.customerNumber
INNER JOIN orderdetails od
    ON o.orderNumber = od.orderNumber
LEFT JOIN orders os
    ON o.orderNumber = os.orderNumber
   AND os.status = 'Shipped'
GROUP BY
    c.customerNumber,
    c.customerName
HAVING COUNT(DISTINCT EXTRACT(YEAR FROM o.orderDate)) > 1
ORDER BY total_transaksi DESC
LIMIT 5;


-- Soal 6
SELECT c.customerName,
       c.city AS customer_city,
       ofc.city AS office_city,
       SUM(od.quantityOrdered) AS total_unit_terjual,
       ROUND(SUM(od.quantityOrdered * od.priceEach) / COUNT(DISTINCT o.orderNumber),2) AS avg_nilai_per_order
FROM customers c
INNER JOIN employees e
    ON c.salesRepEmployeeNumber = e.employeeNumber
INNER JOIN offices ofc
    ON e.officeCode = ofc.officeCode
INNER JOIN orders o
    ON c.customerNumber = o.customerNumber
INNER JOIN orderdetails od
    ON o.orderNumber = od.orderNumber
WHERE ofc.territory = 'EMEA'
GROUP BY
    c.customerNumber,
    c.customerName,
    c.city,
    ofc.city
HAVING COUNT(DISTINCT EXTRACT(YEAR FROM o.orderDate)) > 2
   AND SUM(od.quantityOrdered) > 1000
   AND (SUM(od.quantityOrdered * od.priceEach) / COUNT(DISTINCT o.orderNumber)) > 10000
ORDER BY avg_nilai_per_order DESC;

-- Study Case (Pemanasan)
SELECT o.orderNumber, o.orderDate, o.status, c.customerNumber, c.customerName
FROM customers c
FULL OUTER JOIN orders o
ON o.customerNumber = c.customerNumber
WHERE o.status = 'Shipped' OR o.status = 'Resolved'
ORDER BY orderDate DESC;

-- Study Case Nomor 7
SELECT c.country, 
	   o.status, 
	   MIN(o.orderdate),
	   MAX(o.orderdate),
	   COUNT(DISTINCT o.orderNumber),
	   AVG(o.shippedDate - o.orderDate) AS avg_jumlah_hari
FROM customers c
INNER JOIN orders o
ON c.customerNumber = o.customerNumber
WHERE o.shippedDate IS NOT NULL
GROUP BY c.country, o.status
HAVING COUNT(DISTINCT o.orderNumber) > 3
ORDER BY c.country ASC, avg_jumlah_hari DESC;