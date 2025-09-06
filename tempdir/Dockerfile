FROM python:3.10-slim

# Mettre pip à une version stable et désactiver la barre de progression
RUN pip install --upgrade pip==23.0.1
RUN pip install --no-cache-dir --progress-bar=off flask

WORKDIR /home/myapp
COPY sample_app.py /home/myapp/

EXPOSE 8080
CMD ["python3", "sample_app.py"]
