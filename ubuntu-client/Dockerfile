FROM ubuntu:latest

# Installation de curl et de cron
RUN apt-get update && apt-get install -y curl cron expect telnet

# Définition des variables d'environnement pour l'identifiant et le mot de passe
ENV USERNAME=pc-01
ENV PASSWORD=YeOa8d03jxP

# Copie du script d'authentification dans l'image
COPY auth.sh /auth.sh
RUN chmod +x /auth.sh

# Copie du script d'envoi d'email dans l'image
COPY send_mail.sh /send_mail.sh
RUN chmod +x /send_mail.sh

# Mettre en oeuvre le script check_mail
COPY check_mail.sh /check_mail.sh
RUN chmod +x /check_mail.sh

# Configuration de cron pour exécuter l'auth WEB toutes les 2mn et les mails toutes les 5mn
RUN echo "*/2 * * * * /auth.sh \$USERNAME \$PASSWORD" > /etc/cron.d/auth-cron
RUN echo "*/5 * * * * /send_mail.sh" >> /etc/cron.d/auth-cron
RUN echo "* * * * * /check_mail.sh" > /etc/cron.d/auth-cron
RUN chmod 0644 /etc/cron.d/auth-cron
RUN crontab /etc/cron.d/auth-cron
RUN touch /var/log/cron.log

# Commande pour démarrer cron et suivre les logs
CMD cron && tail -f /var/log/cron.log
