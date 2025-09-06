#!/bin/bash

# Nettoyer l'ancien répertoire si existe
rm -rf tempdir
mkdir tempdir
mkdir tempdir/templates
mkdir tempdir/static

# --- Création du fichier Flask ---
cat > tempdir/sample_app.py << 'EOF'
from flask import Flask

app = Flask(__name__)

@app.route("/")
def home():
    return "Hello from Mini Flask App inside Docker!"

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8080, debug=True)
EOF

# --- Dockerfile ---
cat > tempdir/Dockerfile << 'EOF'
FROM python:3.10-slim

# Mettre pip à une version stable et désactiver la barre de progression
RUN pip install --upgrade pip==23.0.1
RUN pip install --no-cache-dir --progress-bar=off flask

WORKDIR /home/myapp
COPY sample_app.py /home/myapp/

EXPOSE 8080
CMD ["python3", "sample_app.py"]
EOF

# --- Build & Run ---
cd tempdir
docker build -t sampleapp .
docker run -d -p 8080:8080 sampleapp
