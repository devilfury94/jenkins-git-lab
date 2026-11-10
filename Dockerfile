FROM python:3.13-slim

RUN mkdir -p /app

COPY app.py /app/app.py

CMD ["python3", "/app/app.py"]
