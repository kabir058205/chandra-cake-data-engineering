import pandas as pd
from pyspark.sql.functions import current_timestamp, input_file_name, lit


# Use the raw GitHub URL for the CSV file
raw_url = "https://raw.githubusercontent.com/kabir058205/chandra-cake-data-engineering/main/data/customer_master.csv"
df = pd.read_csv(raw_url)

dbutils.widgets.text("job_id", "")
dbutils.widgets.text("job_run_id", "")

job_id = dbutils.widgets.get("job_id")
job_run_id = dbutils.widgets.get("job_run_id")

df = (
    spark.read.option("header",
"true")
    .csv("/mnt/chandra_cake/raw/material_purchase.csv")
    .withColumn("source_file", input_file_name())
    .withColumn("ingestion_timestamp", current_timestamp())
    .withColumn("job_id", lit(job_id))
    .withColumn("job_run_id", lit(job_run_id))
    .withColumn("create_date", current_timestamp())
)

df.write.mode("append").format("delta").saveAsTable("bronze.customer_master")
