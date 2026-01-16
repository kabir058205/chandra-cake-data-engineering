CREATE SCHEMA IF NOT EXISTS bronze;

CREATE TABLE IF NOT EXISTS bronze.material_master (
    material_id STRING COMMENT 'Unique identifier for material',
    material_name STRING COMMENT 'Material name',
    material_type STRING COMMENT 'RAW_MATERIAL or BOX_BOARD',
    uom STRING COMMENT 'Unit of measure',
    is_active STRING COMMENT 'Active flag (Y/N)',
    source_file STRING COMMENT 'Source CSV file name',
    ingestion_timestamp TIMESTAMP COMMENT 'Ingestion timestamp',
    job_id STRING COMMENT 'Databricks job id',
    job_run_id STRING COMMENT 'Databricks job run id',
    create_date TIMESTAMP COMMENT 'Record creation timestamp'
)
USING DELTA
COMMENT 'Bronze table for raw material master data';


CREATE TABLE IF NOT EXISTS bronze.material_purchase (
    purchase_id STRING COMMENT 'Purchase transaction id',
    material_id STRING COMMENT 'Material identifier',
    transaction_date STRING COMMENT 'Transaction date (raw)',
    quantity STRING COMMENT 'Quantity purchased (raw)',
    price_per_unit STRING COMMENT 'Unit price (raw)',
    vendor_name STRING COMMENT 'Vendor name',
    source_file STRING COMMENT 'Source CSV file name',
    ingestion_timestamp TIMESTAMP COMMENT 'Ingestion timestamp',
    job_id STRING COMMENT 'Databricks job id',
    job_run_id STRING COMMENT 'Databricks job run id',
    create_date TIMESTAMP COMMENT 'Record creation timestamp'
)
USING DELTA
COMMENT 'Bronze table for raw material purchase data';


CREATE TABLE IF NOT EXISTS bronze.customer_master (
    customer_id STRING COMMENT 'Customer identifier',
    customer_name STRING COMMENT 'Customer name',
    phone STRING COMMENT 'Phone number',
    city STRING COMMENT 'City',
    source_file STRING COMMENT 'Source CSV file name',
    ingestion_timestamp TIMESTAMP COMMENT 'Ingestion timestamp',
    job_id STRING COMMENT 'Databricks job id',
    job_run_id STRING COMMENT 'Databricks job run id',
    create_date TIMESTAMP COMMENT 'Record creation timestamp'
)
USING DELTA
COMMENT 'Bronze table for raw customer master data';


CREATE TABLE IF NOT EXISTS bronze.sales_orders (
    order_id STRING COMMENT 'Sales order id',
    customer_id STRING COMMENT 'Customer identifier',
    order_date STRING COMMENT 'Order date (raw)',
    delivery_date STRING COMMENT 'Delivery date (raw)',
    cake_type STRING COMMENT 'Cake type',
    quantity STRING COMMENT 'Quantity ordered (raw)',
    order_amount STRING COMMENT 'Order amount (raw)',
    source_file STRING COMMENT 'Source CSV file name',
    ingestion_timestamp TIMESTAMP COMMENT 'Ingestion timestamp',
    job_id STRING COMMENT 'Databricks job id',
    job_run_id STRING COMMENT 'Databricks job run id',
    create_date TIMESTAMP COMMENT 'Record creation timestamp'
)
USING DELTA
COMMENT 'Bronze table for raw sales order data';
