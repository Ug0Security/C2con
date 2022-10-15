
if [ $1 == "shell" ]; then
echo "Building $1 agent"
cp agents-templates/template.sh agents-templates/$2
sed -i "s/ENDPOINT/$3/gi" agents-templates/$2
sed -i "s/MODE/$4/gi" agents-templates/$2
sed -i "s/RESPONSE/$5/gi" agents-templates/$2
cp agents-templates/$2 /tmp/$2
rm agents-templates/$2
echo "Agent saved at /tmp/$2"
echo """
----Config----
Endpoint:$3
Mode Param: $4
Response Param: $5
"""

elif [ $1 == "python" ]; then
cp agents-templates/template.py agents-templates/$2
sed -i "s/ENDPOINT/$3/gi" agents-templates/$2
sed -i "s/MODE/$4/gi" agents-templates/$2
sed -i "s/RESPONSE/$5/gi" agents-templates/$2
cp agents-templates/$2 /tmp/$2
rm agents-templates/$2
echo "Agent saved at /tmp/$2"
echo """
----Config----
Endpoint:$3
Mode Param: $4
Response Param: $5
"""
else
echo "No Agent of this type"
fi
