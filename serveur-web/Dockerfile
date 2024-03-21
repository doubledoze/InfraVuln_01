FROM debian:jessie

MAINTAINER t0kx <t0kx@protonmail.ch>

# Adjust sources.list to use archive and disable security checks
RUN echo 'Acquire::Check-Valid-Until "false";' > /etc/apt/apt.conf.d/99no-check-valid-until && \
    echo "deb http://archive.debian.org/debian/ jessie main\ndeb http://archive.debian.org/debian-security/ jessie/updates main" > /etc/apt/sources.list

# Install debian stuff
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --allow-unauthenticated \
    wget apache2 php5 gcc make \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Configure vuln application
RUN wget ftp://ftp.proftpd.org/distrib/source/proftpd-1.3.5.tar.gz && \
    tar xfz proftpd-1.3.5.tar.gz && \
    cd proftpd-1.3.5 && \
    ./configure --with-modules=mod_copy && \
    make && make install

# Copie des fichiers du site
COPY src/ /var/www/html/
RUN rm /var/www/html/index.html
RUN echo "flag{FTP00_H4ck3r}" > /flag.txt
RUN chmod 777 /flag.txt

# Variables d'environnement pour le nom d'utilisateur, le mot de passe, et les adresses IP
ENV USERNAME=pc-01
ENV PASSWORD=YeOa8d03jxP
ENV IP_PC01=192.168.10.4
ENV IP_HACKER=192.168.10.2

RUN chmod 777 -R /var/www/html/

EXPOSE 21 80

COPY main.sh /
RUN chmod +x /main.sh
ENTRYPOINT ["/main.sh"]
CMD ["default"]
