<?php
$my_url=escapeshellarg($my_url);
$parameters=escapeshellarg($_SERVER['QUERY_STRING']);
$message=shell_exec('/home/pi/php_root "'.$parameters.'">&1');
print_r($message);
?>
