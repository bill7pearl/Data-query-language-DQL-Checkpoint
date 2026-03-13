/* SQL Checkpoint: DQL Operations

   Author: Billel Chami

   Target: Relational Model (Customer, Product, Orders)

*/



--- 1. Display all the data of customers

SELECT * FROM CUSTOMER;



--- 2. Display product_name and category for products with price between 5000 and 10000

-- Using BETWEEN is cleaner and more readable than using >= and <=

SELECT product_name, category

FROM PRODUCT

WHERE Price BETWEEN 5000 AND 10000;



--- 3. Display all the data of products sorted in descending order of price

SELECT * FROM PRODUCT

ORDER BY Price DESC;



--- 4. Display total number of orders, average amount, highest and lowest total amount

-- These are Aggregate (Group) functions that return a single row for the whole table

SELECT 

    COUNT(*) AS total_orders, 

    AVG(total_amount) AS average_amount, 

    MAX(total_amount) AS highest_amount, 

    MIN(total_amount) AS lowest_amount

FROM ORDERS;



--- 5. For each product_id, display the number of orders

SELECT product_id, COUNT(*) AS num_orders

FROM ORDERS

GROUP BY product_id;



--- 6. Display the customer_id which has more than 2 orders

-- Remember: HAVING is used for filters on groups (after grouping)

SELECT customer_id

FROM ORDERS

GROUP BY customer_id

HAVING COUNT(*) > 2;



--- 7. For each month of the 2020 year, display the number of orders

-- Using EXTRACT for Oracle/Postgres or MONTH() for MySQL

SELECT EXTRACT(MONTH FROM OrderDate) AS order_month, COUNT(*) AS num_orders

FROM ORDERS

WHERE EXTRACT(YEAR FROM OrderDate) = 2020

GROUP BY EXTRACT(MONTH FROM OrderDate);



--- 8. For each order, display the product_name, customer_name and order date

-- This requires an Equijoin across three tables

SELECT p.product_name, c.customer_name, o.OrderDate

FROM ORDERS o

JOIN PRODUCT p ON o.product_id = p.product_id

JOIN CUSTOMER c ON o.customer_id = c.customer_id;



--- 9. Display all the orders made three months ago

-- ADD_MONTHS(SYSDATE, -3) is the standard Oracle approach for relative dates

SELECT *

FROM ORDERS

WHERE OrderDate >= ADD_MONTHS(SYSDATE, -3) 

  AND OrderDate < ADD_MONTHS(SYSDATE, -2);



--- 10. Display customers (customer_id) who have never ordered a product

-- Using the SET operator MINUS to find the difference between all IDs and ordering IDs

SELECT customer_id FROM CUSTOMER

MINUS

SELECT customer_id FROM ORDERS;



/* Alternative for #10 using a Sub-query (if your platform prefers it):

   SELECT customer_id FROM CUSTOMER 

   WHERE customer_id NOT IN (SELECT customer_id FROM ORDERS);

*/
