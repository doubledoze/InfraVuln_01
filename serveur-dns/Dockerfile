FROM ubuntu:20.04

# Installation de BIND9
RUN apt-get update && apt-get install -y bind9 dnsutils

# Copie des fichiers de configuration
COPY named.conf /etc/bind/named.conf
COPY db.bigbusiness.loc /etc/bind/db.bigbusiness.loc

# Expose les ports DNS
EXPOSE 53/udp 53/tcp

# Commande de démarrage pour BIND9 en mode foreground
CMD ["named", "-g"]
