CREATE OR REPLACE VIEW vw_online_retail_clean AS
SELECT
    invoice_no,
    stock_code,
    description,
    quantity,
    invoice_date,
    unit_price,
    (quantity * unit_price) AS total_amount,
    customer_id,
    country
FROM online_retail
WHERE quantity > 0
  AND unit_price > 0
  AND description IS NOT NULL;

-- Métrica global
SELECT SUM(quantity * unit_price) AS ventas_totales
FROM online_retail;

-- Ventas por mes
SELECT DATE_TRUNC('month', invoice_date) AS mes,
       SUM(quantity * unit_price) AS ventas
FROM online_retail
GROUP BY 1
ORDER BY 1;

-- Top 10 productos
SELECT description,
       SUM(quantity * unit_price) AS ventas
FROM online_retail
GROUP BY description
ORDER BY ventas DESC
LIMIT 10;

-- Top 10 países
SELECT country,
       SUM(quantity * unit_price) AS ventas
FROM online_retail
GROUP BY country
ORDER BY ventas DESC
LIMIT 10;
