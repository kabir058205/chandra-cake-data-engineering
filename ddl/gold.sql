CREATE SCHEMA IF NOT EXISTS gold;

CREATE TABLE IF NOT EXISTS gold.material_expense_summary (
    material_id STRING,
    total_material_expense DOUBLE,
    create_date TIMESTAMP,
    job_id STRING,
    job_run_id STRING
)
USING DELTA
COMMENT 'Gold table summarizing total material expense';


CREATE TABLE IF NOT EXISTS gold.sales_revenue_summary (
    cake_type STRING,
    total_revenue DOUBLE,
    create_date TIMESTAMP,
    job_id STRING,
    job_run_id STRING
)
USING DELTA
COMMENT 'Gold table summarizing revenue by cake type';
