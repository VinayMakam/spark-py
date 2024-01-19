# Use a lightweight base image
FROM vinaymakam/spark-py:3.3.4

USER root

RUN mkdir /app

# Set the working directory
WORKDIR /app

# Copy the PySpark application code
COPY pyspark_example_01.py /app/

# Command to run the PySpark application
CMD ["python", "/app/pyspark_example_01.py"]  
