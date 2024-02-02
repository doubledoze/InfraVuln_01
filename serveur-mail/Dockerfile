FROM docker.io/mailserver/docker-mailserver:latest

# Définir les variables d'environnement pour configurer docker-mailserver
ENV ENABLE_SPAMASSASSIN=1 \
    ENABLE_CLAMAV=1 \
    ENABLE_FAIL2BAN=1 \
    ENABLE_POSTGREY=1 \
    ONE_DIR=1 \
    DMS_DEBUG=0 \
    ENABLE_POP3=1 \
    ENABLE_IMAP=1

# Installer les dépendances nécessaires pour Roundcube
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    roundcube roundcube-sqlite3 \
    apache2 libapache2-mod-php \
    php php-sqlite3 php-mysql php-intl php-json php-gd php-curl curl\
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Configuration de Apache pour Roundcube
RUN ln -s /etc/roundcube/apache.conf /etc/apache2/sites-available/roundcube.conf
RUN sed -i 's|#    Alias /roundcube /var/lib/roundcube|    Alias /roundcube /var/lib/roundcube|' /etc/apache2/sites-available/roundcube.conf
RUN a2ensite roundcube
RUN a2enmod rewrite
RUN service apache2 start

# Configuration de Roundcube (ajustez selon vos besoins)
# Attention : pour une utilisation réelle, assurez-vous de configurer correctement la base de données et les paramètres de sécurité
RUN sed -i "s/\$config\['default_host'\] = '';/\$config\['default_host'\] = 'localhost';/" /etc/roundcube/config.inc.php
RUN sed -i "s/\$config\['smtp_server'\] = '';/\$config\['smtp_server'\] = 'localhost';/" /etc/roundcube/config.inc.php
RUN sed -i "s/\$config\['smtp_port'\] = 25;/\$config\['smtp_port'\] = 587;/" /etc/roundcube/config.inc.php
RUN sed -i "s/\$config\['smtp_user'\] = '';/\$config\['smtp_user'\] = '%u';/" /etc/roundcube/config.inc.php
RUN sed -i "s/\$config\['smtp_pass'\] = '';/\$config\['smtp_pass'\] = '%p';/" /etc/roundcube/config.inc.php

# Configuration de Roundcube pour utiliser SQLite
RUN sed -i "s|include_once(\"/etc/roundcube/debian-db-roundcube.php\");|\$config['db_dsnw'] = 'sqlite:////var/lib/roundcube/db.sqlite';|g" /etc/roundcube/config.inc.php

# Initialiser la base de données SQLite pour Roundcube
RUN sqlite3 /var/lib/roundcube/db.sqlite < /usr/share/roundcube/SQL/sqlite.initial.sql

# Configurer les permissions sur la BDD
RUN chown www-data:www-data /var/lib/roundcube/db.sqlite
RUN chmod 640 /var/lib/roundcube/db.sqlite
RUN chown www-data:www-data /var/lib/roundcube
RUN chmod 750 /var/lib/roundcube

# Remplacer le fichier index.html par défaut par une redirection vers /roundcube
RUN echo '<meta http-equiv="refresh" content="0; url=/roundcube/" />' > /var/www/html/index.html

# Configurer Postfix
RUN sed -i 's/smtpd_sasl_auth_enable = no/smtpd_sasl_auth_enable = yes/' /etc/postfix/main.cf && \
    sed -i 's/smtpd_helo_required = yes/smtpd_helo_required = no/' /etc/postfix/main.cf
RUN echo "smtpd_tls_auth_only = no" >> /etc/postfix/main.cf

# Exposer les ports nécessaires
EXPOSE 25 143 587 993 80

# Configurer les volumes (ajustez selon vos besoins)
VOLUME ["/var/mail", "/var/mail-state", "/var/log/mail", "/etc/mailserver"]

# Ajouter des utilisateurs
RUN mkdir -p /tmp/docker-mailserver \
    && touch /tmp/docker-mailserver/postfix-accounts.cf \
    && echo "comptabilite@bigbusiness.loc|$(doveadm pw -s SHA512-CRYPT -p 'B1gBus1n3ss')" >> /tmp/docker-mailserver/postfix-accounts.cf \
    && echo "direction@bigbusiness.loc|$(doveadm pw -s SHA512-CRYPT -p 'N0P4ss84wd')" >> /tmp/docker-mailserver/postfix-accounts.cf \
    && echo "serviceclient@bigbusiness.loc|$(doveadm pw -s SHA512-CRYPT -p 'F1rsTP4ss')" >> /tmp/docker-mailserver/postfix-accounts.cf \
    && echo "flag-3num3r4tion-Succ3s@bigbusiness.loc|$(doveadm pw -s SHA512-CRYPT -p 'S3cuR3dP4ss')" >> /tmp/docker-mailserver/postfix-accounts.cf

# Copier le script de démarrage dans le conteneur
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Définir le script de démarrage comme point d'entrée
ENTRYPOINT ["/start.sh"]
