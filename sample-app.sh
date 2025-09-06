#!/bin/bash

# Créer les dossiers si ils n'existent pas
[ ! -d tempdir ] && mkdir tempdir
[ ! -d tempdir/templates ] && mkdir tempdir/templates
[ ! -d tempdir/static ] && mkdir tempdir/static

# Copier les fichiers
cp sample_app.py tempdir/ 2>/dev/null
cp -r templates/* tempdir/templates/ 2>/dev/null
cp -r static/* tempdir/static/ 2>/dev/null

# Créer le Dockerfile
cat > tempdir/Dockerfile <<EOL
FROM python:3.11-slim

RUN pip install --no-cache-dir flask gunicorn --progress-bar off

COPY ./static /home/myapp/static/
COPY ./templates /home/myapp/templates/
COPY sample_app.py /home/myapp/

# Définir le répertoire de travail
WORKDIR /home/myapp

EXPOSE 5050

CMD ["gunicorn", "--bind", "0.0.0.0:5050", "--workers", "4", "sample_app:app"]
EOL

# Aller dans le dossier tempdir
cd tempdir || exit

# Construire l'image Docker
docker build -t sampleapp .

# Supprimer un conteneur existant si présent
docker rm -f samplerunning 2>/dev/null

# Lancer le conteneur sur le port 5050
docker run -d -p 5050:5050 --name samplerunning sampleapp

# Afficher les conteneurs en cours
docker ps -a
