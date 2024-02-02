<?php
$username = $_POST['username'];
$password = $_POST['password'];

$envUsername = getenv('USERNAME');
$envPassword = getenv('PASSWORD');
$ipPc01 = getenv('IP_PC01');
$ipHacker = getenv('IP_HACKER');

if ($username == $envUsername && $password == $envPassword) {
    $ipSource = $_SERVER['REMOTE_ADDR'];
    if ($ipSource == $ipPc01) {
        echo "Bienvenue PC-01 sur l'intranet BigBusiness";
    } elseif ($ipSource == $ipHacker) {
        echo "Bienvenue Hacker, voici le flag lab{H4ck3d_W3b_S3rv1ce}";
    } else {
        echo "Authentification réussie, mais votre IP n'est pas reconnue.";
    }
} else {
    echo "Échec d'authentification";
}
?>
