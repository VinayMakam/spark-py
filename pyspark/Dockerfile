# Use a lightweight base image
FROM vinaymakam/spark-py:3.4.2

USER root

RUN mkdir /app

# Set the working directory
WORKDIR /app

# Copy the PySpark application code
COPY example_pyspark_app.py /app/

# Command to run the PySpark application
CMD ["python", "/app/example_pyspark_app.py"]  
