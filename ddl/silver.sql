CREATE SCHEMA IF NOT EXISTS silver;

CREATE TABLE IF NOT EXISTS silver.material_master (
    material_id STRING,
    material_name STRING,
    material_type STRING,
    uom STRING,
    record_source STRING,
    ingestion_timestamp TIMESTAMP,
    job_id STRING,
    job_run_id STRING,
    create_date TIMESTAMP
)
USING DELTA
COMMENT 'Silver material master table with cleansed data';


CREATE TABLE IF NOT EXISTS silver.material_purchase (
    purchase_id STRING,
    material_id STRING,
    transaction_date DATE,
    quantity INT,
    price_per_unit DOUBLE,
    total_cost DOUBLE,
    vendor_name STRING,
    record_source STRING,
    ingestion_timestamp TIMESTAMP,
    job_id STRING,
    job_run_id STRING,
    create_date TIMESTAMP
)
USING DELTA
COMMENT 'Silver material purchase table with derived cost';


CREATE TABLE IF NOT EXISTS silver.customer_master (
    customer_id STRING,
    customer_name STRING,
    phone STRING,
    city STRING,
    record_source STRING,
    ingestion_timestamp TIMESTAMP,
    job_id STRING,
    job_run_id STRING,
    create_date TIMESTAMP
)
USING DELTA
COMMENT 'Silver customer master table';


CREATE TABLE IF NOT EXISTS silver.sales_orders (
    order_id STRING,
    customer_id STRING,
    order_date DATE,
    delivery_date DATE,
    cake_type STRING,
    quantity INT,
    order_amount DOUBLE,
    record_source STRING,
    ingestion_timestamp TIMESTAMP,
    job_id STRING,
    job_run_id STRING,
    create_date TIMESTAMP
)
USING DELTA
COMMENT 'Silver sales orders table';