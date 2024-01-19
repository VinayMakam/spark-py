# Use a lightweight base image
FROM vinaymakam/spark-py:3.3.4

USER root

RUN mkdir "/app"

WORKDIR /app

COPY pyspark_example_03.py /app/
COPY requirements.txt      /app/

# Install any needed packages specified in requirements.txt
RUN pip install --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# Command to run the PySpark application
CMD ["python", "/app/pyspark_example_03.py"]  
