# Chemin du fichier qui stocke l'index actuel
INDEX_FILE="index_file.txt"

# Liste des sujets
subjects=("Coucou bebew" "Stp réponds moi" "Alors ???")
# Liste des corps de message
messages=("Bah alors tu me réponds plus ?" "Allez stp, je m'ennuie à la compta..." "Tu viens ce soir après le taf??")

# Lire l'index à partir du fichier, si le fichier n'existe pas, utiliser 0
if [ -f "$INDEX_FILE" ]; then
    index=$(cat "$INDEX_FILE")
else
    index=0
fi

# Calculer le prochain index
index=$(( (index + 1) % ${#subjects[@]} ))

# Sauvegarder le nouvel index dans le fichier
echo $index > "$INDEX_FILE"

# Sélectionner le sujet et le contenu en utilisant l'index
subject=${subjects[$index]}
message=${messages[$index]}

# Encodage en Base64
user=$(echo -n 'comptabilite@bigbusiness.loc' | base64)
pass=$(echo -n 'B1gBus1n3ss' | base64)

/usr/bin/expect <<EOF
# Démarre la session Telnet
spawn telnet 192.168.10.20 587
expect "220"

# Envoie EHLO
send "EHLO bigbusiness.loc\r"
expect "250"

# Authentification
send "AUTH LOGIN\r"
expect "334"
send "$user\r"
expect "334"
send "$pass\r"
expect "235"

# Envoi du mail
send "MAIL FROM: <comptabilite@bigbusiness.loc>\r"
expect "250"
send "RCPT TO: <serviceclient@bigbusiness.loc>\r"
expect "250"
send "DATA\r"
expect "354"
send "From: comptabilite@bigbusiness.loc\r"
send "To: serviceclient@bigbusiness.loc\r"
send "Subject: $subject\r"
send "\r"
send "$message\r"
send ".\r"
expect "250"
send "QUIT\r"
EOF
