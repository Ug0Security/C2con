
echo --Create tmp files and setting files permissions--
touch /tmp/C2CON-ping.txt
chmod 666 /tmp/C2CON-ping.txt

touch /tmp/C2CON-res.txt
chmod 666 /tmp/C2CON-res.txt

touch /tmp/C2CON-templistener
chmod 666 /tmp/C2CON-templistener

touch /tmp/C2CON-listener.txt
chmod 666 /tmp/C2CON-listener.txt

touch /tmp/C2CON-cmds.txt
chmod 666 /tmp/C2CON-cmds.txt

touch /tmp/C2CON-temp
chmod 666 /tmp/C2CON-temp

touch /tmp/C2CON-temping
chmod 666 /tmp/C2CON-temping

mkdir /tmp/C2CON-uploads
chmod 666 /tmp/C2CON-uploads/

echo --Installing Django-extension \& Werkzeug--

pip install django-extensions Werkzeug

echo --Installing web admin interface--
mkdir /var/www/html/C2CON/
mkdir /var/www/html/C2CON/admin/
cp web/admin/readres.php /var/www/html/C2CON/admin/readres.php
cp web/admin/readping.php /var/www/html/C2CON/admin/readping.php
cp web/admin/readcmds.php /var/www/html/C2CON/admin/readcmds.php

cp web/admin/admin.php /var/www/html/C2CON/admin/admin.php

echo --starting apache service--
service apache2 start
