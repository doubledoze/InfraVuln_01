#!/bin/bash

# Fonction pour gérer le signal SIGINT (CTRL+C)
cleanup() {
    echo "Arrêt et suppression des conteneurs..."
    # Arrête et supprime les conteneurs et les ressources définies par votre docker-compose.yml
    docker compose down
    exit 0
}

# Piège le signal SIGINT et appelle la fonction cleanup
trap cleanup SIGINT

echo "Build des images et démarrage des conteneurs en cours... Patientez... Cela peut prendre quelques minutes."
# Démarrage :
docker compose up -d --build > docker-logs.txt 2>&1

# Vérifie si la commande précédente a réussi
if [ $? -ne 0 ]; then
    echo "Une erreur est survenue lors du build ou du lancement des conteneurs. Veuillez consulter le fichier docker-logs.txt."
    exit 1
fi

# Fonction pour afficher l'état des conteneurs avec format personnalisé
show_containers_status() {
    # Utiliser des séquences d'échappement ANSI pour le texte en gras et les couleurs
    local bold=$(tput bold)
    local normal=$(tput sgr0)
    local line=$(printf '%*s\n' "100" '' | tr ' ' '-')

    # Afficher l'en-tête avec un style distinct
    echo -e "${bold}Nom du service\t\tDate de création\tStatus${normal}"
    echo -e "${line}"

    # Récupérer les ID des conteneurs gérés par docker-compose
    container_ids=$(docker compose ps -q)

    # Itérer sur chaque ID de conteneur pour afficher les détails
    for container_id in $container_ids; do
        # Récupérer les informations nécessaires du conteneur
        service_name=$(docker inspect --format '{{ index .Config.Labels "com.docker.compose.service"}}' $container_id)
        creation_date=$(docker inspect --format '{{.Created}}' $container_id | cut -d 'T' -f 1)
        status=$(docker inspect --format '{{.State.Status}}' $container_id)

        # Déterminer l'indicateur de statut [OK] ou [NOK]
        # Déterminer l'indicateur de statut [OK] ou [NOK]
        if [ "$status" = "running" ]; then
            status_indicator="[OK]"
        else
            status_indicator="[NOK]"
        fi

        # Afficher les informations avec alignement
        printf "%-30s %-20s %-15s %s %b\n" "$service_name" "$creation_date" "$status" "$status_indicator"
    done
}

# Boucle infinie pour maintenir le script en cours d'exécution et afficher l'état des conteneurs
while true; do
    clear
    echo "██╗███╗   ██╗███████╗██████╗  █████╗ ██╗   ██╗██╗   ██╗██╗     ███╗   ██╗        ██╗   ██╗ ██╗";
    echo "██║████╗  ██║██╔════╝██╔══██╗██╔══██╗██║   ██║██║   ██║██║     ████╗  ██║        ██║   ██║███║";
    echo "██║██╔██╗ ██║█████╗  ██████╔╝███████║██║   ██║██║   ██║██║     ██╔██╗ ██║        ██║   ██║╚██║";
    echo "██║██║╚██╗██║██╔══╝  ██╔══██╗██╔══██║╚██╗ ██╔╝██║   ██║██║     ██║╚██╗██║        ╚██╗ ██╔╝ ██║";
    echo "██║██║ ╚████║██║     ██║  ██║██║  ██║ ╚████╔╝ ╚██████╔╝███████╗██║ ╚████║███████╗ ╚████╔╝  ██║";
    echo "╚═╝╚═╝  ╚═══╝╚═╝     ╚═╝  ╚═╝╚═╝  ╚═╝  ╚═══╝   ╚═════╝ ╚══════╝╚═╝  ╚═══╝╚══════╝  ╚═══╝   ╚═╝";
    echo "                                              ";

    echo "État actuel des conteneurs :"
    # Affiche l'état des conteneurs
    show_containers_status
    sleep 5 # Rafraîchit toutes les 5 secondes
done
