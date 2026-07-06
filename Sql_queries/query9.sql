-- Group the orders by date and calculate the average number of pizzas ordered per day.

SELECT AVG(quantity) FROM 
(SELECT orders.order_data, SUM(order_details.quantity) AS quantity
FROM orders
JOIN order_details
ON orders.order_id=order_details.order_id
GROUP BY orders.order_data)
AS order_quantity_per_day;