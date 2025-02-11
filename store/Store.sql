-- drop tables
DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS products;

-- make the tables


CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    stock_quantity INT NOT NULL
);


CREATE TABLE customers (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL
);


CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_customer FOREIGN KEY (customer_id) REFERENCES customers(id) ON DELETE CASCADE
);

-- order items (PK)
CREATE TABLE order_items (
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    PRIMARY KEY (order_id, product_id),
    CONSTRAINT fk_order FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE,
    CONSTRAINT fk_product FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE
);

-- sample data goes here


INSERT INTO products (product_name, price, stock_quantity) VALUES
('Laptop', 1200.00, 10),
('Headphones', 150.00, 25),
('Keyboard', 80.00, 30),
('Monitor', 300.00, 15),
('Mouse', 50.00, 40);


INSERT INTO customers (first_name, last_name, email) VALUES
('Alice', 'Johnson', 'alice.johnson@example.com'),
('Bob', 'Smith', 'bob.smith@example.com'),
('Charlie', 'Brown', 'charlie.brown@example.com'),
('Diana', 'Evans', 'diana.evans@example.com');


INSERT INTO orders (customer_id, order_date) VALUES
(1, '2024-02-01'),
(2, '2024-02-02'),
(3, '2024-02-03'),
(4, '2024-02-04'),
(1, '2024-02-05'); -- Alice places another order

-- insert order item/s

INSERT INTO order_items (order_id, product_id, quantity) VALUES
(1, 1, 1), -- Laptop
(1, 2, 2), -- Headphones
(2, 3, 1), -- Keyboard
(2, 4, 1), -- Monitor
(3, 2, 1), -- Headphones
(3, 5, 2), -- Mouse
(4, 3, 2), -- Keyboard
(4, 1, 1), -- Laptop
(5, 4, 1), -- Monitor
(5, 5, 3); -- Mouse

-- output data


SELECT * FROM products;


SELECT * FROM customers;


SELECT * FROM orders;


SELECT * FROM order_items;
