#!/bin/bash

# Identifiants pour l'authentification
USERNAME="$1"
PASSWORD="$2"

# URL de la page principale et de la page d'authentification
MAIN_URL="http://web.bigbusiness.loc/"
AUTH_URL="${MAIN_URL}check_login.php"

# Chargement de la page principale
curl $MAIN_URL

# Attente de 5 secondes avant l'authentification
sleep 5

# Envoi de la demande d'authentification
curl -d "username=$USERNAME&password=$PASSWORD" -X POST $AUTH_URL
