#!/bin/bash

# Démarrer le service MySQL
service mariadb start

# Attendre que MySQL soit prêt (ajustez le temps d'attente si nécessaire)
sleep 10

# Créer la base de données GLPI et l'utilisateur
mysql -e "CREATE DATABASE glpi CHARACTER SET utf8 COLLATE utf8_bin;"
mysql -e "CREATE USER 'glpi'@'localhost' IDENTIFIED BY 'glpi';"
mysql -e "GRANT ALL PRIVILEGES ON glpi.* TO 'glpi'@'localhost';"
mysql -e "FLUSH PRIVILEGES;"

# Configuration de la connexion à la base de données via la console GLPI
php /var/www/html/bin/console db:configure --db-host=127.0.0.1 --db-name=glpi --db-user=glpi --db-password=glpi -n

# Installation de la base de données GLPI via la console GLPI
php /var/www/html/bin/console db:install --reconfigure --force --default-language=en_GB --db-host=127.0.0.1 --db-name=glpi --db-user=glpi --db-password=glpi -n

# Lancer Apache en arrière-plan
apache2-foreground
