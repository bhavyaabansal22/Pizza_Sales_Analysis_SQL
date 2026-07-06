# SQL Query Documentation

## 📌 Description

This document contains all the SQL queries used in the Pizza Sales Analysis project. Each section includes the business objective, SQL query, explanation of the logic used, and the business insight derived from the analysis.

---

# 1. Retrieve the Total Number of Orders Placed

## Objective

Determine the total number of customer orders placed.

### SQL Query

```sql
SELECT COUNT(order_id) AS 'total orders placed'
FROM orders;
```

### Explanation

- Counts all order IDs present in the Orders table.
- Returns the total number of orders placed by customers.

### Business Insight

This metric provides an overview of customer activity and overall business volume.

---

# 2. Calculate Total Revenue Generated

## Objective

Calculate the total revenue earned from pizza sales.

### SQL Query

```sql
SELECT
    SUM(pizzas.price * order_details.quantity) AS total_sales
FROM pizzas
JOIN order_details
ON pizzas.pizza_id = order_details.pizza_id;
```

### Explanation

- Joins the Pizzas and Order Details tables.
- Multiplies the price of each pizza by the quantity ordered.
- Uses SUM() to calculate total revenue.

### Business Insight

Revenue is one of the primary KPIs used to evaluate business performance.

---

# 3. Identify the Highest-Priced Pizza

## Objective

Find the pizza with the highest selling price.

### SQL Query

```sql
SELECT
    pizza_types.name
FROM pizza_types
JOIN pizzas
ON pizzas.pizza_type_id = pizza_types.pizza_type_id
WHERE pizzas.price IN
(
SELECT MAX(price)
FROM pizzas
);
```

### Alternative Query

```sql
SELECT
    pizza_types.name,
    pizzas.price
FROM pizza_types
JOIN pizzas
ON pizzas.pizza_type_id = pizza_types.pizza_type_id
ORDER BY pizzas.price DESC
LIMIT 1;
```

### Explanation

- The first query uses a subquery to identify the maximum pizza price.
- The second query sorts pizzas by price in descending order and selects the first record.

### Business Insight

Premium pizzas often contribute significantly to overall revenue.

---

# 4. Identify the Most Common Pizza Size Ordered

## Objective

Determine the pizza size ordered most frequently.

### SQL Query

```sql
SELECT
    pizzas.size,
    COUNT(order_details.order_detail_id) AS order_count
FROM pizzas
JOIN order_details
ON pizzas.pizza_id = order_details.pizza_id
GROUP BY pizzas.size
ORDER BY order_count DESC
LIMIT 1;
```

### Explanation

- Groups records according to pizza size.
- Counts the number of orders for each size.
- Returns the most frequently ordered size.

### Business Insight

Understanding customer preferences helps optimize inventory and production planning.

---

# 5. List the Top 5 Most Ordered Pizza Types

## Objective

Identify the five pizza types ordered in the highest quantities.

### SQL Query

```sql
SELECT
    pizza_types.name,
    SUM(order_details.quantity) AS total_quantity
FROM pizza_types
JOIN pizzas
ON pizza_types.pizza_type_id = pizzas.pizza_type_id
JOIN order_details
ON pizzas.pizza_id = order_details.pizza_id
GROUP BY pizza_types.name
ORDER BY total_quantity DESC
LIMIT 5;
```

### Explanation

- Joins the Pizza Types, Pizzas, and Order Details tables.
- Calculates the total quantity sold for each pizza type.
- Returns the top five pizza varieties.

### Business Insight

Popular pizzas should receive greater inventory allocation and marketing focus.

---

# 6. Calculate Total Quantity Sold for Each Pizza Category

## Objective

Determine the total quantity sold across each pizza category.

### SQL Query

```sql
SELECT
    pizza_types.category,
    SUM(order_details.quantity)
FROM pizza_types
JOIN pizzas
ON pizza_types.pizza_type_id = pizzas.pizza_type_id
JOIN order_details
ON pizzas.pizza_id = order_details.pizza_id
GROUP BY pizza_types.category;
```

### Explanation

- Groups pizzas by category.
- Sums the quantities sold within each category.

### Business Insight

Highlights which pizza categories generate the greatest customer demand.

---

# 7. Determine the Distribution of Orders by Hour

## Objective

Analyze customer ordering patterns throughout the day.

### SQL Query

```sql
SELECT
    HOUR(order_time),
    COUNT(order_id)
FROM orders
GROUP BY HOUR(order_time)
ORDER BY COUNT(order_id) DESC;
```

### Explanation

- Extracts the hour from the order time.
- Counts the number of orders placed during each hour.
- Sorts the results from busiest to least busy hour.

### Business Insight

Identifying peak ordering hours helps optimize staffing and operational efficiency.

---

# 8. Determine the Category-wise Distribution of Pizza Types

## Objective

Count the number of pizza varieties available in each category.

### SQL Query

```sql
SELECT
    category,
    COUNT(name)
FROM pizza_types
GROUP BY category;
```

### Explanation

- Groups pizza records by category.
- Counts the number of pizza types available within each category.

### Business Insight

Provides an overview of the restaurant's menu composition across different categories.

---

# 9. Calculate the Average Number of Pizzas Ordered Per Day

## Objective

Determine the average number of pizzas sold each day.

### SQL Query

```sql
SELECT AVG(quantity)
FROM
(
SELECT
    orders.order_date,
    SUM(order_details.quantity) AS quantity
FROM orders
JOIN order_details
ON orders.order_id = order_details.order_id
GROUP BY orders.order_date
) AS order_quantity_per_day;
```

### Explanation

- Calculates the total pizzas sold for each day.
- Uses a subquery to obtain daily totals.
- Computes the average daily sales.

### Business Insight

Average daily demand is useful for forecasting inventory and staffing requirements.

---

# 10. Determine the Top 3 Pizza Types Based on Revenue

## Objective

Identify the pizza types generating the highest revenue.

### SQL Query

```sql
SELECT
    pizza_types.name,
    SUM(order_details.quantity * pizzas.price) AS revenue
FROM pizza_types
JOIN pizzas
ON pizzas.pizza_type_id = pizza_types.pizza_type_id
JOIN order_details
ON pizzas.pizza_id = order_details.pizza_id
GROUP BY pizza_types.name
ORDER BY revenue DESC
LIMIT 3;
```

### Explanation

- Calculates revenue for each pizza type.
- Revenue is computed as Price × Quantity Sold.
- Returns the three highest revenue-generating pizzas.

### Business Insight

These pizzas contribute the most to overall sales and can be prioritized in promotions and menu strategies.
