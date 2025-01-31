FROM python:3.13-slim

# Installation de Node.js et autres dépendances nécessaires
RUN apt-get update && apt-get install -y \
    curl \
    awscli \
    gnupg \
    lsb-release \
    && curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
    && apt-get install -y nodejs \
    && rm -rf /var/lib/apt/lists/*

# Installation de AWS CDK CLI via npm
RUN npm install -g aws-cdk

# Définition du dossier de travail par défaut
WORKDIR /app
ADD requirements.txt /app/requirements.txt
RUN pip install --upgrade -r requirements.txt
COPY ./ /app

# Commande par défaut : ouvrir un shell interactif
CMD ["/bin/bash"]
