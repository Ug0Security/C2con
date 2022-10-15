cp agents-templates/template.sh agents-templates/$1
sed -i "s/ENDPOINT/$2/gi" agents-templates/$1
sed -i "s/MODE/$3/gi" agents-templates/$1
sed -i "s/RESPONSE/$4/gi" agents-templates/$1
cp agents-templates/$1 /tmp/$1
rm agents-templates/$1
echo "Agent saved at /tmp/$1"
echo """
----Config----
Endpoint:$2
Mode Param: $3
Response Param: $4
"""
