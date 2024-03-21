#!/bin/bash

# Démarrer le serveur FTP en arrière-plan
python /pachev_ftp/pachev_ftp.py &

# Démarrer Apache en premier plan
apache2-foreground
