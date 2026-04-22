DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS customers;

CREATE TABLE customers (
    customer_id BIGINT PRIMARY KEY,
    is_paying_customer BOOLEAN,
    returning_customer BOOLEAN,
    completed_orders_count INTEGER,
    total_orders_count INTEGER,
    total_orders_value NUMERIC(12,2),
    date_created_utc TIMESTAMP
);

CREATE TABLE orders (
    order_id BIGINT PRIMARY KEY,
    customer_id BIGINT,
    order_status TEXT,
    currency TEXT,
    created_via TEXT,
    is_returning_order BOOLEAN,
    billing_country TEXT,
    shipping_country TEXT,
    order_total NUMERIC(12,2),
    total_tax NUMERIC(12,2),
    discount_total NUMERIC(12,2),
    shipping_total NUMERIC(12,2),
    date_created_utc TIMESTAMP,
    date_paid_gmt TIMESTAMP
);

COPY customers (
    customer_id,
    is_paying_customer,
    returning_customer,
    completed_orders_count,
    total_orders_count,
    total_orders_value,
    date_created_utc
)
FROM '/data/customers.csv'
DELIMITER ','
CSV HEADER;

COPY orders (
    order_id,
    customer_id,
    order_status,
    currency,
    created_via,
    is_returning_order,
    billing_country,
    shipping_country,
    order_total,
    total_tax,
    discount_total,
    shipping_total,
    date_created_utc,
    date_paid_gmt
)
FROM '/data/orders.csv'
DELIMITER ','
CSV HEADER;