A. SELECT, WHERE, ORDER BY, GROUP BY
1. View first 20 orders
SELECT *
FROM orders
LIMIT 20;
-------------------------

2. Get only delivered orders
SELECT *
FROM orders
WHERE order_status = 'delivered';
--------------------------

3. Latest 10 orders
SELECT order_id, order_purchase_timestamp
FROM orders
ORDER BY order_purchase_timestamp DESC
LIMIT 10;
---------------------

4. Count of orders by status
SELECT order_status, COUNT(*) AS total_orders
FROM orders
GROUP BY order_status
ORDER BY total_orders DESC;
------------------

B. JOINS (INNER, LEFT, RIGHT)
5. INNER JOIN – Orders + Customers
SELECT
o.order_id,
o.order_purchase_timestamp,
c.customer_city,
c.customer_state
FROM orders o
INNER JOIN customers c
ON o.customer_id = c.customer_id;
----------------------------------

6. LEFT JOIN – Orders with payments
SELECT
o.order_id,
o.order_status,
p.payment_value
FROM orders o
LEFT JOIN payments p
ON o.order_id = p.order_id;
------------------------------

7. RIGHT JOIN – Sellers with order items
SELECT
oi.order_id,
s.seller_id,
s.seller_city
FROM order_items oi
RIGHT JOIN sellers s
ON oi.seller_id = s.seller_id;
-----------------------

C. SUBQUERIES
8. Orders above average payment value
SELECT order_id, payment_value
FROM payments
WHERE payment_value > (
SELECT AVG(payment_value) FROM payments
);
-------------------------

9. Customers who placed more than 5 orders
SELECT customer_id
FROM orders
GROUP BY customer_id
HAVING COUNT(order_id) > 5;
-------------------------

10. Top 5 most expensive products
SELECT product_id, price
FROM order_items
WHERE price > (
SELECT AVG(price) FROM order_items
)
ORDER BY price DESC
LIMIT 5;
---------------------

D. Aggregate Functions (SUM, AVG, COUNT, MIN, MAX)
11. Total revenue
SELECT SUM(payment_value) AS total_revenue
FROM payments;
---------------------

12. Average order value
SELECT AVG(payment_value) AS avg_order_value
FROM payments;
------------------------

13. Total sales by product category
SELECT
p.product_category_name,
SUM(oi.price) AS total_sales
FROM order_items oi
JOIN products p
ON oi.product_id = p.product_id
GROUP BY p.product_category_name
ORDER BY total_sales DESC;
------------------------------

E. Create Views for Analysis
14. Create a monthly revenue view
CREATE VIEW monthly_revenue AS
SELECT
MONTH(o.order_purchase_timestamp) AS month,
SUM(p.payment_value) AS total_revenue
FROM orders o
JOIN payments p ON o.order_id = p.order_id
GROUP BY month
ORDER BY month;
-------------------------

15. View top customers
CREATE VIEW top_customers AS
SELECT
o.customer_id,
SUM(p.payment_value) AS total_spent
FROM orders o
JOIN payments p ON o.order_id = p.order_id
GROUP BY o.customer_id
ORDER BY total_spent DESC;
------------------------

F. Optimize Queries With Indexes
16. Index on customer_id in orders
CREATE INDEX idx_orders_customer
ON orders(customer_id);
-----------------------

17. Index on product_id in order_items
CREATE INDEX idx_orderitems_product
ON order_items(product_id);
-------------------------

18. Index on category for faster category analysis
CREATE INDEX idx_products_category
ON products(product_category_name);
----------------------

19. Best-selling cities
SELECT
c.customer_city,
COUNT(o.order_id) AS total_orders
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id
GROUP BY c.customer_city
ORDER BY total_orders DESC
LIMIT 10;
---------------------

20. Top 10 most profitable products
SELECT
oi.product_id,
SUM(oi.price) AS total_sales
FROM order_items oi
GROUP BY oi.product_id
ORDER BY total_sales DESC
LIMIT 10;
