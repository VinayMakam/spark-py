from pyspark.sql import SparkSession

def main():
    
    spark = SparkSession.builder.appName("pyspark-example-01").getOrCreate()

    data = [("Adira", "009"), ("Atira", "018"), ("Rashmi", "027")]
    df = spark.createDataFrame(data)
    df.show()
    
    spark.stop()

if __name__ == "__main__":
    main()
