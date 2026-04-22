/*
  oxy:
    database: demo
    embed:
      - What are the top 3 billing countries by order total?
      - Which billing countries have the highest total sales?
      - Show the top billing countries by revenue
*/
SELECT billing_country, SUM(order_total) AS total_order_amount
FROM orders
GROUP BY billing_country
ORDER BY total_order_amount DESC
LIMIT 3