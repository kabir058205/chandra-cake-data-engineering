from pyspark.sql.functions import col, to_date, lit, current_timestamp

job_id = dbutils.widgets.get("job_id")
job_run_id = dbutils.widgets.get("job_run_id")

df = (
    spark.table("bronze.material_purchase")
    .withColumn("transaction_date", to_date("transaction_date"))
    .withColumn("quantity", col("quantity").cast("int"))
    .withColumn("price_per_unit", col("price_per_unit").cast("double"))
    .withColumn("total_cost", col("quantity") * col("price_per_unit"))
    .select(
        "purchase_id",
"material_id",
"transaction_date",
"quantity",
"price_per_unit",
"total_cost",
"vendor_name",
        lit("material_purchase_csv").alias("record_source"),
"ingestion_timestamp",
        lit(job_id).alias("job_id"),
        lit(job_run_id).alias("job_run_id"),
        current_timestamp().alias("create_date")
    )
)

df.write.mode("overwrite").format("delta").saveAsTable("silver.material_purchase")
