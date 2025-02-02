#!/bin/bash

# Définition du fichier d'inventaire et du fichier known_hosts
INVENTORY_FILE="ansible/inventory/hosts"
KNOWN_HOSTS_FILE="$HOME/.ssh/known_hosts"

# Vérifier si le fichier d'inventaire existe
if [ ! -f "$INVENTORY_FILE" ]; then
    echo "Fichier d'inventaire $INVENTORY_FILE introuvable!"
    exit 1
fi

# Extraire les adresses IP des hôtes depuis ansible_host
HOSTS=$(grep -oP '(?<=ansible_host=)[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+' "$INVENTORY_FILE" | sort -u)

# Vérifier s'il y a des hôtes à ajouter
if [ -z "$HOSTS" ]; then
    echo "Aucune adresse IP trouvée dans $INVENTORY_FILE"
    exit 1
fi

# Scanner les clés SSH et les ajouter au fichier known_hosts
for HOST in $HOSTS; do
    echo "Ajout de $HOST à known_hosts..."
    ssh-keyscan "$HOST" >> "$KNOWN_HOSTS_FILE"
done

echo "Mise à jour de $KNOWN_HOSTS_FILE terminée."
