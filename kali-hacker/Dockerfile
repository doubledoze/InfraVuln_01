FROM kalilinux/kali-rolling

RUN apt update && apt install -y openssh-server
RUN mkdir /var/run/sshd
RUN echo 'root:hacker' | chpasswd

RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# Mise à jour de la liste des paquets et installation des outils Kali Linux
RUN apt -y install kali-tools-top10 \
    && apt-get clean

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
