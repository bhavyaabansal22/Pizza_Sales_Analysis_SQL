-- Calculate the total revenue generated from pizza sales.

SELECT 
    SUM(pizzas.price * order_details.quantity) AS total_sales
FROM
    pizzas
        JOIN
    order_details ON pizzas.pizza_id = order_details.pizza_id;
    