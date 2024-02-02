#!/bin/bash

# Démarrer Apache en arrière-plan
apache2ctl start

# Démarrer supervisord en avant-plan
exec supervisord -c /etc/supervisor/supervisord.conf
