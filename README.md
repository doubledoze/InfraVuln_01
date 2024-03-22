# Infrastructure Vulnérable Niveau 1

## Pour préparer l'environnement il suffit de lancer la commande suivante :
`sudo bash start.sh`
Pour l'arrêter :
`CTRL + C`

## Connexion à la Kali Hacker : 
`ssh root@localhost -p 2222`
ID : `root`
PASS : `hacker`

## Démarche à suivre 
Ce lab est un environnement disposant de quelques vulnérabilités assez basiques, l'objectif : **trouver un maximum de flag.**

Pour réussir l'objectif il faut se mettre dans la peau d'un pentester et suivre la bonne démarche, la première étape c'est de cartographier son environnement, c'est à dire énumérer.
Connectez vous à la Kali, c'est une Kali sans outil, à vous d'installer les outils dont vous aurez besoin (nmap, curl, dig etc...)

Il faut donc commencer par **identifier les machines du LAN**, **identifier les services de ces machines**, leurs adresses IP, ports, noms de services et toute autre info utile. A vous de jouer, commencez avec NMAP dans un premier temps.

Lorsque vous aurez identifié les machines, vous devriez trouver un **serveur DNS**, est-ce qu'on peut obtenir des informations de celui-ci ? (Essayez de vous approprier l'outil **DIG**)

A ce stade vous devriez avoir obtenu un premier **FLAG**.

Toujours dans l'énumération, vous avez du trouver un ou plusieurs **serveurs web**, qu'est-ce que vous pouvez obtenir comme info sur ces serveurs ? Compliqué d'aller voir la page web sans interface graphique dans la Kali ? Vous pouvez y accéder avec votre machine hôte, ça fonctionne.

Un des deux **serveurs WEB** vous permet d'obtenir un **FLAG** si vous trouvez la vulnérabilité et que vous l'exploitez, un indice : **GLPI**

Et enfin vous avez normalement identifié un **serveur de messagerie**, même démarche : que trouvez-vous sur celui-ci ?

Parfait ! On va rentrer un peu plus dans le vif du sujet, dans ce lab, vous avez du identifier une machine cliente (Ubuntu), celle-ci n'à rien de particulier si ce n'est qu'à l'instant T elle est utilisée par quelqu'un, comment pourrais-ton faire pour voir son activité sur le réseau ? Pas d'idée ? Vous avez normalement appris à faire des attaques **MITM**. Essayez pour voir ! Et interprétez votre fichier de capture réseau avec Wireshark (nécessite de rappatrier le PCAP sur votre hôte).

Si tout s'est bien passé, à ce stade vous devriez avoir **un ou deux flag** et un **identifiant/mot de passe** (obtenu via le MITM), peut-être même **deux** identifiants/pass ?

Est-ce que vous êtes retourné voir le serveur web avec les nouvelles informations obtenues ? A ce stade vous devriez avoir **deux flags**...

Si votre MITM s'est bien passé, vous devriez avoir des informations en rapport avec un **compte de messagerie** non ? Sinon réessayez, la "victime" est toujours active sur le réseau...

Bon on est pas mal, vous avez normalement **compromis un compte de messagerie**, on va faire un peu de social engineering. Essayez en utilisant ce compte de messagerie compromis, de convaincre la "direction" de vous envoyer les codes admin car vous avez besoin d'installer un logiciel... On va voir si ça passe...

Quel est le prénom du propriétaire de la boite que vous avez compromise ?

Retournons sur la phase d'énumération, vous avez potentiellement identifié un serveur de stockage utilisant Samba, il y a deux flags à trouver sur ce serveur. Et un autre sur le serveur-web (ça dépend si vous avez trouvé la vuln ou pas...)

Bien joué ! C'est fini. Documentez l'ensemble de votre démarche et vos trouvailles dans un document, c'est votre **write-up**.

**Résultat final :**
Deux identifiants/pass et sept flags
