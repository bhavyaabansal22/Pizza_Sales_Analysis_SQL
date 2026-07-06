-- Identify the highest-priced pizza.

SELECT 
    pizza_types.name
FROM
    pizza_types
        JOIN
    pizzas ON pizzas.pizza_type_id = pizza_types.pizza_type_id
WHERE
    pizzas.price IN (SELECT 
            MAX(price)
        FROM
            pizzas);
            
-- Other method
SELECT 
    pizza_types.name, pizzas.price
FROM
    pizza_types
        JOIN
    pizzas ON pizzas.pizza_type_id = pizza_types.pizza_type_id
ORDER BY pizzas.price DESC
LIMIT 1;	