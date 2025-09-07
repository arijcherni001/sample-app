#!/bin/bash
set -e  # arrêter en cas d'erreur

# Nettoyage si déjà présent
rm -rf tempdir
mkdir -p tempdir/templates
mkdir -p tempdir/static

# Copier les fichiers de l'application
cp sample_app.py tempdir/
cp -r templates/* tempdir/templates/ || true
cp -r static/* tempdir/static/ || true

# Créer le Dockerfile
cat > tempdir/Dockerfile <<EOF
FROM python:3.9-slim

WORKDIR /home/myapp

RUN pip install flask

COPY ./static ./static
COPY ./templates ./templates
COPY sample_app.py .

EXPOSE 5050

CMD ["python3", "sample_app.py"]
EOF

# Construction de l'image
cd tempdir
docker build -t sampleapp .

# Supprimer le conteneur s'il existe déjà
docker rm -f samplerunning 2>/dev/null || true

# Lancer le conteneur
docker run -d -p 5050:5050 --name samplerunning sampleapp

# Vérifier les conteneurs actifs
docker ps -a
