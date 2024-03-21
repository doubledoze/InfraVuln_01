# Utiliser l'image Ubuntu comme base
FROM ubuntu:latest

# Mettre à jour les paquets et installer Samba
RUN apt-get update && apt-get install -y samba

# Créer les dossiers de partage et un fichier texte dans chacun
RUN mkdir -p /samba/Commun /samba/RH /samba/Direction \
    && echo "Bienvenue sur Commun !" > /samba/Commun/commun.txt \
    && echo "flag{Exp0s3d_F0ld3r}" > /samba/RH/rh.txt \
    && echo "flag{Im_a_D1r3ct0r}" > /samba/Direction/direction.txt \
    && chmod -R 0777 /samba/Commun /samba/RH \
    && chmod -R 0770 /samba/Direction

COPY BULLETIN-01.png /samba/RH/BULLETIN-01.png
RUN chmod -R 0777 /samba/RH

# Ajouter un utilisateur pour le dossier Direction
RUN useradd pc-01 -M -d /samba/Direction && echo "pc-01:YeOa8d03jxP" | chpasswd

# Copier le fichier de configuration Samba personnalisé
COPY smb.conf /etc/samba/smb.conf

# Exposer le port SMB
EXPOSE 445

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

# Définir le script entrypoint.sh comme point d'entrée
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
