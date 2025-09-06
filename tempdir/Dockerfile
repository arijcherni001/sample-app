FROM python:3.11-slim

RUN pip install --no-cache-dir flask gunicorn --progress-bar off

COPY ./static /home/myapp/static/
COPY ./templates /home/myapp/templates/
COPY sample_app.py /home/myapp/

# Définir le répertoire de travail
WORKDIR /home/myapp

EXPOSE 5050

CMD ["gunicorn", "--bind", "0.0.0.0:5050", "--workers", "4", "sample_app:app"]
