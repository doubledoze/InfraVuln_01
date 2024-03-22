# Utilisation de l'image de base Kali Linux
FROM kalilinux/kali-rolling

# Mise à jour des paquets et installation du serveur SSH
RUN apt update && apt install -y openssh-server

# Création du répertoire nécessaire pour sshd
RUN mkdir /var/run/sshd

# Configuration du mot de passe root
RUN echo 'root:hacker' | chpasswd

# Configuration de SSH pour autoriser la connexion en tant que root
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# Installation des outils réseau
RUN apt install -y iproute2 iputils-ping net-tools dnsutils nmap

# Exposition du port 22 pour SSH
EXPOSE 22

# Démarrage du serveur SSH
CMD ["/usr/sbin/sshd", "-D"]
