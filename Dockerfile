FROM python:3.10-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY app.py .
COPY healthcheck.sh .

# Make healthcheck script executable
RUN chmod +x healthcheck.sh

HEALTHCHECK --interval=5s --timeout=3s --retries=3 \
  CMD ["./healthcheck.sh"]

EXPOSE 5000

CMD ["python", "app.py"]
