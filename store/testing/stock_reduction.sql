UPDATE products 
SET stock_quantity = stock_quantity - (
    SELECT SUM(oi.quantity)
    FROM order_items oi
    WHERE oi.order_id = 1 AND oi.product_id = products.id
)

WHERE id IN (SELECT product_id FROM order_items WHERE order_id = 1);