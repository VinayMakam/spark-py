FROM vinaymakam/spark-py:3.4.2

USER root

RUN mkdir "/app"

WORKDIR /app

COPY spark_simple.py /app/

# Command to run the PySpark application
CMD ["python", "/app/spark_simple.py"]
