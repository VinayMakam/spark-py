from pyspark.sql import SparkSession

def main():
    spark = SparkSession.builder.appName("example-pyspark-app").getOrCreate()
    
    # Your PySpark code here
    
    spark.stop()

if __name__ == "__main__":
    main()

