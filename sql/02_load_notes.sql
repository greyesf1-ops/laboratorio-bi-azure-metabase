-- Notas de carga del dataset Online Retail

-- 1. El archivo CSV utilizado fue "Online Retail.csv".
-- 2. El separador correcto del archivo fue punto y coma (;).
-- 3. Debido al formato de los datos, primero se creó una tabla temporal
--    con todos los campos en texto para facilitar la importación.
-- 4. Posteriormente se transformaron los campos quantity, invoice_date
--    y unit_price a sus tipos correspondientes.

DROP TABLE IF EXISTS online_retail_raw;

CREATE TABLE online_retail_raw (
    invoice_no TEXT,
    stock_code TEXT,
    description TEXT,
    quantity TEXT,
    invoice_date TEXT,
    unit_price TEXT,
    customer_id TEXT,
    country TEXT
);

COPY online_retail_raw(invoice_no, stock_code, description, quantity, invoice_date, unit_price, customer_id, country)
FROM '/tmp/online_retail.csv'
DELIMITER ';'
CSV HEADER;

-- Conversión a tabla final
DROP TABLE IF EXISTS online_retail;

CREATE TABLE online_retail AS
SELECT
    invoice_no,
    stock_code,
    description,
    CAST(quantity AS INTEGER) AS quantity,
    TO_TIMESTAMP(invoice_date, 'DD/MM/YYYY HH24:MI') AS invoice_date,
    CAST(unit_price AS NUMERIC(10,2)) AS unit_price,
    customer_id,
    country
FROM online_retail_raw;

-- Validación
SELECT COUNT(*) FROM online_retail;
