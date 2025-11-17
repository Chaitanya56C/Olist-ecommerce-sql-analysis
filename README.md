# SQL Data Analysis – Brazilian E-Commerce (Olist Dataset)

## Project Overview
This project is part of my **Data Analyst Internship Task – SQL for Data Analysis**.  
Using **MySQL**, I analyzed an e-commerce dataset from Kaggle by performing data extraction, joins, aggregations, subqueries, views, and query optimization.

## Dataset
**Source:** Kaggle – *Brazilian E-Commerce Public Dataset by Olist*

### Tables Used
- customers  
- orders  
- order_items  
- products  
- sellers  
- order_payments  
- order_reviews  
- geolocation  

## SQL Concepts Covered
- SELECT, WHERE, ORDER BY, GROUP BY  
- INNER / LEFT / RIGHT JOINS  
- Subqueries  
- Aggregate functions (SUM, AVG, COUNT, MAX, MIN)  
- Views for analysis  
- Indexes for performance  

## MySQL Setup

### 1. Create Database
'''sql'''
CREATE DATABASE olist;
USE olist;
### 2. Import CSV Files
Used Table Data Import Wizard in MySQL Workbench.

## Sample SQL Queries
1. Basic Query
SELECT * FROM orders LIMIT 20;
2. Join Query
SELECT o.order_id, c.customer_city
FROM orders o
INNER JOIN customers c ON o.customer_id = c.customer_id;
3.Aggregate Query
SELECT SUM(payment_value) AS total_revenue
FROM order_payments;
4.Subquery
SELECT order_id, payment_value
FROM order_payments
WHERE payment_value > (SELECT AVG(payment_value) FROM order_payments);
5.Create View
CREATE VIEW monthly_revenue AS
SELECT MONTH(order_purchase_timestamp) AS month,
       SUM(payment_value) AS total_revenue
FROM orders
JOIN order_payments USING(order_id)
GROUP BY month;

## Insights Generated

Total marketplace revenue
Best-selling product categories
Top customer cities & states
Monthly revenue trends
High-value customers

## Conclusion

This project improved my skills in:
SQL querying
Relational database handling
Data extraction and analysis
Query optimization using indexes

## Acknowledgment
Dataset: Brazilian E-Commerce Public Dataset by Olist (Kaggle)
