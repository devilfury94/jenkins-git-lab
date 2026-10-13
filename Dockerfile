FROM python:3.13-slim

RUN mkdir -p /app

COPY hello.py /app/hello.py

CMD ["python3", "/app/hello.py"]
