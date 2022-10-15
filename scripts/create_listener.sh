cp listener-templates/template.php $1
sed -i "s/MODE/$2/" $1
sed -i "s/RESPONSE/$3/" $1
cp $1 /var/www/html/$1
rm $1
echo "Listener $1 deployed to /var/www/html/$1"
echo """
---CONFIG---
Endpoint: $1
Mode Param : $2
Response Param : $3
"""
