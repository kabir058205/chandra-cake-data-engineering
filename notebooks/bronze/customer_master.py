# Databricks notebook source
# DBTITLE 1,Cell 1
import pandas as pd
# Use the raw GitHub URL for the CSV file
raw_url = "https://raw.githubusercontent.com/kabir058205/chandra-cake-data-engineering/main/data/customer_master.csv"
df = pd.read_csv(raw_url)


# COMMAND ----------

# DBTITLE 1,Cell 2
df.head()

# COMMAND ----------

# DBTITLE 1,Save DataFrame as CSV to bronze volume
# Save the DataFrame as CSV to a Unity Catalog volume (recommended for AWS serverless)
bronze_path = "/Volumes/workspace/bronze/customer_master/customer_master.csv"
df.to_csv(bronze_path, index=False)
print(f"CSV file saved to {bronze_path}")

# COMMAND ----------

# DBTITLE 1,Read CSV and store in bronze table
from pyspark.sql.functions import current_timestamp, col, lit

bronze_path = "/Volumes/workspace/bronze/customer_master/customer_master.csv"

# Read CSV file using Spark
spark_df = (
    spark.read.option("header", "true")
    .csv(bronze_path)
    .withColumn("source_file", col("_metadata.file_path"))
    .withColumn("ingestion_timestamp", current_timestamp())
    .withColumn("create_date", current_timestamp())
)

# Drop columns with invalid names (e.g., Unnamed: 4, Unnamed: 5, Unnamed: 6)
for col_name in spark_df.columns:
    if col_name.startswith("Unnamed:"):
        spark_df = spark_df.drop(col_name)

# Write to bronze table in Delta format
spark_df.write.mode("append").format("delta").option("mergeSchema", "true").saveAsTable("bronze.customer_master")
display(f"Data from {bronze_path} loaded to bronze.customer_master table.")
