CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category TEXT,
    price NUMERIC(10,2),
    stock_quantity INT,
    is_available BOOLEAN,
    added_on DATE
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    product_id INT,
    quantity INT,
    order_date DATE,
    customer_name VARCHAR(50),
    payment_method VARCHAR(50),
    CONSTRAINT fk_product
        FOREIGN KEY (product_id)
        REFERENCES products(product_id)
        ON DELETE CASCADE
);

select * from orders;
select * from products;

select * from orders o inner join products p
on o.product_id=p.product_id;

--1. Show each order along with the product name and price.
SELECT o.order_id , o.customer_name, p.product_name, p.price
FROM orders o INNER JOIN products p
ON o.product_id=p.product_id;

--2. Show all products even if they were never ordered.
SELECT p.product_name, o.order_id
FROM products p LEFT JOIN orders o
ON o.product_id=p.product_id;

--3. Show orders for only 'Electronics' Category.
SELECT p.product_name, o.order_id, p.category
FROM orders o LEFT JOIN products p 
ON o.product_id=p.product_id
WHERE p.category='Electronics';

--4. List all orders stored by product price(high to low).
SELECT p.product_name, o.order_id, p.price
FROM orders o JOIN products p 
ON o.product_id=p.product_id
ORDER BY p.price DESC;

--5. Show number of orders placed for each product.
SELECT p.product_name, COUNT(o.order_id) AS total_orders
FROM products p
LEFT JOIN orders o ON p.product_id = o.product_id
GROUP BY p.product_name;

--6. Show total revenue earned per product.
SELECT p.product_name, SUM(o.quantity * p.price) AS revenue
FROM products p
JOIN orders o ON p.product_id = o.product_id
GROUP BY p.product_name;

--7. Show products where total order revenue>RS.2000
SELECT p.product_name, SUM(o.quantity * p.price) AS revenue
FROM products p
JOIN orders o ON p.product_id = o.product_id
GROUP BY p.product_name
HAVING SUM(o.quantity * p.price) > 2000;

--8. Show unique customers who ordered 'Fitness' Products.
SELECT DISTINCT o.customer_name
FROM orders o
JOIN products p ON o.product_id = p.product_id
WHERE p.category = 'Fitness';





















