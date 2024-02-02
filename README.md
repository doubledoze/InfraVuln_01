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
Ce lab est un environnement disposant de quelques vulnérabilités assez basiques, l'objectif : trouver un maximum de flag.

Pour réussir l'objectif il faut se mettre dans la peau d'un auditeur de sécurité, la première étape c'est de cartographier son environnement, c'est à dire énumérer.
Connectez vous à la Kali, c'est une Kali sans outil, à vous d'installer les outils dont vous aurez besoin (nmap, curl, dig etc...)

La première étape c'est de cartographier l'environnement, donc identifier les machines, trouver les services qui tournent, leurs adresses IP et toute autre info utile. A vous de jouer avec NMAP dans un premier temps.

Lorsque vous aurez identifié les machines, vous devriez trouver un serveur DNS, est-ce qu'on peut obtenir des informations de celui-ci ?

Toujours dans l'énumération, vous avez du trouver un serveur web, qu'est-ce que vous pouvez obtenir comme info sur ce serveur ? Compliqué d'aller voir la page web sans interface graphique dans la Kali ? Vous pouvez y accéder avec votre machine hôte, ça fonctionne.

Et enfin vous avez normalement identifié un serveur de messagerie, même démarche : que trouvez-vous sur celui-ci ?

Parfait ! On va rentrer un peu plus dans le vif du sujet, dans ce lab, vous avez du identifier une machine cliente (Ubuntu), celle-ci n'à rien de particulier si ce n'est qu'à l'instant T elle est utilisée par quelqu'un, comment pourrais-ton faire pour voir son activité sur le réseau ? Pas d'idée ? En début d'année vous avez appris à faire des attaques MITM. Essayez pour voir !

Si tout s'est bien passé, à ce stade vous devriez avoir un premier flag et un identifiant/mot de passe, peut-être même deux identifiants/pass ?

Est-ce que vous êtes retourné voir le serveur web avec les nouvelles informations obtenues ? A ce stade vous devriez avoir deux flags...

Si votre MITM s'est bien passé, vous devriez avoir des informations en rapport avec un compte de messagerie non ? Sinon réessayez, la "victime" est toujours active sur le réseau...

Bon on est pas mal, vous avez compromis un compte de messagerie, on va faire un peu de social engineering. Essayez de convaincre la "direction" de vous envoyer les codes admin car vous avez besoin d'installer un logiciel... On va voir si ça passe...

Quel est le prénom du propriétaire de la boite que vous avez compromise ?

Bien joué ! C'est fini. Documentez l'ensemble de votre démarche et vos trouvailles dans un document que vous me rendrez.

Si tout s'est bien passé vous devriez avoir deux couples identifiant/mot de passe et trois flags.
