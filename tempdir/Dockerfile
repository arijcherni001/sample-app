FROM python:3.9-slim

WORKDIR /home/myapp

RUN pip install flask

COPY ./static ./static
COPY ./templates ./templates
COPY sample_app.py .

EXPOSE 5050

CMD ["python3", "sample_app.py"]
