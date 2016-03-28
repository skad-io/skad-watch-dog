<?php
$my_url=escapeshellarg($my_url);
$script=escapeshellarg($_GET['script']);
$parameters=escapeshellarg($_SERVER['QUERY_STRING']);
$message=shell_exec('/home/pi/php_root "'.$script.'" "'.$parameters.'">&1');
print_r($message);
?>
