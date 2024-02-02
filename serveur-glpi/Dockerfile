# Utiliser l'image de base PHP avec Apache
FROM php:7.4-apache

# Installer les dépendances nécessaires pour GLPI et les extensions PHP requises
RUN apt-get update && apt-get install -y \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng-dev \
    libldap2-dev \
    libicu-dev \
    libxml2-dev \
    libzip-dev \
    mariadb-server \
    curl \
    unzip \
    git \
    netcat-traditional \
    && rm -rf /var/lib/apt/lists/* \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install gd mysqli pdo pdo_mysql ldap intl xmlrpc zip

# Télécharger GLPI 9.5.6 et décompresser l'archive
RUN curl -L https://github.com/glpi-project/glpi/releases/download/9.5.6/glpi-9.5.6.tgz | tar zx -C /var/www/html --strip-components=1

# Installer Composer
#RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Changer le propriétaire des fichiers décompressés pour l'utilisateur www-data
RUN chown -R www-data:www-data /var/www/html

# Copier le flag
COPY flag.txt /var/www/flag.txt
RUN chmod 777 /var/www/flag.txt
RUN chown www-data:www-data /var/www/flag.txt

# Copier le script d'initialisation
COPY init_glpi.sh /usr/local/bin/init_glpi.sh
RUN chmod +x /usr/local/bin/init_glpi.sh

# Exposer le port 80
EXPOSE 80

# Définir le script d'initialisation comme point d'entrée
ENTRYPOINT ["init_glpi.sh"]
