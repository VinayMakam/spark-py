# Use a lightweight base image
FROM vinaymakam/spark-py:3.3.4

USER root

RUN mkdir "/app"

RUN mkdir "/opt/spark/source"
RUN mkdir "/opt/spark/target"

WORKDIR /app

COPY source/zipcodes.csv /app/source/
COPY pyspark_example_02.py /app/

# Command to run the PySpark application
CMD ["python", "/app/pyspark_example_02.py /app/source/zipcodes.csv"]  
