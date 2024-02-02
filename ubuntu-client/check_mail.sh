#!/bin/bash

# Paramètres de connexion IMAP
IMAP_SERVER="192.168.10.20"
IMAP_USER="direction@bigbusiness.loc"
IMAP_PASS="N0P4ss84wd"

# Paramètres de connexion SMTP
SMTP_SERVER="192.168.10.20"
SMTP_USER="direction@bigbusiness.loc"
SMTP_PASS="N0P4ss84wd"

# Encodage en Base64 des identifiants SMTP pour Telnet
user=$(echo -n "$SMTP_USER" | base64)
pass=$(echo -n "$SMTP_PASS" | base64)

# Vérifier les nouveaux mails (INBOX peut être changé en fonction du dossier à vérifier)
new_mail_ids=$(curl -s -u "$IMAP_USER:$IMAP_PASS" "imap://$IMAP_SERVER/INBOX;UID=1:*" -X "SEARCH NEW")

# Extraire les IDs des mails non lus
mail_ids=$(echo $new_mail_ids | grep -o '[0-9]*')

for id in $mail_ids; do
    # Générer une réponse automatique
    response="Bonjour Bertrand, je comprends votre besoin et comme le service informatique est en formation, je vais vous faire confiance et vous donner le mot de passe : flag{Im_A_H4ck3r}, bonne journée et à très vite !\n"

    # Utiliser expect pour envoyer la réponse
    /usr/bin/expect <<EOF
    # Démarre la session Telnet
    spawn telnet $SMTP_SERVER 587
    expect "220"

    # Envoie EHLO
    send "EHLO mail.bigbusiness.loc\r"
    expect "250"

    # Authentification
    send "AUTH LOGIN\r"
    expect "334"
    send "$user\r"
    expect "334"
    send "$pass\r"
    expect "235"

    # Envoi du mail
    send "MAIL FROM: <$SMTP_USER>\r"
    expect "250"
    send "RCPT TO: comptabilite@bigbusiness.loc\r"
    expect "250"
    send "DATA\r"
    expect "354"
    send "From: $SMTP_USER\r"
    send "To: comptabilite@bigbusiness.loc\r"
    send "Subject: Re: mot de passe admin\r"
    send "\r"
    send "$response\r"
    send ".\r"
    expect "250"
    send "QUIT\r"
EOF
done
